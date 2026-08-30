#ifndef PERFECT_OS_AI_AGENT_H
#define PERFECT_OS_AI_AGENT_H

typedef struct {
    const char *name;
    const char *description;
    int (*run)(const char *task);
} perfect_ai_agent_t;

#endif
