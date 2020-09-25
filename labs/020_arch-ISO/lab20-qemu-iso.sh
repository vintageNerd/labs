#!/bin/bash
#lab qemu-kernel
#sex 10 jan 2020 20:45:14 UTC
#2020-01-10 20:45:17+00:00

#----------------------------------------

NOME=lab020
RAM=1024

TAP=tap0
MAC=52:54:00:ca:fe:22


#TAP=tap-nata1
#MAC=52:54:00:ca:fe:24


RAIZ=/dev/vda
#KERNEL=/opt/qemu/kernels/buster/vmlinuz-4.19.0-10-amd64
#RAMFS=/opt/qemu/kernels/buster/initrd.img-4.19.0-10-amd64

KERNEL=/opt/qemu/kernels/test/bzImage

DISCO=/dev/qemus/qemu
#DISCO2=/srv/files/qemus/swap1024.img

CD=/srv/files/ISOS/archlinux-2020.01.01-x86_64.iso

sudo /usr/bin/qemu-system-x86_64 \
 -name "$NOME" \
 -k pt \
 -boot d \
 -rtc base=localtime \
 -machine accel=kvm \
 -smp sockets=1,cpus=4,cores=2 -cpu host \
 -m $RAM \
 -drive file=$DISCO,if=virtio,format=raw \
 -kernel $KERNEL \
 -append "root=$RAIZ console=ttyS0 rw loglevel=3" \
 -device e1000,netdev=net0,mac=$MAC \
 -netdev tap,id=net0,ifname=$TAP,script=no,downscript=no \
 -vga qxl -vnc 0.0.0.0:7\
 -nographic 
exit


 -drive file=$DISCO2,format=raw \

 -initrd $RAMFS \