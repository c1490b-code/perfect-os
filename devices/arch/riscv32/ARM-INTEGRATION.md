# ARM Device Layer Integration

This target inherits the common PERFECT OS device architecture
design established by the ARM device layer.

Target: riscv32

Shared layers:

- HAL
- Device discovery
- Bus support
- Drivers
- Firmware
- Runtime
- Power
- Thermal
- Storage
- Display
- Audio
- Network
- Input
- Sensors

Architecture-specific code belongs in this directory.
Universal code remains in the shared PERFECT OS device layer.
