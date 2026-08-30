#ifndef PERFECT_OS_AI_ASSISTANT_H
#define PERFECT_OS_AI_ASSISTANT_H

typedef struct {
    const char *name;
    int (*respond)(const char *input);
} perfect_ai_assistant_t;

#endif
