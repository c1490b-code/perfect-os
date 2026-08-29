#ifndef PERFECT_PHAL_H
#define PERFECT_PHAL_H

#include <stdint.h>

typedef enum {
    PHAL_CPU,
    PHAL_MEMORY,
    PHAL_STORAGE,
    PHAL_DISPLAY,
    PHAL_AUDIO,
    PHAL_NETWORK,
    PHAL_WIRELESS,
    PHAL_INPUT,
    PHAL_CAMERA,
    PHAL_SENSOR,
    PHAL_POWER,
    PHAL_THERMAL,
    PHAL_INDUSTRIAL,
    PHAL_MEDICAL,
    PHAL_ROBOTICS,
    PHAL_VEHICLE,
    PHAL_VIRTUAL
} phal_device_class_t;

typedef struct {
    uint64_t device_id;
    phal_device_class_t class_id;
    uint64_t capabilities;
    const char *name;
    const char *driver;
} phal_device_t;

int phal_register_device(const phal_device_t *device);
int phal_unregister_device(uint64_t device_id);
int phal_enumerate_devices(phal_device_t *devices, uint32_t max);
int phal_get_capabilities(uint64_t device_id, uint64_t *capabilities);

#endif
