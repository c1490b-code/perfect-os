#include "phal.h"

#define PHAL_MAX_DEVICES 256

static phal_device_t devices[PHAL_MAX_DEVICES];
static uint32_t device_count = 0;

int phal_register_device(const phal_device_t *device)
{
    if (!device || device_count >= PHAL_MAX_DEVICES)
        return -1;

    devices[device_count++] = *device;
    return 0;
}

int phal_unregister_device(uint64_t device_id)
{
    for (uint32_t i = 0; i < device_count; ++i) {
        if (devices[i].device_id == device_id) {
            devices[i] = devices[--device_count];
            return 0;
        }
    }

    return -1;
}

int phal_enumerate_devices(phal_device_t *out, uint32_t max)
{
    if (!out)
        return -1;

    uint32_t n = device_count < max ? device_count : max;

    for (uint32_t i = 0; i < n; ++i)
        out[i] = devices[i];

    return (int)n;
}

int phal_get_capabilities(uint64_t device_id, uint64_t *capabilities)
{
    if (!capabilities)
        return -1;

    for (uint32_t i = 0; i < device_count; ++i) {
        if (devices[i].device_id == device_id) {
            *capabilities = devices[i].capabilities;
            return 0;
        }
    }

    return -1;
}
