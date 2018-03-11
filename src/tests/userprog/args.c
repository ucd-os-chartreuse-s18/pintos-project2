/* Prints the command-line arguments.
   This program is used for all of the args-* tests.  Grading is
   done differently for each of the args-* tests based on the
   output. */

#include "tests/lib.h"

int
main (int argc, char *argv[]) 
{
  int i;
  
  //I thought argv[0] was automatically called
  //from all user programs?
  
  //Keep getting things like:
  //Executing 'args-*':
  //Execution of 'args-*' complete.
  //I DID update by making src/userprog,
  //then I ran make check VERBOSE=1
  
  //Theoretically this should cause a page
  //fault?
  //msg ("argc is %d\n", argc);
  //msg ("argv[0] is %d\n", argv[0]);
  
  test_name = "args";
  
  msg ("begin");
  msg ("argc = %d", argc);
  for (i = 0; i <= argc; i++)
    if (argv[i] != NULL)
      msg ("argv[%d] = '%s'", i, argv[i]);
    else
      msg ("argv[%d] = null", i);
  msg ("end");

  return 0;
}
