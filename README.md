### Project 2: User Programs

#### Group Participants
Michael Hedrick  
Matthew Moltzau  

#### Working Directory and Pintos Utilities
We will be working primarily from `src/userprog`, which is where the kernel is
located. You can invoke "make" just like normal.

For testing, run `pintos-p2-tests` (kudos to Brian). The bash script is located
in `src/userprog`, but an alias exists in `src/utils` so that you can call it
from anywhere.

A bash script `pintos-run-util` was just created that helps with loading and
running user programs. It can run tests, but is limited since it can't pass
the correct arguments to right tests just yet.

The grader will be using `make check` from the build directory.

#### Pintos Project 2 Assignments
Argument Passing  
Handling User Memory   
System Call Infrastructure  
File Operations (using fd)  

#### Design Considerations
See `DOC_P2.md` for the design document.
