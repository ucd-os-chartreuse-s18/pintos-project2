1. Processes and threads: 1-to-1
	1. Find evidence that Pintos processes are meant to be single-threaded.  
	> There is little support to facilitate the sharing of resources. Processes 
	don't have their own struct _(but this is only a small hint)_. P. 52 
	mentions that base and bound registers don't allow memory to be shared 
	between multiple processes. Does that relate?
	
	2. What thread data and functionality does the process piggyback on and what new does it need to add?
	> A process _is a_ thread. It inherits all previous functionality. In 
	`/userprog/process.c`, there are some methods specific to processes 
	already, but we will need to add some other data to `threads.h` for our 
	functions including a container of children per process. I think we will
	be implementing `fork`, which is mentioned in the book. The interrupt
	frame is weird since the interrupt frame is a local variable in the process
	start method (meaning it is located on the call stack).
	
2. Process spawning
	1. How is a process created, initialized, and started?
	> The start function of the process is passed into thread_create when that
	process is initialized. I am unsure of the nuances between creation and
	initialization as they are posed in the question.
	
	2. How is control passed from kernel to user mode?
	> There is probably more specific information, but [PAGE 57 We use the term 
	_trap_ to refer to any synchronous transfer of control from user mode to 
	the kernel; some some systems use the term more generically for any 
	transfer of control from a less privileged to to a more privileged level.]
	
3. What's a process: executing user binary code (load)
	1. Where is the user binary stored before the process is spawned?
	> On the virtual disk.
	
	2. How is the user binary loaded? What does it mean to be "loaded"?
	> We use the `pintos-mkdisk` utility to first create `filesys.dsk` (w/ 
	formatting), then we use the -p put argument to select a file to load.
	
	3. Where (what address) is the code segment of the process?
	> EIP (instruction pointer) and ESP (stack pointer) are stored in the
	interrupt frame. EIP holds the code segment.
	
	4. What is the (script execution, function calls) path of the program arguments passed to the process, from the Perl file to Pintos to the user program?
	> Haven't explored that yet.
	
4. Dual-mode OS operation: user & kernel
	1. How is the mode controlled? Where in the IA-32 documentation is this process described?
	> DPL isn't a variable that is changed. Certain things are initialized or
	invoked with a static value of either '0' or '3' depending on whether that 
	thing is designed to have user or kernel privileges. When a kernel method 
	(such as an interrupt handler) is called, it is trusted to ensure the user 
	process can't do anything harmful. The IA-32 probably mentions this under 
	"privilege levels"
	
	2. What are the mode switches that are supported? Enumerate the cases.
	> User to kernel and kernel to user. _[Should elaborate on the cases for 
	better understanding.]_ ALSO! `tss.c` will be needed for user to user 
	_task_ switching. There is a big comment there on how and why the tss is 
	needed.
	
5. Address spaces & memory mapping
	1. How is virtual memory partitioned into user and kernel?
	> There is a pool of user pages and a pool of kernel pages, which are 
	separated 1/2 and 1/2. I believe this is also the separation at `PHYS_BASE`. 
	The kernel memory is above, while the user process memory is below. palloc
	manages both pools of memory.
	
	2. How many pages do the user and kernel pools contain and how is that determined?
	> `palloc_init` separates the kernel and user pages into two halves. I'm
	not sure about the exact number of pages. Typically, the kernel would be
	expected to have a smaller pool than the user, but that is not our case.
	
	3. How many stacks are there for a process?
	> I'm a little confused about this since Ivo mentioned two stacks which I
	thought he said was per process. I think, there is one user stack per 
	process, _but_ that the kernel stack will also exist at the same time 
	(being the second  stack). Not that a process can access the kernel stack 
	directly, but it is still a resource that a process may use. NOTE: I am
	unsure of the difference between the stack provided by thread.h and the
	stack stored in ESP inside the interrupt frame. TODO LAST LEFT OFF HERE,
	Read Ivo's pinned comment on the stack.
	
	4. How are arguments passed from kernel to user addressing and the return values from user back to kernel addressing?
	> Return values are conventionally stored into eax. I think the user stack 
	is used to pass arguments since the user can't write to kernel space. (or 
	idk, maybe the virtual memory aspect can get us around that) I think I 
	remember Ivo saying that you would check the user stack for argument 
	passing, and then have to verify that it is a legal address.
	
	5. What does it mean for kernel pages to be "mapped 1-to-1" to physical memory frames? Where in the address space is this mapping realized?
	> Being mapped 1-1 means that it only takes one computation to translate 
	kernel memory to its physical memory. It is actually impossible (or at 
	least, very difficult) to have no mapping whatsoever. The address mapping 
	space of the kernel is >= PHYS_BASE.
	
	6. How can you check the value of an address in physical memory?
	> `vaddr.h` features vtop (virtual to physical) and ptov (physical to 
	virtual) address functions. What is meant by 'check' exactly? Also, this 
	process only works for virtual memory from the kernel, or at least user 
	memory that is mapped to something in the kernel.
	
6. Virtual addresses & page tables
	1. What is the structure of a virtual address? Why is it segmented rather than monolithic?
	> I think "segmented" means that the address is separated into a page 
	directory, a page table, and a page (or offset). It makes sense to 
	represent the addresses this way because it 1) resembles the structure of 
	the actual physical memory, and 2) it allows us to be more efficient by 
	loading in a chunk of memory that we are likely to use more often, and then 
	swap out that whole chunk of memory when it becomes obsolete.
	
	2. Where does the master page directory reside?
	> Seems to be a static pointer in pagedir.c? What does this look like on 
	paper?
	
	3. Where/how are the per-process page tables stored?
	> Page tables are stored in a processes' page directory, which is declared in
	thread.h.
	
	4. In the context of virtual memory what is a "page"?
	> A page is a 4kb space of memory that can be mapped to physical memory. To
	best answer this, I think we should include a drawing (vector program) and
	include it in our project. NOTE: A "page" is the elementary memory mapping
	frame. Technically, a page table is the size of a page, but instead of
	holding generic data, it points to a "page". Similarly, a page directory is 
	also 4kb in size, and it just hold pointers to page tables. (Note 2: Though 
	I suppose a page_dir and page table have metadata that is important to know
	about as well. Check below)
	
	5. What metainformation is kept for each page?
	> check `pte.h`?
	
	6. What is an "unmapped virtual memory address"? Why is an unmapped address invalid?
	> It is invalid because it can't actually be translated into anything. Is
	there a function that we can call to tell us whether the address is mapped
	or unmapped? Looking in palloc and vaddr, but not finding anything 
	immediately.
	
	7. How do the functions ptov and vtop in vaddr.h work?
	> The physical and virtual spaces for the kernel are `PHYS_BASE` distance 
	apart, so adding and subtracting `PHYS_BASE` is sufficient. See pg. 24 for 
	kernel virtual memory mapping. (though I don't understand it all really, 
	gotta draw this all out)
	NOTE: I'm kinda tired now, so I might just delete this note later, but
	wouldn't adding or subtracting PHYS_BASE just translate from user and
	kernel spaces (and would this _only_ work where these spaces are split 
	1/2 and 1/2)?
	
	8. What, in the context of virtual memory, is a page fault?
	> It is when you try to access memory that can't be mapped or you don't 
	have permission to access.
	
7. Processes and context switches
	1. What happens to a running process when it is preempted by another?
	> Its registers get saved (and cr3 will point to the processes' page 
	directory). It is put onto a round-robin queue. Not sure what else.
	
	2. How and where are the program pointer, stack pointer, and other pointer, data, and state saved/stored?
	> The state is stored in an interrupt frame, which is a local variable
	in process_start. It is then integrated with assembly code, and I can't
	quite explain what it does.
	
	3. What happens when a process generates an non-memory related exception?
	> Most exceptions _should_ get handled in some way. As of now they might 
	panic the kernel, but it is our job to make sure the kernel doesn't crash 
	and instead alert the user.
	
	4. What mode transitions happen during a context switch?
	> I guess it depends whether the process gets interrupted by another user 
	process or an interrupt from the kernel (which in itself can be invoked by 
	a user).
	
8. Running of interrupts
	1. What are the two types of interrupts that Pintos supports? Are there any significant differences between them?
	> There are internal and external interrupts. The external ones can't sleep 
	(or use locks) therefore their synchronization solution is that they can't 
	be interrupted at all and it is more important for them to finish quickly.
	
	2. How are interrupts handled?
	> Using an interrupt handler. I'm still trying to work out some of the 
	differences between `syscall_handler` and `intr_handler` though. `INT n` is 
	how the user indirectly calls the functions we have to implement such as 
	`write`.
	
	3. On what stack does an interrupt execute?
	> On the kernel stack. (pg. number for ref?)
	
9. System call mechanism & details
	1. Do system calls piggyback on the interrupt system?
	> That is just what I was trying to figure out if you look above at 8.2.
	
	2. What is the user stub of a system call? What does it execute? On what stack is it executed?
	> It is in some sort of .S file.
	
	3. What do the processor and OS execute during a system call? (This is the system call "funnel" or "bottleneck".)
	> A handler?
	
	4. In what context (mode) is a system call made?
	> A system call is called from user mode.
	
	5. In what context (mode) is the implementation of a system call executed?
	> In kernel mode.
	
	6. What data has to be passed from the user to the kernel through the bottleneck? How is that supposed to happen?
	> Every system call needs to be able to read virtual memory. This is a 
	pretty important TODO. Page 26 would be a good ref.
	
	7. What handling is common for all system calls? (This will be the system call "dispatcher".) 
	> intr_handler? Does this relate to the piggy back question above?
	
10. Pintos rediscovered: the boot and initialization sequence
	1. How does Pintos boot? How is it loaded?
	> Pintos boots in `init.c`, inside the main function.
	
	2. Where's the main function of Pintos?
	> `init.c`
	
	3. What base Pintos components are initialized, how, in what order, and where?
	> 1) Initialize current thread 2) Memory 3) Interrupts 4) Thread Scheduler
	5) File System  
	Init functions are called for every individual thing that needs to be 
	initialized.
	
	