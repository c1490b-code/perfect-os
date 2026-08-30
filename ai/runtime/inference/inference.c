#include <stdio.h>
#include "inference.h"

int perfect_ai_inference_init(void)
{
    printf("[AI] Inference initialized\n");
    return 0;
}

int perfect_ai_inference_run(const char *input)
{
    if (!input) return -1;
    printf("[AI] Request: %s\n", input);
    return 0;
}
