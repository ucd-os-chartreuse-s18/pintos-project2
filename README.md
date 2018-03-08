Run the tests for Project 2: User Programs

_Note: Project 2 does not need any of the functionality implemented in Project 1. In particular, all threads are created with priority `PRI_DEFAULT` and the scheduler runs simple round-robin. So, if you passed all tests in Project 1, you can just continue working in your current install. Or, you can start with a new raw Pintos install._

1. Make sure you run a top-level clean (of `threads`) before you build for `userprog`.

```
cd ~/pintos
make clean
```

2. In the Perl script `src/utils/pintos`, change `kernel.bin` on line **257** to `/home/pintos/pintos/src/userprog/build/kernel.bin`.

3. In the Perl script `src/utils/Pintos.pm`, change `kernel.bin` on line **362** to `/home/pintos/pintos/src/userprog/build/loader.bin`.

4. Build the project.

```
cd src/utils
make
cd src/userprog
make
cd build
```

5. Create a filesystem disk for `userprog`. _(Assumes the kernel was built under `userprog/`. Similarly, for `vm` and `filesys`.)_

```
cd ~/pintos/src/userprog/build
pintos-mkdisk filesys.dsk --filesys-size=2
```

6. Format the disk with a filesystem partition. _(Assumes the kernel was built under `userprog/`. Similarly, for `vm` and `filesys`.)_

```
pintos -f -q
```

7. Run the tests.

```
cd ~/pintos/src/userprog/build
make check VERBOSE=1
```

8. To load and run the example user programs, you need to build them first.

```
cd ~/pintos/src/examples
make
cd ~/pintos/userprog/build
pintos -p ../../examples/echo -a echo -- -q
pintos -q run ’echo x’
```

