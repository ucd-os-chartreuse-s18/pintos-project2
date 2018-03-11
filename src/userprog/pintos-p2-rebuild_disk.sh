#!/bin/bash
# PINTOS-P2: Automated disk build script
# By: Peter Gibbs, special thanks to Brian, Matthew, and Michael for the itemized testing script
# that this is partialy based off of
# NOTE: To allow execution of this script, run the following command:
#   chmod +x ./pintos-p2-rebuild-disk.sh


# This script will run a make clean, then make all, then create a new disk.
# finaly it will build all the example programs and copy them into the new disk
# Should be useful if you need do rebuild the disk

#USAGE
# ./pintos-p2-rebuild-disk.sh to run without copying examples
# ./pintos-p2-rebuild-disk.sh -examples

# Note, this thing was cobbled together in a very short time just to get it working.(And its my first time writing a
# shell script)
# Therefore its features are very limited.
# Feel free to expand on the functionality and put your improved version on slack
#
main ()
{

    echo -e "PINTOS-P2: Quick Disk Builder\n"
    if [[ "$@" == "-examples" ]]
     then
        echo -e "\n All of the example programs will be copied to the disk\n"
    else
         echo -e "\n None of the examples will be copied to disk\n"
    fi

    read -p "Press the [ENTER] key to continue, or [CTRL]+[C] abort."
    make clean
    make all
    BUILD_SUCCESS=!$?

    if (( $BUILD_SUCCESS )); then
        cd
        cd ~/pintos/src/userprog/build
        pintos-mkdisk filesys.dsk --filesys-size=2
        pintos -f -q
         if [[ "$@" == "-examples" ]]
          then
            cd ~/pintos/src/examples
            echo -e "\n Building example programs\n"
            make clean
            make
            cd ~/pintos/src/userprog/build
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

main "$@"