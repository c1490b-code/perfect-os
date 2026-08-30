#include <stdio.h>
#include "../kernel/config.h"

int main(void)
{
    printf("PERFECT-OS\n");
    printf("Version : %s\n", PERFECT_OS_VERSION);
    printf("Arch    : %s\n", PERFECT_OS_ARCH);
    printf("AI      : enabled\n");
    printf("Network : enabled\n");
    printf("Security: enabled\n");
    return 0;
}
