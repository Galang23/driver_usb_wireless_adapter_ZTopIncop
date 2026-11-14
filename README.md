
# Driver WiFi ZTopInc for Linux

This repository provides a **Linux WiFi driver** for the **ZTopInc 802.11n USB wireless adapter NIC** (**ID: 350b:9101**), with support for both **linux-lts (6.18)** and **linux-zen (7.3)** kernels.

It is a fork of [driver_wifi_ztopinc](https://codeberg.org/sallecta/driver_wifi_ztopinc.git) with **fixes and kernel support improvements**.

## Features & Fixes
- **Fixed** an issue in `usb.c` at line 1114 and related sections.
- **Optimized** for **linux-zen** and **linux-lts**.
- Updated **cfg80211 API** for kernels 7.2 and 7.3, while keeping the 6.18 LTS API working.
- Fixed **timer API** (`del_timer` → `timer_delete_sync`).
- Fixed **string API** (`strncpy` → `strscpy`).
- Fixed **endian detection** macros for kernel build system.

## Installation Guide

### Step 1: Install Dependencies
Before compiling the **Linux WiFi driver**, install the required packages:

```bash
sudo apt update
sudo apt install dkms build-essential git linux-headers-$(uname -r)
```

### Step 2: Clone and Build the Driver
Run the following commands to clone this repository and build both kernel variants:

```bash
git clone https://github.com/apris2/driver_usb_wireless_adapter_ZTopIncop.git
cd driver_usb_wireless_adapter_ZTopIncop
./build.sh
```

`build.sh` produces two modules:

```text
dist/lts/zt9101_ztopmac_usb.ko   # for linux-lts
dist/zen/zt9101_ztopmac_usb.ko   # for linux-zen
```

You can also build only one variant with `./build.sh lts` or `./build.sh zen`,
or build for the currently running kernel with the usual `make`.

### Step 3: Activate the Driver
`activate.sh` selects the module that matches the running kernel, rebuilds it
automatically if necessary, and loads it:

```bash
sudo ./activate.sh          # auto-detect lts/zen
sudo ./activate.sh zen      # force the linux-zen build
sudo ./activate.sh lts      # force the linux-lts build
```

Use `--install` to install the module under `/lib/modules/$(uname -r)/updates`
and load it with `modprobe`, or `--unload` to remove it:

```bash
sudo ./activate.sh --install
sudo ./activate.sh --unload
```

The default configuration file is `./wifi.cfg`; override it with
`CFG=/path/to/wifi.cfg sudo -E ./activate.sh`.

### Step 4: Troubleshooting
If the driver fails to load due to **module signature errors**, disable **Secure Boot** in your BIOS.
If the build fails, make sure the headers for the target kernel are installed
(`linux-lts-headers`, `linux-zen-headers`, or `linux-headers-$(uname -r)`).

## System Compatibility
- **Device**: ZTopInc 802.11n USB Wireless Adapter (**ID: 350b:9101**)
- **Kernel**: linux-lts 6.18.x and linux-zen 7.3.x

## Images
![ZTopInc WiFi Adapter](https://github.com/apris2/driver_usb_wireless_adapter_ZTopIncop/raw/main/IMG1.jpg)
![ZTopInc WiFi Adapter](https://github.com/apris2/driver_usb_wireless_adapter_ZTopIncop/raw/main/IMG2.jpg)

---

For detailed changes, see [CHANGELOG.md](CHANGELOG.md).
