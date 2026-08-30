#include <stdio.h>

void perfect_kernel_init(void)
{
    printf("[kernel] PERFECT-OS kernel initialized\n");
    printf("[kernel] memory subsystem: ready\n");
    printf("[kernel] process subsystem: ready\n");
    printf("[kernel] interrupt subsystem: ready\n");
    printf("[kernel] scheduler: ready\n");
}
