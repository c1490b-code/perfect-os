#include <stdio.h>
#include "hal.h"

void hal_init(void)
{
    printf("[HAL] hardware abstraction layer initialized\n");
}

void hal_shutdown(void)
{
    printf("[HAL] hardware abstraction layer stopped\n");
}
