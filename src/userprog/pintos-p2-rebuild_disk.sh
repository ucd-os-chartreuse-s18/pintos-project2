#!/bin/bash
# PINTOS-P2: Automated disk build script
# By: Peter Gibbs, special thanks to Brian, Matthew, and Michael for the itemized testing script
# that this is partialy based off of
# NOTE: To allow execution of this script, run the following command:
#   chmod +x ./pintos-p2-rebuild-disk.sh

# This script will run a make clean, then make all, then create a new disk.
# Finally it will build all the example programs and copy them into the new disk
# Should be useful if you need do rebuild the disk

#USAGE
# ./pintos-p2-rebuild-disk.sh to run without loading examples onto the disk
# ./pintos-p2-rebuild-disk.sh -examples

# Note: This thing was cobbled together in a very short time just to get it working.
# Therefore its features are very limited.
# Feel free to expand on the functionality and put your improved version on slack

main ()
{
    echo -e "PINTOS-P2: Quick Disk Builder\n"
    if [[ "$@" == "-examples" ]]; then
        echo -e "\n All of the example programs will be copied to the disk\n"
    else
         echo -e "\n None of the examples will be copied to disk\n"
    fi
    
    read -p "Press the [ENTER] key to continue, or [CTRL]+[C] abort."
    
    # This will clean then remake the kernel
    #make clean # Is this necessary? What does it clean exactly?
    make # This was "make all"
    BUILD_SUCCESS=!$?
    
    if (( $BUILD_SUCCESS )); then
        cd # What is this for?
        cd ~/pintos/src/userprog/build
        pintos-mkdisk filesys.dsk --filesys-size=2
        
        pintos -f -q
        if [[ "$@" == "-examples" ]]; then
            cd ~/pintos/src/examples
            echo -e "\n Building example programs\n"
            #make clean # Is this necessary?
            make
            cd ~/pintos/src/userprog/build
            # Loading all example programs onto filesys.dsk
            # TODO add echo statements surrounding each to make this output more clearly
            # Also, I think -v will prevent qemu window from popping up? Why is -p needed? 
            
            pintos -p ../../examples/bubsort -a bubsort -- -q
            pintos -p ../../examples/cat -a cat -- -q
            pintos -p ../../examples/cmp -a cmp -- -q
            pintos -p ../../examples/cp -a cp -- -q
            pintos -p ../../examples/echo -a echo -- -q
            pintos -p ../../examples/halt -a halt -- -q
            pintos -p ../../examples/hex-dump -a hex-dump -- -q
            pintos -p ../../examples/insult -a insult -- -q
            pintos -p ../../examples/lineup -a lineup -- -q
            pintos -p ../../examples/ls -a ls -- -q
            pintos -p ../../examples/matmult -a matmult -- -q
            pintos -p ../../examples/mcat -a mcat -- -q
            pintos -p ../../examples/mcp -a mcp -- -q
            pintos -p ../../examples/mkdir -a mkdir -- -q
            pintos -p ../../examples/pwd -a pwd -- -q
            pintos -p ../../examples/recursor -a recursor -- -q
            pintos -p ../../examples/rm -a rm -- -q
            pintos -p ../../examples/shell -a shell -- -q
        fi
        echo -e "\n   SCRIPT EXECUTION TERMINATED SUCCESSFULLY. \n"
    else
        echo -e "\n   ERROR:  FAILED TO BUILD PINTOS.  Drive not remade . \n"
    fi
}

# pintos --fs-disk=2 -p ../../examples/echo -a echo -- -f -q run 'echo x'

main "$@"