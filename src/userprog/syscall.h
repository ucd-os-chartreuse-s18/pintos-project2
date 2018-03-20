#ifndef USERPROG_SYSCALL_H
#define USERPROG_SYSCALL_H

#include <../lib/user/syscall.h>

void syscall_init (void);

typedef int syscall_func(int, int, int);

#endif /* userprog/syscall.h */
