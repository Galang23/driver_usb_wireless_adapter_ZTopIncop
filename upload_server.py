#!/usr/bin/env python3
"""Simple HTTP file upload server.

Run: python3 upload_server.py
Access from browser: http://192.168.10.1:8000
"""

import http.server
import cgi
import os
import html

UPLOAD_DIR = os.path.dirname(os.path.abspath(__file__))
PORT = 8000

HTML_FORM = """<!DOCTYPE html>
<html>
<head><title>File Upload</title>
<style>
body{font-family:monospace;max-width:600px;margin:50px auto;padding:0 20px}
input,button{font-size:16px;padding:8px;margin:5px 0}
button{background:#007bff;color:#fff;border:none;cursor:pointer}
button:hover{background:#0056b3}
.success{color:green}.error{color:red}
</style>
</head>
<body>
<h2>Upload File</h2>
<form method="POST" enctype="multipart/form-data">
<input type="file" name="file" required><br>
<button type="submit">Upload</button>
</form>
<p>Upload dir: {dir}</p>
<hr>
<h3>Files:</h3>
{files}
</body>
</html>"""

class UploadHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        files = sorted(os.listdir(UPLOAD_DIR))
        file_list = "<ul>" + "".join(
            f'<li><a href="/{html.escape(f)}">{html.escape(f)}</a> ({os.path.getsize(os.path.join(UPLOAD_DIR, f))} bytes)</li>'
            for f in files if os.path.isfile(os.path.join(UPLOAD_DIR, f))
        ) + "</ul>"
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        self.wfile.write(HTML_FORM.format(dir=UPLOAD_DIR, files=file_list).encode())

    def do_POST(self):
        content_type = self.headers.get("Content-Type", "")
        if "multipart/form-data" not in content_type:
            self.send_error(400, "Expected multipart/form-data")
            return

        form = cgi.FieldStorage(fp=self.rfile, headers=self.headers, environ={"REQUEST_METHOD": "POST"})
        fileitem = form["file"]
        if not fileitem.filename:
            self.send_error(400, "No file selected")
            return

        filename = os.path.basename(fileitem.filename)
        filepath = os.path.join(UPLOAD_DIR, filename)
        with open(filepath, "wb") as f:
            f.write(fileitem.file.read())

        size = os.path.getsize(filepath)
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        self.wfile.write(f'<!DOCTYPE html><html><body><p class="success">Uploaded: {html.escape(filename)} ({size} bytes)</p><a href="/">Back</a></body></html>'.encode())

    def log_message(self, format, *args):
        print(f"[{self.log_date_time_string()}] {args[0]}")

if __name__ == "__main__":
    server = http.server.HTTPServer(("0.0.0.0", PORT), UploadHandler)
    print(f"Upload server running on http://0.0.0.0:{PORT}")
    print(f"Files saved to: {UPLOAD_DIR}")
    print("Press Ctrl+C to stop")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped.")
        server.server_close()
