#!/bin/bash
# UUID root
ROOT="$(lsblk -flp | grep -P '/(?!\S)' | awk '{print $4}')"
# Disk/part /boot
DISK="$(lsblk -flp | grep -P '/boot' | awk '{print $1}' | cut -c -12)"
PART="$(lsblk | grep -P '/boot' | awk '{print $1}' | cut -c 15-)"
SWAP="$(lsblk -f | grep 'SWAP' | awk '{print $4}')"
LOADER="/vmlinuz-linux"
CMD="sudo efibootmgr -v\
  -d $DISK -p $PART  -c -L \"Arch EFI\"\
  -l $LOADER  -u\
  \"root=UUID=$ROOT resume=UUID=$SWAP rw loglevel=3 quiet mem_sleep_default=s2idle nvidia-drm.modeset=1 nvidia-drm.fbdev=1 udev.log_level=3 initrd=/intel-ucode.img initrd=/initramfs-linux.img\""
echo $CMD
echo ""
read -p "Apply? [y/N] " y
if [[ "$y" =~ [y] ]]; then
  echo ""
  eval $CMD
  exit 0
fi
exit 0
