#!/bin/sh
append DRIVERS "mt7610e"

. /lib/wifi/ralink_common.sh

prepare_mt7610e() {
	prepare_ralink_wifi mt7610e
}

scan_mt7610e() {
	scan_ralink_wifi mt7610e mt7610e
}

disable_mt7610e() {
	disable_ralink_wifi mt7610e
}

enable_mt7610e() {
	enable_ralink_wifi mt7610e mt7610e
}

detect_mt7610e() {
#	detect_ralink_wifi mt7610e mt7610e
	hostname=`uci -q get system.@system[0].hostname`
	ssid=${hostname:-ApFree}_5G-`ifconfig eth0 | grep HWaddr | cut -c 51- | sed 's/://g'`
	cd /sys/module
	[ -d $module ] || return
        [ -e /etc/config/wireless ] && return
        cat <<EOF
config wifi-device      mt7610e
        option type     mt7610e
        option vendor   ralink
        option band     5G
        option channel  153
	option autoch   2
	option version	1

config wifi-iface
        option device   mt7610e
        option ifname   rai0
        option network  lan
        option mode     ap
        option ssid     $ssid
        option encryption none
        option key      12345678
EOF


}


