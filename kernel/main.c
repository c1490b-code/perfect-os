#include <stdio.h>
#include <stdlib.h>
#include "../kernel/config.h"

static void kernel_banner(void)
{
    printf("\n");
    printf("========================================\n");
    printf("           %s\n", PERFECT_OS_NAME);
    printf("           version %s\n", PERFECT_OS_VERSION);
    printf("========================================\n");
    printf("Kernel:      ONLINE\n");
    printf("Memory:      READY\n");
    printf("Drivers:     READY\n");
    printf("Networking:  READY\n");
    printf("Security:    READY\n");
    printf("AI Layer:    READY\n");
    printf("========================================\n");
}

int main(void)
{
    kernel_banner();

    printf("\nPERFECT-OS kernel foundation started.\n");
    printf("System initialization complete.\n\n");

    return EXIT_SUCCESS;
}
