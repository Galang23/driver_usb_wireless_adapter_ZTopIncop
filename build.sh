#!/usr/bin/env bash
#
# Build the ZTopInc USB WiFi driver for the installed LTS and linux-zen
# kernel flavours.
#
# Usage:
#   ./build.sh            # build both flavours
#   ./build.sh lts        # build linux-lts only
#   ./build.sh zen        # build linux-zen only
#
# The resulting modules are stored in:
#   dist/lts/zt9101_ztopmac_usb.ko
#   dist/zen/zt9101_ztopmac_usb.ko
#
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DIST="$ROOT/dist"
MODULE="zt9101_ztopmac_usb.ko"
JOBS="${JOBS:-$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)}"

# Kernel `make clean` also removes *.ko files below the module directory,
# so keep finished modules outside the tree until every build is done.
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/zt9101-build.XXXXXX")"

publish_and_cleanup() {
    local flavor
    for flavor in lts zen; do
        [ -f "$STAGE/$flavor/$MODULE" ] || continue
        install -d "$DIST/$flavor"
        install -m 644 "$STAGE/$flavor/$MODULE" "$DIST/$flavor/$MODULE"
        install -m 644 "$STAGE/$flavor/kernel-version" \
            "$DIST/$flavor/kernel-version"
    done
    rm -rf "$STAGE"
}
trap publish_and_cleanup EXIT

usage() {
    echo "Usage: $0 [all|lts|zen]"
}

# Print the build directory of the newest installed kernel matching pattern.
find_ksrc() {
    local pattern="$1" build kver
    local -a matches=()

    for build in /lib/modules/*/build; do
        [ -d "$build" ] || continue
        kver="$(basename "$(dirname "$build")")"
        case "$kver" in
            $pattern) matches+=("$kver|$build") ;;
        esac
    done

    [ "${#matches[@]}" -gt 0 ] || return 1
    printf '%s\n' "${matches[@]}" | sort -V | tail -n 1 | cut -d'|' -f2-
}

build_flavor() {
    local flavor="$1" ksrc="$2" kver

    if [ ! -d "$ksrc" ]; then
        echo "!! $flavor: kernel headers not found ($ksrc)" >&2
        return 1
    fi

    kver="$(basename "$(dirname "$ksrc")")"
    echo "==> Building $flavor for $kver"

    make -C "$ROOT" KSRC="$ksrc" clean >/dev/null
    make -C "$ROOT" KSRC="$ksrc" -j"$JOBS"

    install -d "$STAGE/$flavor"
    install -m 644 "$ROOT/$MODULE" "$STAGE/$flavor/$MODULE"
    printf '%s\n' "$kver" > "$STAGE/$flavor/kernel-version"
    echo "    built for $kver"
}

target="${1:-all}"
case "$target" in
    all|lts|zen) ;;
    -h|--help) usage; exit 0 ;;
    *) usage >&2; exit 2 ;;
esac

status=0

if [ "$target" = "all" ] || [ "$target" = "lts" ]; then
    if ksrc="$(find_ksrc '*-lts')"; then
        build_flavor lts "$ksrc" || status=1
    else
        echo "!! lts: no installed kernel headers matching '*-lts'" >&2
        echo "   install the linux-lts and linux-lts-headers packages" >&2
        status=1
    fi
fi

if [ "$target" = "all" ] || [ "$target" = "zen" ]; then
    if ksrc="$(find_ksrc '*-zen*')"; then
        build_flavor zen "$ksrc" || status=1
    else
        echo "!! zen: no installed kernel headers matching '*-zen*'" >&2
        echo "   install the linux-zen and linux-zen-headers packages" >&2
        status=1
    fi
fi

exit "$status"
