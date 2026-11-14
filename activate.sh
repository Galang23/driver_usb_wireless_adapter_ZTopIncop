#!/usr/bin/env bash
#
# Activate the ZTopInc USB WiFi driver that matches the running kernel.
#
# Usage:
#   sudo ./activate.sh [auto|lts|zen] [--install] [--unload]
#
#   auto       detect the flavour from `uname -r` (default)
#   lts        use the linux-lts build
#   zen        use the linux-zen build
#   --install  install into /lib/modules/$(uname -r)/updates and use modprobe
#              (survives until the kernel package is removed)
#   --unload   unload the driver instead of loading it
#
# If no matching build exists in dist/, or it was built for another kernel
# release, the module is rebuilt for the running kernel first.
#
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODULE="zt9101_ztopmac_usb.ko"
MODULE_NAME="zt9101_ztopmac_usb"
CFG="${CFG:-$ROOT/wifi.cfg}"
KREL="$(uname -r)"
JOBS="${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)}"

usage() {
    cat <<'EOF'
Usage: sudo ./activate.sh [auto|lts|zen] [--install] [--unload]

  auto       detect the flavour from `uname -r` (default)
  lts        use the linux-lts build
  zen        use the linux-zen build
  --install  install into /lib/modules/$(uname -r)/updates and use modprobe
  --unload   unload the driver instead of loading it
EOF
}

# Build the module for exactly the running kernel and update dist/<flavor>.
build_for_running_kernel() {
    local flavor="$1"
    local ksrc="/lib/modules/$KREL/build"
    local backup

    if [ ! -d "$ksrc" ]; then
        echo "!! kernel headers not found: $ksrc" >&2
        echo "   install linux-headers-$KREL (or the matching *-headers package)" >&2
        exit 1
    fi

    # `make clean` deletes *.ko files inside the module tree, including the
    # previously built flavours in dist/.  Back them up and merge them back.
    backup="$(mktemp -d "${TMPDIR:-/tmp}/zt9101-dist.XXXXXX")"
    if [ -d "$ROOT/dist" ]; then
        cp -a "$ROOT/dist/." "$backup/"
    fi

    echo "==> Building $flavor module for running kernel $KREL"
    make -C "$ROOT" KSRC="$ksrc" clean >/dev/null
    make -C "$ROOT" KSRC="$ksrc" -j"$JOBS"

    install -d "$ROOT/dist/$flavor"
    cp -a "$backup/." "$ROOT/dist/"
    install -m 644 "$ROOT/$MODULE" "$ROOT/dist/$flavor/$MODULE"
    printf '%s\n' "$KREL" > "$ROOT/dist/$flavor/kernel-version"
    rm -rf "$backup"
}

flavor_arg="auto"
mode="load"
for arg in "$@"; do
    case "$arg" in
        auto|lts|zen) flavor_arg="$arg" ;;
        --install)    mode="install" ;;
        --unload)     mode="unload" ;;
        -h|--help)    usage; exit 0 ;;
        *)
            echo "!! unknown option: $arg" >&2
            usage >&2
            exit 2
            ;;
    esac
done

if [ "$(id -u)" -ne 0 ]; then
    echo "!! run this script as root (sudo $0 $flavor_arg)" >&2
    exit 1
fi

if [ "$flavor_arg" = "auto" ]; then
    case "$KREL" in
        *-lts)   flavor="lts" ;;
        *-zen*)  flavor="zen" ;;
        *)
            echo "!! unsupported kernel flavour: $KREL" >&2
            echo "   only linux-lts (*-lts) and linux-zen (*-zen*) are supported" >&2
            exit 1
            ;;
    esac
else
    flavor="$flavor_arg"
fi

if [ "$mode" = "unload" ]; then
    if lsmod | awk '{print $1}' | grep -qx "$MODULE_NAME"; then
        echo "==> Unloading $MODULE_NAME"
        if ! rmmod "$MODULE_NAME"; then
            echo "!! rmmod failed; the interface may still be in use" >&2
            exit 1
        fi
    else
        echo "==> $MODULE_NAME is not loaded"
    fi
    exit 0
fi

ko="$ROOT/dist/$flavor/$MODULE"
vermagic="$(modinfo -F vermagic "$ko" 2>/dev/null || true)"

if [ ! -f "$ko" ] || [ "${vermagic%% *}" != "$KREL" ]; then
    build_for_running_kernel "$flavor"
fi

if [ ! -f "$CFG" ]; then
    echo "!! config file not found: $CFG" >&2
    echo "   set CFG=/path/to/wifi.cfg to override" >&2
    exit 1
fi

if lsmod | awk '{print $1}' | grep -qx "$MODULE_NAME"; then
    echo "==> Unloading existing $MODULE_NAME"
    if ! rmmod "$MODULE_NAME"; then
        echo "!! rmmod failed; the interface may still be in use" >&2
        exit 1
    fi
fi

if [ "$mode" = "install" ]; then
    dest="/lib/modules/$KREL/updates"
    echo "==> Installing $ko -> $dest/"
    install -d "$dest"
    install -m 644 "$ko" "$dest/$MODULE"
    depmod -a "$KREL"
    if ! modprobe "$MODULE_NAME" cfg="$CFG"; then
        echo "!! modprobe failed; check 'dmesg | tail'" >&2
        exit 1
    fi
else
    echo "==> Loading $ko ($flavor, $KREL)"
    if ! insmod "$ko" cfg="$CFG"; then
        echo "!! insmod failed; check 'dmesg | tail'" >&2
        exit 1
    fi
fi

if lsmod | awk '{print $1}' | grep -qx "$MODULE_NAME"; then
    echo "==> Driver activated ($flavor, $KREL)"
    echo "    interface: $(iw dev 2>/dev/null | awk '/Interface/{print $2}' | paste -sd' ' -)"
else
    echo "!! module load failed; check 'dmesg | tail'" >&2
    exit 1
fi
