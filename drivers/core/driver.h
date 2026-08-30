#ifndef PERFECT_OS_DRIVER_H
#define PERFECT_OS_DRIVER_H

typedef struct {
    const char *name;
    int (*init)(void);
    int (*shutdown)(void);
} perfect_driver_t;

#endif
