#include <linux/module.h>
#include <linux/export-internal.h>
#include <linux/compiler.h>

MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};


MODULE_INFO(depends, "cfg80211");

MODULE_ALIAS("usb:v350Bp9101d*dc*dsc*dp*icFFiscFFipFFin*");
MODULE_ALIAS("usb:v2310p9086d*dc*dsc*dp*icFFiscFFipFFin*");
MODULE_ALIAS("usb:v350Bp9086d*dc*dsc*dp*icFFiscFFipFFin*");
MODULE_ALIAS("usb:v350Bp9106d*dc*dsc*dp*icFFiscFFipFFin*");

MODULE_INFO(srcversion, "CDF8E425B4BFF49F88044E5");
