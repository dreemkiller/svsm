./work/bin/qemu-svsm/bin/qemu-system-x86_64 \
	-enable-kvm \
	-cpu EPYC-v4 \
	-machine q35 \
	-smp 4,maxcpus=64 \
	-m 2048M,slots=5,maxmem=30G \
	-no-reboot \
	-drive if=pflash,format=raw,unit=0,file=/edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF_CODE.fd,readonly=on \
	-drive if=pflash,format=raw,unit=1,file=/edk2/Build/OvmfX64/DEBUG_GCC5/FV/OVMF_VARS.fd,readonly=on \
	-drive if=pflash,format=raw,unit=2,file=./svsm.bin,readonly=on \
	-object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,svsm=on \
	-machine memory-encryption=sev0,vmport=off \
	-object memory-backend-memfd-private,id=ram1,size=2048M,share=true \
	-machine memory-backend=ram1,kvm-type=protected \
	-nographic \
	--kernel /linux_guest/arch/x86_64/boot/bzImage \
	-device vhost-vsock-pci,guest-cid=3 \
	--initrd ./initramfs_minimal \
	-append "console=ttyS0"
	#--kernel ./work/kernel/bzImage \
	#--kernel ./work/kernel/bzImage \
	#--kernel /linux_guest/arch/x86_64/boot/bzImage \
	#-append "console=ttyS0 earlyprintk=serial root=ext2"
	#-device virtio-scsi-pci,id=scsi0,disable-legacy=on,discard=none \
