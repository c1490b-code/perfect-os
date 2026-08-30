# PERFECT-OS MUSIC/SP

MUSIC/SP compatibility and integration layer for PERFECT-OS.

MUSIC/SP is an IBM-compatible mainframe operating system originally
developed at McGill University.

## Architecture

Target:
- IBM S/370
- IBM S/390
- VM-compatible environments
- QEMU/Hercules experimentation where technically appropriate

## PERFECT-OS Integration

MUSIC/SP is treated as a mainframe guest/compatibility target rather
than as the native PERFECT-OS kernel.

Components:

- config/   Emulator and guest configuration
- tools/    Utilities and integration tools
- docs/     MUSIC/SP documentation
- images/   User-supplied legally obtained media
- boot/     IPL/boot configuration

## Current Status

Integration framework created.

No MUSIC/SP operating-system image is included.

Add only media that you are legally permitted to use.

## Relationship

PERFECT-OS
    |
    +-- Mainframe Layer
           |
           +-- S/390
           +-- QEMU
           +-- Hercules
           +-- MVS
           +-- MUSIC/SP
