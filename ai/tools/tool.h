#ifndef PERFECT_OS_AI_TOOL_H
#define PERFECT_OS_AI_TOOL_H

typedef struct {
    const char *name;
    const char *description;
    int (*execute)(const char *input);
} perfect_ai_tool_t;

#endif
