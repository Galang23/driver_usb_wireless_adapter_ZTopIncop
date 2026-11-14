savedcmd_zt9101_ztopmac_usb.o := ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments   -r -o zt9101_ztopmac_usb.o @zt9101_ztopmac_usb.mod  ; /usr/lib/modules/7.3.4-zen2-1-zen/build/tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --prefix=16 --orc --retpoline --rethunk --sls --static-call --uaccess  --link  --module zt9101_ztopmac_usb.o

zt9101_ztopmac_usb.o: $(wildcard /usr/lib/modules/7.3.4-zen2-1-zen/build/tools/objtool/objtool)
