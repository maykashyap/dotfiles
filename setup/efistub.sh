#!/bin/bash
# UUID root
ROOT="$(lsblk -flp | grep -P '/(?!\S)' | awk '{print $4}')"
# Disk/part /boot
DISK="$(lsblk -flp | grep -P '/boot' | awk '{print $1}' | cut -c -12)"
PARTITION="$(lsblk | grep -P '/boot' | awk '{print $1}' | cut -c 15-)"
#UUID Swap space
SWAP="$(lsblk -f | grep 'SWAP' | awk '{print $4}')"

#Select kernel
LOADERS=($(ls /boot | grep -Po 'vmlinuz-\K.*'))
i=0
for k in "${LOADERS[@]}"; do
  echo "[$i] $k"
  ((i++))
done
max=$((i - 1))
read -n1 -p "Select kernel[0-$max]: " i
KERNEL="${LOADERS[$i]}"
LOADER="/vmlinuz-$KERNEL"
INITRAMFS="/initramfs-$KERNEL.img"

# KERNEL PARAMETERS
PARAMETERS=("quiet" "loglevel=3" "mem_sleep_default=s2idle"
  "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" "udev.log_level=3")
TEMP_PARAMETERS=$(mktemp)
printf "%s\n" "${PARAMETERS[@]}" >"$TEMP_PARAMETERS"
$EDITOR "$TEMP_PARAMETERS"
FINAL_PARAMETERS=$(tr '\n' ' ' <"$TEMP_PARAMETERS" | xargs)
rm "$TEMP_PARAMETERS"

echo ""
read -p "Enter Stub Label: " LABEL
echo ""

CMD="sudo efibootmgr -v\
  -d $DISK \
  -p $PARTITION -c \
  -L '$LABEL' \
  -l $LOADER -u\
  'root=UUID=$ROOT resume=UUID=$SWAP rw $FINAL_PARAMETERS initrd=/intel-ucode.img initrd=$INITRAMFS'"

echo $CMD
echo ""
read -p "Apply? [y/N] " y
if [[ "$y" =~ [y] ]]; then
  echo ""
  eval $CMD
  exit 0
fi
exit 0
