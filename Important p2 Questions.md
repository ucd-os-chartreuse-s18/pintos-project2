1. Processes and threads: 1-to-1
	1. Find evidence that Pintos processes are meant to be single-threaded.  
	> There is little support to facilitate the sharing of resources. Processes don't have their own struct _(but this is only a small hint)_. P. 52 mentions that base and bound registers don't allow memory to be shared between multiple processes. Does that relate?
	
	2. What thread data and functionality does the process piggyback on and what new does it need to add?
	> A process _is a_ thread. It inherits all previous functionality. In `/userprog/process.c`, there are some methods specific to processes already, but we will need to add some other data to `threads.h` for our functions including a container of children per process.
	
2. Process spawning
	1. How is a process created, initialized, and started?
	> Not sure what the difference is between `process_execute` and `start_process`. Check `/userprog/process.c`
	
	2. How is control passed from kernel to user mode?
	> There is probably more specific information, but [PAGE 57 We use the term _trap_ to refer to any synchronous transfer of control from user mode to the kernel; some some systems use the term more generically for any transfer of control from a less priviledged to to a more priviledged level.]
	
3. What's a process: executing user binary code (load)
	1. Where is the user binary stored before the process is spawned?
	> On the virtual disk.
	
	2. How is the user binary loaded? What does it mean to be "loaded"?
	> We use the `pintos-mkdisk` utility to first create `filesys.dsk` (w/ formatting), then we use the -p put argument to select a file to load.
	
	3. Where (what address) is the code segment of the process?
	> Will it be a register saved into `intr_frame`?
	
	4. What is the (script execution, function calls) path of the program arguments passed to the process, from the Perl file to Pintos to the user program?
	> Haven't explored that yet.
	
4. Dual-mode OS operation: user & kernel
	1. How is the mode controlled? Where in the IA-32 documentation is this process described?
	> DPL isn't a variable that is changed. However, when a kernel method (such as an interrupt handler) is called, it is trusted to ensure the user process can't do anything harmful. The IA-32 probably mentions this under "privilege levels"
	
	2. What are the mode switches that are supported? Enumerate the cases.
	> User to kernel and kernel to user. _[Should elaborate on the cases for better understanding.]_ ALSO! `tss.c` will be needed for user to user _task_ switching. There is a big comment there on how and why the tss is needed.
	
5. Address spaces & memory mapping
	1. How is virtual memory partitioned into user and kernel?
	> Separation at `PHYS_BASE`. The kernel memory is above, while the user process memory is below.
	
	2. How many pages do the user and kernel pools contain and how is that determined?
	> No idea. I didn't even think that the kernel needed its own pages. As far as I know, the amount of pages a (user) process uses grows over time, but there is a static number of pages accessible, which is determined at compile time via looking at certain settings.
	
	3. How many stacks are there for a process?
	> One! It is designed to be single-threaded.
	
	4. How are arguments passed from kernel to user addressing and the return values from user back to kernel addressing?
	> Isn't the level of virtual memory abstraction the same between the kernel and user the same since they have the same block? _I think I misunderstood the question._
	
	5. What does it mean for kernel pages to be "mapped 1-to-1" to physical memory frames? Where in the address space is this mapping realized?
	> Being mapped 1-1 means that it only takes one computation to translate kernel memory to its physical memory. It is actually impossible (or at least, very difficult) to have no mapping whatsoever. The address mapping space of the kernel is >= PHYS_BASE.
	
	6. How can you check the value of an address in physical memory?
	> `vaddr.h` features vtop (virtual to physical) and ptov (physical to virtual) address functions. What is meant by 'check' exactly?
	
6. Virtual addresses & page tables
	1. What is the structure of a virtual address? Why is it segmented rather than monolithic?
	> TODO
	
	2. Where does the master page directory reside?
	> Seems to be a static pointer in pagedir.c?
	
	3. Where/how are the per-process page tables stored?
	> Page tables are stored in pagedir?
	
	4. In the context of virtual memory what is a "page"?
	> A page is a section of memory that can be swapped out for other sections of memory. The page holds virtual memory or physical memory? Virtual I think?
	
	5. What metainformation is kept for each page?
	> check `pte.h`?
	
	6. What is an "unmapped virtual memory address"? Why is an unmapped address invalid?
	> It is invalid because it can't actually be translated into anything. I'm currently trying to figure out what this means in terms of code.
	
	7. How do the functions ptov and vtop in vaddr.h work?
	> The physical and virtual spaces for the kernel are `PHYS_BASE` distance apart, so adding and subtracting `PHYS_BASE` is sufficient. See pg. 24 for kernel virtual memory mapping.
	
	8. What, in the context of virtual memory, is a page fault?
	> It is when you try to access memory that can't be mapped or you don't have permission to access.
	
7. Processes and context switches
	1. What happens to a running process when it is preempted by another?
	> Its registers get saved. It is put onto a round-robin queue. Not sure what else.
	
	2. How and where are the program pointer, stack pointer, and other pointer, data, and state saved/stored?
	> Most things are stored in registers. OR... I think a _"frame"_ that holds data representing registers. Specifically, this is possibly `intr_frame`? Or maybe that _only_ happens in certain cases?
	
	3. What happens when a process generates an non-memory related exception?
	> Most exceptions _should_ get handled in some way. As of now they might panic the kernel, but it is our job to make sure the kernel doesn't crash and instead alert the user.
	
	4. What mode transitions happen during a context switch?
	> I guess it depends whether the process gets interrupted by another user process or an interrupt from the kernel (which in itself can be invoked by a user).
	
8. Running of interrupts
	1. What are the two types of interrupts that Pintos supports? Are there any significant differences between them?
	> There are internal and external interrupts. The external ones can't sleep (or use locks) therefore their synchronization solution is that they can't be interrupted at all and it is more important for them to finish quickly.
	
	2. How are interrupts handled?
	> Using an interrupt handler. I'm still trying to work out some of the differences between `syscall_handler` and `intr_handler` though. `INT n` is how the user indirectly calls the functions we have to implement such as `write`.
	
	3. On what stack does an interrupt execute?
	> On the kernel stack.
	
9. System call mechanism & details
	1. Do system calls piggyback on the interrupt system?
	> That is just what I was trying to figure out if you look above.
	
	2. What is the user stub of a system call? What does it execute? On what stack is it executed?
	> It is in some sort of .S file.
	
	3. What do the processor and OS execute during a system call? (This is the system call "funnel" or "bottleneck".)
	> A handler?
	4. In what context (mode) is a system call made?
	> A system call is called from user mode.
	5. In what context (mode) is the implementation of a system call executed?
	> In kernel mode.
	6. What data has to be passed from the user to the kernel through the bottleneck? How is that supposed to happen?
	> Every system call needs to be able to read virtual memory. This is a pretty important TODO. Page 26 would be a good ref.
	
	7. What handling is common for all system calls? (This will be the system call "dispatcher".) 
	> intr_handler? Does this relate to the piggy back question above?
	
10. Pintos rediscovered: the boot and initialization sequence
	1. How does Pintos boot? How is it loaded?
	2. Where's the main function of Pintos?
	3. What base Pintos components are initialized, how, in what order, and where?