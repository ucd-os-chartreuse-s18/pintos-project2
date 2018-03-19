### Project 2: User Programs

We will be working primarily from `src/userprog`, which is where the kernel is
located. You can invoke "make" just like normal.

For testing, run `pintos-p2-tests` (kudos to Brian). The bash script is located
in `src/userprog`, but an alias exists in `src/utils` so that you can call it
from anywhere.

> Note: Until the `write` syscall is functioning, no runs will produce any
output. (see `src/lib/user`)

The grader will be using `make check` from the build directory.

#### Example User Programs

It seems that it is not necessary to test the example files, though after
tests are working and you want to test some (for the satisfaction of course!),
here are the steps:

1) Create a filesystem disk for `userprog`. _(Assumes the kernel was built under `userprog`)_

```
cd ~/pintos/src/userprog/build
pintos-mkdisk filesys.dsk --filesys-size=2
```

> Note: The disk name _must_ be `filesys`, or the kernel will PANIC

2) Format the disk with a filesystem partition.

```
pintos -f -q
```

3) Building, then loading example programs into the already-existing filesys.dsk disk.

```
cd ~/pintos/src/examples
make
cd ~/pintos/userprog/build
pintos -p ../../examples/echo -a echo -- -q
pintos -q run 'echo x'
```
> Note: It seems you can run 'bogus' without pintos taking notice. You need to
ensure that your program is properly compiled. This might change as we develop
more, but for now this is something that we need to keep in mind.

Refer to the `pintos-p2-rebuild-disk` utility if you find these steps tedious.

#### TODO
 
1) User memory access (needed for all system calls).  
2) System call infrastructure and  
3) `write` system call (for getting basic output going)

See _Suggested Order of Implementation_ in the documentation for more info on 
where to start. 

