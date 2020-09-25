#!/bin/bash
#lab qemu-kali


#----------------------------------------

NOME=lab019
RAM=1024

TAP=tap0
MAC=52:54:00:ca:fe:22

RAIZ=/dev/vda
KERNEL=/opt/qemu/kernels/kali58/vmlinuz-5.8.0-kali1-amd64
#/opt/qemu/kernels/buster/vmlinuz-4.19.0-10-amd64
RAMFS=/opt/qemu/kernels/kali58/initrd.img-5.8.0-kali1-amd64
#/opt/qemu/kernels/buster/initrd.img-4.19.0-10-amd64

#KERNEL=/opt/qemu/kernels/test/bzImage

DISCO=/dev/qemus/kali
DISCO2=/srv/files/qemus/swap1024.img



sudo /usr/bin/qemu-system-x86_64 \
 -name "$NOME" \
 -k pt \
 -rtc base=localtime \
 -machine accel=kvm \
 -smp sockets=1,cpus=4,cores=2 -cpu host \
 -m $RAM \
 -drive file=$DISCO,if=virtio,format=raw \
 -drive file=$DISCO2,format=raw \
 -kernel $KERNEL \
 -initrd $RAMFS \
  -append "root=$RAIZ console=ttyS0 rw loglevel=3" \
 -device e1000,netdev=net0,mac=$MAC \
 -netdev tap,id=net0,ifname=$TAP,script=no,downscript=no \
 -vga qxl -vnc 0.0.0.0:5 \
 -nographic 
exit

 

