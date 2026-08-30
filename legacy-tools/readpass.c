#include <stdio.h>

int rdline(unsigned char *buf, int bufsize, int opt);

int main(void)
{
    unsigned char buf[201];

    rdline(buf, sizeof(buf), 8);
    printf("%s", buf);

    return 0;
}
