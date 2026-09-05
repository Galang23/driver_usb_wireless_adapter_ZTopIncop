# Changelog

## [Unreleased] - 2026-09-05

### Fixed
- Fixed compilation for Linux kernel 7.2.3-zen1-2-zen
- Added `ccflags-y` include paths to top-level Makefile for kbuild compatibility
- Added preprocessor defines (`ZT_DEBUG_LEVEL`, `ZT_VERSION`, `CONFIG_FW_FILE`, etc.) to `ccflags-y`
- Updated timer API: replaced `del_timer()` with `timer_delete_sync()` (kernel 6.5+)
- Updated string API: replaced `strncpy` with `strscpy` (strncpy removed in kernel 7.2)
- Generated `wifi_cfg.c` from `wifi.cfg` using `xxd -i`
- Updated cfg80211 ops function signatures for kernel 7.2:
  - `set_tx_power`: added `radio_idx` parameter
  - `get_tx_power`: added `radio_idx` and `link_id` parameters
  - `add_key`, `get_key`, `del_key`: changed to `struct wireless_dev *` and added `link_id`
  - `get_station`: changed to `struct wireless_dev *`
  - `set_wiphy_params`: added `radio_idx` parameter
  - `add_station`, `del_station`, `change_station`, `dump_station`: changed to `struct wireless_dev *`
  - `set_monitor_channel`: updated signature
  - `remain_on_channel`: added `rx_addr` parameter
- Updated `cfg80211_new_sta` and `cfg80211_del_sta` calls to use `struct wireless_dev *`
- Fixed endian macros: changed `CONFIG_LITTLE_ENDIAN`/`CONFIG_BIG_ENDIAN` to `__LITTLE_ENDIAN`/`__BIG_ENDIAN` in `nic/sec.h`
