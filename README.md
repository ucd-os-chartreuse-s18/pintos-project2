### Project 2: User Programs

We will be working primarily from `src/userprog`, which is where the kernel is
located. You can invoke "make" just like normal.

For testing, run `pintos-p2-tests` (kudos to Brian). The bash script is located
in `src/userprog`, but an alias exists in `src/utils` so that you can call it
from anywhere.

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
 
In general, our _**TODO**_ is just implementing syscalls. Looking at the tests
should be helpful to see what kind of behavior is expected.

##### Reviewing What's Already been Implemented:
Argument passing and the overall syscall infrastructure has just been done, so
here is a concrete list of relevant _**TODO**_ tasks for those:

1. Fix the memory leak created by `setup_argv` by freeing `line`. This can't be done in
  the function since the arguments pushed to the stack point there. However, maybe that
  in itself is a flaw and needs to be checked?

2. Implement dbl-space for command line args.

3. Review the syscall test group for a better understanding of certain behavior. (sc-bad-\* and sc-boundary-\*)

**Test Group wait:**

1. Convert `children_list` in thread.h to be a hashtable and update how it is used in subsequent code. This was made for `wait`.

2. Review the tests for edge cases specific to wait:

```
#FAIL tests/userprog/wait-simple
#FAIL tests/userprog/wait-twice
#FAIL tests/userprog/wait-killed
#FAIL tests/userprog/wait-bad-pid
```

**Test Group write:**

1. I'm not familiar with some of these just yet, especially write-normal and write-boundary. Maybe they check to see how much was actually written? I'm not sure how to write to a fd that isn't the console.

```
#FAIL tests/userprog/write-normal
#FAIL tests/userprog/write-bad-ptr
#FAIL tests/userprog/write-boundary
#FAIL tests/userprog/write-zero
```

**Misc:**

1. Figure out where to insert "put_user" into the code. (currently in syscall.c)

2. Somehow the test for `halt` passes, even though nothing has been implemented. Have the requirements actually been passed?
