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
more, but for now this is something that we need to keep in mind. EDIT: I think
this has now been updated so that it works properly.

Refer to the `pintos-p2-rebuild-disk` utility if you find these steps tedious.

#### TODO
 
In general, our _**TODO**_ is just implementing syscalls. Looking at the tests
should be helpful to see what kind of behavior is expected.

1. Figure out where to insert "put_user" into the code. (currently in syscall.c)
So far we've been implementing memory access one way without examining the other.
It will be important to know the difference between the two methods for questions
on the design doc.

2. Review quiz questions on both the google doc and design doc.

3. Continue along with passing tests. 50/80 passing currently!

4. Use a keyed_hash for files.
