#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

int rdline(unsigned char *buf, int bufsize, int opt)
{
    int n1, goteol;
    int noechosw;
    int termfd;
    struct termios old, new;

    if (bufsize < 1) return -1;

    noechosw = 2 - (opt & 2);
    termfd = fileno(stdin);

    if (!isatty(termfd))
        noechosw = 0;

    if (noechosw) {
        if (tcgetattr(termfd, &old))
            noechosw = 0;
        else {
            new = old;
            new.c_lflag &= ~ECHO;
            if (tcsetattr(termfd, TCSAFLUSH, &new))
                noechosw = 0;
        }
    }

    buf[0] = 0;

    if (fgets((char *)buf, bufsize, stdin) == NULL)
        buf[0] = 0;
    else {
        n1 = strlen((char *)buf);
        goteol = 0;

        if (n1 > 0 && buf[n1-1] == '\n') {
            buf[n1-1] = 0;
            goteol = 1;
        }

        if (!goteol) {
            for (;;) {
                n1 = fgetc(stdin);
                if ((char)n1 == '\n' || n1 == EOF)
                    break;
            }
        }
    }

    if (noechosw)
        tcsetattr(termfd, TCSAFLUSH, &old);

    if (noechosw && (opt & 8) == 0)
        putchar('\n');

    return 0;
}
