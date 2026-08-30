# MUSIC/SP Existing Asset Integration

PERFECT-OS automatically discovers compatible S/390/QEMU boot and
firmware assets already present in the repository.

The runtime can identify:

- `s390-zipl.rom`
- `slof.bin`
- `spapr-rtas.bin`
- other explicitly S/390-named ROM/BIN assets

These assets are firmware/boot components and are **not** themselves
MUSIC/SP.

## Runtime

Run:

    mainframe/musicsp/bin/musicsp assets

The manifest is stored at:

    mainframe/musicsp/runtime/assets/manifest.txt

Configuration is stored at:

    mainframe/musicsp/config/assets.env

Actual MUSIC/SP guest media remains separate and must be supplied by
the user from legally obtained media.
