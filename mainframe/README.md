# PERFECT-OS Mainframe

S/390 and IBM mainframe integration layer for PERFECT-OS.

## Components

- s390/      S/390 architecture integration
- qemu/      QEMU integration
- hercules/  Hercules integration
- mvs/      MVS-compatible operating-system assets
- dasd/     DASD/CKD disk images
- ipl/      IPL/boot assets
- configs/  Emulator configurations
- tools/    Mainframe utilities
- docs/     Documentation

## Current Status

PERFECT-OS currently contains historical QEMU S/390 IPL ROM assets.

A native Android/Termux S/390 emulator executable and an MVS installation
have not yet been added.

Do not redistribute proprietary IBM operating-system images.

## MUSIC/SP

PERFECT-OS also provides a MUSIC/SP compatibility/integration layer
under `mainframe/musicsp/`.

The layer provides emulator detection, configuration, boot structure,
documentation, and future AI/mainframe tooling.

No MUSIC/SP operating-system image is distributed by PERFECT-OS.
