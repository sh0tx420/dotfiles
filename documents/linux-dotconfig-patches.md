# Linux `.config` options
Configuration options for a custom Artix kernel.<br/>
Base config copied from a minimal Artix installation.

### Power management and ACPI options
  - CPU Frequency scaling -> Default CPUFreq governor: `performance`

### Enable the block layer
- Partition Types
  - [ ] Macintosh partition map support
  - [ ] PC BIOS (MSDOS partition tables) support
  - [ ] BSD disklabel (FreeBSD partition tables) support
  - [ ] Minix subpartition support
  - [ ] Solaris (x86) partition table support
  - [ ] Windows Logical Disk Manager (Dynamic Disk) support

### Device drivers
- [ ] Macintosh device drivers
- [ ] Multimedia support
- Graphics support
  - [ ] ATI Radeon
  - [ ] AMD GPU
  - [ ] Nouveau (NVIDIA) cards
- [ ] Sound card support

### File systems
- [ ] Reiserfs support
- [ ] JFS filesystem support
- [ ] XFS filesystem support
- [ ] GFS2 file system support
- [ ] OCFS2 file system support
- [ ] Btrfs filesystem support
- [ ] NILFS2 file system support
- [ ] F2FS filesystem support
- [ ] zonefs filesystem support
- DOS/FAT/EXFAT/NT Filesystems
  - [ ] MSDOS fs support
  - [ ] VFAT (Windows-95) fs support
  - [ ] NTFS Read-Write file system support

### Security options
- [ ] NSA SELinux Support
