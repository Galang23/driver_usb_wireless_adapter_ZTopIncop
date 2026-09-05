savedcmd_nic/utility/zt_timer.o := gcc -Wp,-MMD,nic/utility/.zt_timer.o.d -nostdinc -I/usr/lib/modules/7.2.3-zen1-2-zen/build/arch/x86/include -I/usr/lib/modules/7.2.3-zen1-2-zen/build/arch/x86/include/generated -I/usr/lib/modules/7.2.3-zen1-2-zen/build/include -I/usr/lib/modules/7.2.3-zen1-2-zen/build/include -I/usr/lib/modules/7.2.3-zen1-2-zen/build/arch/x86/include/uapi -I/usr/lib/modules/7.2.3-zen1-2-zen/build/arch/x86/include/generated/uapi -I/usr/lib/modules/7.2.3-zen1-2-zen/build/include/uapi -I/usr/lib/modules/7.2.3-zen1-2-zen/build/include/generated/uapi -include /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler-version.h -include /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/kconfig.h -include /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler_types.h -D__KERNEL__ -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -std=gnu11 -fms-extensions -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a -mno-avx2 -fno-tree-vectorize -fcf-protection=branch -fno-jump-tables -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -march=x86-64 -mtune=generic -mno-red-zone -mcmodel=kernel -mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__ref_stack_chk_guard -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunction-return=thunk-extern -fno-jump-tables -mharden-sls=all -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -O3 -fno-allow-store-data-races -fstack-protector-strong -ftrivial-auto-var-init=zero -fzero-init-padding-bits=all -fno-stack-clash-protection -fdiagnostics-show-context=2 -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -fmin-function-alignment=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=2048 -Wno-main -Wno-type-limits -Wno-dangling-pointer -Wvla-larger-than=1 -Wno-pointer-sign -Wcast-function-type -Wno-unterminated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wenum-conversion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-missing-field-initializers -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -g -gdwarf-5 -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/ -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/os_porting -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/hif -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/netdev -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/cfg80211 -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/iw -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/linux/pwr -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/nic -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/nic/utility -I/home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/nic/p2p -DZT_DEBUG_LEVEL=0 -D'ZT_VERSION="V1.2.xxx.xxxxxxxx"' -DCONFIG_FW_FILE -DCONFIG_ZT9101XV20_SUPPORT -DCONFIG_ZT9101XV30_SUPPORT -DCONFIG_USB_FLAG -DCFG_ENABLE_AP_MODE -DCFG_ENABLE_ADHOC_MODE -DCFG_ENABLE_MONITOR_MODE -DCONFIG_IOCTL_CFG80211 -DZT_USE_CFG80211_STA_EVENT -DZT_WEP_AUTH_ENABLE_WEXT  -DMODULE  -DKBUILD_BASENAME='"zt_timer"' -DKBUILD_MODNAME='"zt9101_ztopmac_usb"' -D__KBUILD_MODNAME=zt9101_ztopmac_usb -c -o nic/utility/zt_timer.o nic/utility/zt_timer.c  

source_nic/utility/zt_timer.o := nic/utility/zt_timer.c

deps_nic/utility/zt_timer.o := \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler_types.h \
    $(wildcard include/config/DEBUG_INFO_BTF) \
    $(wildcard include/config/PAHOLE_HAS_BTF_TAG) \
    $(wildcard include/config/FUNCTION_ALIGNMENT) \
    $(wildcard include/config/CC_HAS_SANE_FUNCTION_ALIGNMENT) \
    $(wildcard include/config/X86_64) \
    $(wildcard include/config/ARM64) \
    $(wildcard include/config/LD_DEAD_CODE_DATA_ELIMINATION) \
    $(wildcard include/config/LTO_CLANG) \
    $(wildcard include/config/HAVE_ARCH_COMPILER_H) \
    $(wildcard include/config/KCSAN) \
    $(wildcard include/config/CC_HAS_ASSUME) \
    $(wildcard include/config/CC_HAS_COUNTED_BY) \
    $(wildcard include/config/FORTIFY_SOURCE) \
    $(wildcard include/config/UBSAN_BOUNDS) \
    $(wildcard include/config/CC_HAS_COUNTED_BY_PTR) \
    $(wildcard include/config/CC_HAS_MULTIDIMENSIONAL_NONSTRING) \
    $(wildcard include/config/CFI) \
    $(wildcard include/config/ARCH_USES_CFI_GENERIC_LLVM_PASS) \
    $(wildcard include/config/CC_HAS_BROKEN_COUNTED_BY_REF) \
    $(wildcard include/config/CC_HAS_ASM_INLINE) \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler-context-analysis.h \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler_attributes.h \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/linux/compiler-gcc.h \
    $(wildcard include/config/ARCH_USE_BUILTIN_BSWAP) \
    $(wildcard include/config/SHADOW_CALL_STACK) \
    $(wildcard include/config/KCOV) \
    $(wildcard include/config/CC_HAS_TYPEOF_UNQUAL) \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/arch/x86/include/asm/percpu_types.h \
    $(wildcard include/config/SMP) \
    $(wildcard include/config/CC_HAS_NAMED_AS) \
    $(wildcard include/config/USE_X86_SEG_SUPPORT) \
  /usr/lib/modules/7.2.3-zen1-2-zen/build/include/asm-generic/percpu_types.h \
  /home/adhi/Dokumen/projects/driver_usb_wireless_adapter_ZTopIncop/os/zt_typedef.h \

nic/utility/zt_timer.o: $(deps_nic/utility/zt_timer.o)

$(deps_nic/utility/zt_timer.o):
