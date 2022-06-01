## General setup
Disable:
- Support initial ramdisk/ramfs compressed using bzip2
- Support initial ramdisk/ramfs compressed using LZO
- Support initial ramdisk/ramfs compressed using LZ4
- Support initial ramdisk/ramfs compressed using ZSTD

## Processor type and features

## Power management and ACPI options
Disable:
- Suspend to RAM and standby
- Hibernation (aka 'suspend to disk')

#### CPU Frequency scaling ->
- powersave governor
- userspace governor for userspace frequency scaling
- conservative cpufreq governor

## Virtualization
- [x] Kernel-based Virtual Machine (KVM) support
- [x] KVM for Intel (and compatible) processors support
- [x] KVM for AMD processors support

## Networking support
Disable:
- Bluetooth subsystem support

#### Wireless ->
- cfg80211 - wireless configuration API

## Device Drivers
Disable:
- Multimedia support
- Sony MemoryStick card support
- Macintosh device drivers
- Sound card support
- Auxiliary Display support
- Platform support for Chrome hardware
- Microsoft Surface Platform-Specific Device Drivers (NEW)
- SoundWire support
- Android: Android Drivers
- Remote Controller support

  #### Staging drivers ->
  - RealTek RTL8192U Wireless LAN NIC driver
  - Support for rtllib wireless devices
  - Media staging drivers

  #### Input device support
  - Keyboards: Apple SPI keyboard and trackpad
  - Mice
  - Joysticks/Gamepads
  - Tablets
  - Touchscreens
    #### Miscellanous devices
    - PC Speaker support
    - IdeaPad Laptop Slidebar
    - Windows-compatible SoC Button Array
    #### Hardware I/O ports
    - Microsoft Synthetic Keyboard driver

  #### X86 Platform Specific Device Drivers
  - WMI: Huawei WMI laptop extras driver
  - WMI support for MXM Laptop Graphics
  - Acer Wireless Radio Control Driver
  - Acer WMI Laptop Extras
  - Apple Gmux Driver
  - Asus Laptop Extras
  - Asus Wireless Radio Control Driver
  - ASUS WMI Driver
  - Fujitsu Laptop Extras
  - Fujitsu Tablet Extras
  - HP laptop accelerometer
  - HP WMI extras
  - Lenovo IdeaPad Laptop Extras
  - Thinkpad Hard Drive Active Protection System
  - ThinkPad ACPI Laptop Extras
  - Intel AtomISP v2 camera LED driver
  - MSI Laptop Extras
  - MSI WMI extras
  - Samsung Laptop driver
  - Toshiba Bluetooth RFKill switch support
  - CMPC Laptop Extras
  - Compal (and others) Laptop Extras
  - LG Laptop Extras
  - Panasonic Laptop Extras
  - Sony Laptop Extras
  - Topstar Laptop Extras

  #### Graphics support ->
  - Laptop Hybrid Graphics - GPU switching support
  - ATI Radeon
  - AMD GPU
  - Nouveau (NVIDIA) cards
  - Intel 8xx/9xx/G3x/G4x/HD Graphics

    #### Backlight & LCD device support ->
    - Lowlevel LCD controls
    - (disable everything under Lowlevel Backlight controls)

## File systems
Disable:
- Reiserfs support
- JFS filesystem support
- GFS2 file system support
- OCFS2 file system support
- Btrfs filesystem support
- NILFS2 file system support
- F2FS filesystem support
- zonefs filesystem support
  #### DOS/FAT/EXFAT/NT Filesystems
  - MSDOS fs support
  - VFAT (Windows-95) fs support
  - exFAT filesystem support
  #### Network File Systems
  - NFS client support
  - NFS server support
  - Ceph distributed file system
  - SMB3 and CIFS support (advanced network filesystem)
  - Coda file system support (advanced network fs)
  - Andrew File System support (AFS)

## Security options
Disable NSA SELinux Support.

