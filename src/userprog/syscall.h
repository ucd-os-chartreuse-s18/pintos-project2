#ifndef USERPROG_SYSCALL_H
#define USERPROG_SYSCALL_H

#include <../lib/user/syscall.h>

void syscall_init (void);

typedef int syscall_func(int, int, int);

static int sys_unimplemented(void);

/* Projects 2 and later. */
static int sys_halt (void);
static int sys_exit (int status);
static int sys_exec (const char *file);
static int sys_wait (pid_t pid);
static int sys_create (const char *file, unsigned initial_size);
static int sys_remove (const char *file);
static int sys_open (const char *file);
static int sys_filesize (int fd);
static int sys_read (int fd, void *buffer, unsigned size);
static int sys_write (int fd, const void *buffer, unsigned size);
static int sys_seek (int fd, unsigned position);
static int sys_tell (int fd);
static int sys_close (int fd);

/* Project 3 and optionally project 4. */
static int sys_mmap (int fd, void *addr);
static int sys_munmap (mapid_t mapid);

/* Project 4 only. */
static int sys_chdir (const char *dir);
static int sys_mkdir (const char *dir);
static int sys_readdir (int fd, char name[READDIR_MAX_LEN + 1]);
static int sys_isdir (int fd);
static int sys_inumber (int fd);

#endif /* userprog/syscall.h */
