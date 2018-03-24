#!/bin/bash
# PINTOS-P2: USERPROG -- ITEMIZED PASS/FAIL TESTING SCRIPT (for use with QEMU)
# By: Brian, Matthew, and Michael -- UCDenver CSCI 3453, Spring 2018

main () 
{
    echo -e "PINTOS-P2: USERPROG -- ITEMIZED PASS/FAIL TESTING SCRIPT\n"
    echo -e "NOTE: This script must be run from your Pintos 'src/userprog/' directory.\n"
    echo -e "This script will build Pintos, and if successful, will use QEMU"
    echo -e "to execute the tests that are not commented out in this script.\n"
    
    if [[ $1 == debug ]]; then
      echo -e "You are using DEBUG mode. When a test boots up, it will wait for"
      echo -e "you to begin debugging from your other enviroment. When you"
      echo -e "continue in your program, the program will output here.\n"
    fi
    
    read -p "Press the [ENTER] key to continue, or [CTRL]+[C] to abort testing."
    
    cd ~/pintos/src/userprog
    echo -e "\Building Pintos:"
    make all
    BUILD_SUCCESS=!$?
    
    if (( $BUILD_SUCCESS )); then
        
        cd build
        
        #test-args-none
        test-args-single
        #test-args-multiple
        #test-args-many
        #test-args-dbl-space
        
        #test-sc-bad-sp
        #test-sc-bad-arg
        #test-sc-boundary
        #test-sc-boundary-2
        #test-sc-boundary-3
        
        #test-halt
        #test-exit
        
        #test-create-normal
        #test-create-empty
        #test-create-null
        #test-create-bad-ptr
        #test-create-long
        #test-create-exists
        #test-create-bound
        
        #test-open-normal
        #test-open-missing
        #test-open-boundary
        #test-open-empty
        #test-open-null
        #test-open-bad-ptr
        #test-open-twice
        
        #test-close-normal
        #test-close-twice
        #test-close-stdin
        #test-close-stdout
        #test-close-bad-fd
        
        #test-read-normal
        #test-read-bad-ptr
        #test-read-boundary
        #test-read-zero
        #test-read-stdout
        #test-read-bad-fd
        
        #test-write-normal
        #test-write-bad-ptr
        #test-write-boundary
        #test-write-zero
        #test-write-stdin
        #test-write-bad-fd
        
        #test-exec-once
        #test-exec-arg
        #test-exec-bound
        #test-exec-bound-2
        #test-exec-bound-3
        #test-exec-multiple
        #test-exec-missing
        #test-exec-bad-ptr
        
        #test-wait-simple
        #test-wait-twice
        #test-wait-killed
        #test-wait-bad-pid
        
        #test-multi-recurse
        #test-multi-child-fd
        
        #test-rox-simple
        #test-rox-child
        #test-rox-multichild
        
        #test-bad-read
        #test-bad-write
        #test-bad-read2
        #test-bad-write2
        #test-bad-jump
        #test-bad-jump2
        
        #test-multi-oom
        
        #test-lg-create
        #test-lg-full
        #test-lg-random
        #test-lg-seq-block
        #test-lg-seq-random
        
        #test-sm-create
        #test-sm-full 
        #test-sm-random
        #test-sm-seq-block 
        #test-sm-seq-random
        
        #test-syn-read 
        #test-syn-remove 
        #test-syn-write
        
        echo -e "\nScript execution terminated successfully."
    else 
        echo -e "\nError: Failed to build pintos. No tests were run."
    fi
}

#Pintos doesn't throw any error for a bogus test.
test-bogus()
{
    echo -e "\nBooting pintos for test: bogus"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bogus -a bogus -- -q  -f run bogus < /dev/null 2> tests/userprog/bogus.errors |tee tests/userprog/bogus.output
    echo -e "Result:"
    #perl -I../.. ../../tests/userprog/bogus.ck tests/userprog/bogus tests/userprog/bogus.result
}

test-args-none() 
{
    echo -e "\nBooting pintos for test: args-none"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/args-none -a args-none -- -q  -f run args-none < /dev/null 2> tests/userprog/args-none.errors |tee tests/userprog/args-none.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/args-none.ck tests/userprog/args-none tests/userprog/args-none.result
}

test-args-single() 
{
    echo -e "\nBooting pintos for test: args-single"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/args-single -a args-single -- -q  -f run 'args-single onearg' < /dev/null 2> tests/userprog/args-single.errors |tee tests/userprog/args-single.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/args-single.ck tests/userprog/args-single tests/userprog/args-single.result
}

test-args-multiple() 
{
    echo -e "\nBooting pintos for test: args-multiple"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/args-multiple -a args-multiple -- -q  -f run 'args-multiple some arguments for you!' < /dev/null 2> tests/userprog/args-multiple.errors |tee tests/userprog/args-multiple.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/args-multiple.ck tests/userprog/args-multiple tests/userprog/args-multiple.result
}

test-args-many() 
{
    echo -e "\nBooting pintos for test: args-many"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/args-many -a args-many -- -q  -f run 'args-many a b c d e f g h i j k l m n o p q r s t u v' < /dev/null 2> tests/userprog/args-many.errors |tee tests/userprog/args-many.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/args-many.ck tests/userprog/args-many tests/userprog/args-many.result
}

test-args-dbl-space() 
{
    echo -e "\nBooting pintos for test: args-dbl-space"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/args-dbl-space -a args-dbl-space -- -q  -f run 'args-dbl-space two  spaces!' < /dev/null 2> tests/userprog/args-dbl-space.errors |tee tests/userprog/args-dbl-space.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/args-dbl-space.ck tests/userprog/args-dbl-space tests/userprog/args-dbl-space.result
}

test-sc-bad-sp() 
{
    echo -e "\nBooting pintos for test: sc-bad-sp"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/sc-bad-sp -a sc-bad-sp -- -q  -f run sc-bad-sp < /dev/null 2> tests/userprog/sc-bad-sp.errors |tee tests/userprog/sc-bad-sp.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/sc-bad-sp.ck tests/userprog/sc-bad-sp tests/userprog/sc-bad-sp.result
}

test-sc-bad-arg() 
{
    echo -e "\nBooting pintos for test: sc-bad-arg"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/sc-bad-arg -a sc-bad-arg -- -q  -f run sc-bad-arg < /dev/null 2> tests/userprog/sc-bad-arg.errors |tee tests/userprog/sc-bad-arg.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/sc-bad-arg.ck tests/userprog/sc-bad-arg tests/userprog/sc-bad-arg.result
}

test-sc-boundary() 
{
    echo -e "\nBooting pintos for test: sc-boundary"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/sc-boundary -a sc-boundary -- -q  -f run sc-boundary < /dev/null 2> tests/userprog/sc-boundary.errors |tee tests/userprog/sc-boundary.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/sc-boundary.ck tests/userprog/sc-boundary tests/userprog/sc-boundary.result
}

test-sc-boundary-2() 
{
    echo -e "\nBooting pintos for test: sc-boundary-2"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/sc-boundary-2 -a sc-boundary-2 -- -q  -f run sc-boundary-2 < /dev/null 2> tests/userprog/sc-boundary-2.errors |tee tests/userprog/sc-boundary-2.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/sc-boundary-2.ck tests/userprog/sc-boundary-2 tests/userprog/sc-boundary-2.result
}

test-sc-boundary-3() 
{
    echo -e "\nBooting pintos for test: sc-boundary-3"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/sc-boundary-3 -a sc-boundary-3 -- -q  -f run sc-boundary-3 < /dev/null 2> tests/userprog/sc-boundary-3.errors |tee tests/userprog/sc-boundary-3.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/sc-boundary-3.ck tests/userprog/sc-boundary-3 tests/userprog/sc-boundary-3.result
}

test-halt() 
{
    echo -e "\nBooting pintos for test: halt"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/halt -a halt -- -q  -f run halt < /dev/null 2> tests/userprog/halt.errors |tee tests/userprog/halt.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/halt.ck tests/userprog/halt tests/userprog/halt.result
}

test-exit() 
{
    echo -e "\nBooting pintos for test: exit"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exit -a exit -- -q  -f run exit < /dev/null 2> tests/userprog/exit.errors |tee tests/userprog/exit.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exit.ck tests/userprog/exit tests/userprog/exit.result
}

test-create-normal() 
{
    echo -e "\nBooting pintos for test: create-normal"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-normal -a create-normal -- -q  -f run create-normal < /dev/null 2> tests/userprog/create-normal.errors |tee tests/userprog/create-normal.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-normal.ck tests/userprog/create-normal tests/userprog/create-normal.result
}

test-create-empty() 
{
    echo -e "\nBooting pintos for test: create-empty"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-empty -a create-empty -- -q  -f run create-empty < /dev/null 2> tests/userprog/create-empty.errors |tee tests/userprog/create-empty.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-empty.ck tests/userprog/create-empty tests/userprog/create-empty.result
}

test-create-null() 
{
    echo -e "\nBooting pintos for test: create-null"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-null -a create-null -- -q  -f run create-null < /dev/null 2> tests/userprog/create-null.errors |tee tests/userprog/create-null.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-null.ck tests/userprog/create-null tests/userprog/create-null.result
}

test-create-bad-ptr() 
{
    echo -e "\nBooting pintos for test: create-bad-ptr"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-bad-ptr -a create-bad-ptr -- -q  -f run create-bad-ptr < /dev/null 2> tests/userprog/create-bad-ptr.errors |tee tests/userprog/create-bad-ptr.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-bad-ptr.ck tests/userprog/create-bad-ptr tests/userprog/create-bad-ptr.result
}

test-create-long() 
{
    echo -e "\nBooting pintos for test: create-long"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-long -a create-long -- -q  -f run create-long < /dev/null 2> tests/userprog/create-long.errors |tee tests/userprog/create-long.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-long.ck tests/userprog/create-long tests/userprog/create-long.result
}

test-create-exists() 
{
    echo -e "\nBooting pintos for test: create-exists"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-exists -a create-exists -- -q  -f run create-exists < /dev/null 2> tests/userprog/create-exists.errors |tee tests/userprog/create-exists.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-exists.ck tests/userprog/create-exists tests/userprog/create-exists.result
}

test-create-bound() 
{
    echo -e "\nBooting pintos for test: create-bound"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/create-bound -a create-bound -- -q  -f run create-bound < /dev/null 2> tests/userprog/create-bound.errors |tee tests/userprog/create-bound.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/create-bound.ck tests/userprog/create-bound tests/userprog/create-bound.result
}

test-open-normal() 
{
    echo -e "\nBooting pintos for test: open-normal"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-normal -a open-normal -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run open-normal < /dev/null 2> tests/userprog/open-normal.errors |tee tests/userprog/open-normal.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-normal.ck tests/userprog/open-normal tests/userprog/open-normal.result
}

test-open-missing() 
{
    echo -e "\nBooting pintos for test: open-missing"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-missing -a open-missing -- -q  -f run open-missing < /dev/null 2> tests/userprog/open-missing.errors |tee tests/userprog/open-missing.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-missing.ck tests/userprog/open-missing tests/userprog/open-missing.result
}

test-open-boundary() 
{
    echo -e "\nBooting pintos for test: open-boundary"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-boundary -a open-boundary -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run open-boundary < /dev/null 2> tests/userprog/open-boundary.errors |tee tests/userprog/open-boundary.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-boundary.ck tests/userprog/open-boundary tests/userprog/open-boundary.result
}

test-open-empty() 
{
    echo -e "\nBooting pintos for test: open-empty"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-empty -a open-empty -- -q  -f run open-empty < /dev/null 2> tests/userprog/open-empty.errors |tee tests/userprog/open-empty.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-empty.ck tests/userprog/open-empty tests/userprog/open-empty.result
}

test-open-null() 
{
    echo -e "\nBooting pintos for test: open-null"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-null -a open-null -- -q  -f run open-null < /dev/null 2> tests/userprog/open-null.errors |tee tests/userprog/open-null.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-null.ck tests/userprog/open-null tests/userprog/open-null.result
}

test-open-bad-ptr() 
{
    echo -e "\nBooting pintos for test: open-bad-ptr"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-bad-ptr -a open-bad-ptr -- -q  -f run open-bad-ptr < /dev/null 2> tests/userprog/open-bad-ptr.errors |tee tests/userprog/open-bad-ptr.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-bad-ptr.ck tests/userprog/open-bad-ptr tests/userprog/open-bad-ptr.result
}

test-open-twice() 
{
    echo -e "\nBooting pintos for test: open-twice"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/open-twice -a open-twice -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run open-twice < /dev/null 2> tests/userprog/open-twice.errors |tee tests/userprog/open-twice.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/open-twice.ck tests/userprog/open-twice tests/userprog/open-twice.result
}

test-close-normal() 
{
    echo -e "\nBooting pintos for test: close-normal"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/close-normal -a close-normal -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run close-normal < /dev/null 2> tests/userprog/close-normal.errors |tee tests/userprog/close-normal.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/close-normal.ck tests/userprog/close-normal tests/userprog/close-normal.result
}

test-close-twice() 
{
    echo -e "\nBooting pintos for test: close-twice"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/close-twice -a close-twice -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run close-twice < /dev/null 2> tests/userprog/close-twice.errors |tee tests/userprog/close-twice.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/close-twice.ck tests/userprog/close-twice tests/userprog/close-twice.result
}

test-close-stdin() 
{
    echo -e "\nBooting pintos for test: close-stdin"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/close-stdin -a close-stdin -- -q  -f run close-stdin < /dev/null 2> tests/userprog/close-stdin.errors |tee tests/userprog/close-stdin.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/close-stdin.ck tests/userprog/close-stdin tests/userprog/close-stdin.result
}

test-close-stdout() 
{
    echo -e "\nBooting pintos for test: close-stdout"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/close-stdout -a close-stdout -- -q  -f run close-stdout < /dev/null 2> tests/userprog/close-stdout.errors |tee tests/userprog/close-stdout.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/close-stdout.ck tests/userprog/close-stdout tests/userprog/close-stdout.result
}

test-close-bad-fd() 
{
    echo -e "\nBooting pintos for test: close-bad-fd"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/close-bad-fd -a close-bad-fd -- -q  -f run close-bad-fd < /dev/null 2> tests/userprog/close-bad-fd.errors |tee tests/userprog/close-bad-fd.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/close-bad-fd.ck tests/userprog/close-bad-fd tests/userprog/close-bad-fd.result
}

test-read-normal() 
{
    echo -e "\nBooting pintos for test: read-normal"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-normal -a read-normal -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run read-normal < /dev/null 2> tests/userprog/read-normal.errors |tee tests/userprog/read-normal.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-normal.ck tests/userprog/read-normal tests/userprog/read-normal.result
}

test-read-bad-ptr() 
{
    echo -e "\nBooting pintos for test: read-bad-ptr"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-bad-ptr -a read-bad-ptr -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run read-bad-ptr < /dev/null 2> tests/userprog/read-bad-ptr.errors |tee tests/userprog/read-bad-ptr.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-bad-ptr.ck tests/userprog/read-bad-ptr tests/userprog/read-bad-ptr.result
}

test-read-boundary() 
{
    echo -e "\nBooting pintos for test: read-boundary"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-boundary -a read-boundary -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run read-boundary < /dev/null 2> tests/userprog/read-boundary.errors |tee tests/userprog/read-boundary.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-boundary.ck tests/userprog/read-boundary tests/userprog/read-boundary.result
}

test-read-zero() 
{
    echo -e "\nBooting pintos for test: read-zero"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-zero -a read-zero -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run read-zero < /dev/null 2> tests/userprog/read-zero.errors |tee tests/userprog/read-zero.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-zero.ck tests/userprog/read-zero tests/userprog/read-zero.result
}

test-read-stdout() 
{
    echo -e "\nBooting pintos for test: read-stdout"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-stdout -a read-stdout -- -q  -f run read-stdout < /dev/null 2> tests/userprog/read-stdout.errors |tee tests/userprog/read-stdout.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-stdout.ck tests/userprog/read-stdout tests/userprog/read-stdout.result
}

test-read-bad-fd() 
{
    echo -e "\nBooting pintos for test: read-bad-fd"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/read-bad-fd -a read-bad-fd -- -q  -f run read-bad-fd < /dev/null 2> tests/userprog/read-bad-fd.errors |tee tests/userprog/read-bad-fd.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/read-bad-fd.ck tests/userprog/read-bad-fd tests/userprog/read-bad-fd.result
}

test-write-normal() 
{
    echo -e "\nBooting pintos for test: write-normal"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-normal -a write-normal -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run write-normal < /dev/null 2> tests/userprog/write-normal.errors |tee tests/userprog/write-normal.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-normal.ck tests/userprog/write-normal tests/userprog/write-normal.result
}

test-write-bad-ptr() 
{
    echo -e "\nBooting pintos for test: write-bad-ptr"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-bad-ptr -a write-bad-ptr -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run write-bad-ptr < /dev/null 2> tests/userprog/write-bad-ptr.errors |tee tests/userprog/write-bad-ptr.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-bad-ptr.ck tests/userprog/write-bad-ptr tests/userprog/write-bad-ptr.result
}

test-write-boundary() 
{
    echo -e "\nBooting pintos for test: write-boundary"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-boundary -a write-boundary -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run write-boundary < /dev/null 2> tests/userprog/write-boundary.errors |tee tests/userprog/write-boundary.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-boundary.ck tests/userprog/write-boundary tests/userprog/write-boundary.result
}

test-write-zero() 
{
    echo -e "\nBooting pintos for test: write-zero"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-zero -a write-zero -p ../../tests/userprog/sample.txt -a sample.txt -- -q  -f run write-zero < /dev/null 2> tests/userprog/write-zero.errors |tee tests/userprog/write-zero.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-zero.ck tests/userprog/write-zero tests/userprog/write-zero.result
}

test-write-stdin() 
{
    echo -e "\nBooting pintos for test: write-stdin"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-stdin -a write-stdin -- -q  -f run write-stdin < /dev/null 2> tests/userprog/write-stdin.errors |tee tests/userprog/write-stdin.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-stdin.ck tests/userprog/write-stdin tests/userprog/write-stdin.result
}

test-write-bad-fd() 
{
    echo -e "\nBooting pintos for test: write-bad-fd"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/write-bad-fd -a write-bad-fd -- -q  -f run write-bad-fd < /dev/null 2> tests/userprog/write-bad-fd.errors |tee tests/userprog/write-bad-fd.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/write-bad-fd.ck tests/userprog/write-bad-fd tests/userprog/write-bad-fd.result
}

test-exec-once() 
{
    echo -e "\nBooting pintos for test: exec-once"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-once -a exec-once -p tests/userprog/child-simple -a child-simple -- -q  -f run exec-once < /dev/null 2> tests/userprog/exec-once.errors |tee tests/userprog/exec-once.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-once.ck tests/userprog/exec-once tests/userprog/exec-once.result
}

test-exec-arg() 
{
    echo -e "\nBooting pintos for test: exec-arg"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-arg -a exec-arg -p tests/userprog/child-args -a child-args -- -q  -f run exec-arg < /dev/null 2> tests/userprog/exec-arg.errors |tee tests/userprog/exec-arg.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-arg.ck tests/userprog/exec-arg tests/userprog/exec-arg.result
}

test-exec-bound() 
{
    echo -e "\nBooting pintos for test: exec-bound"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-bound -a exec-bound -p tests/userprog/child-args -a child-args -- -q  -f run exec-bound < /dev/null 2> tests/userprog/exec-bound.errors |tee tests/userprog/exec-bound.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-bound.ck tests/userprog/exec-bound tests/userprog/exec-bound.result
}

test-exec-bound-2() 
{
    echo -e "\nBooting pintos for test: exec-bound-2"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-bound-2 -a exec-bound-2 -- -q  -f run exec-bound-2 < /dev/null 2> tests/userprog/exec-bound-2.errors |tee tests/userprog/exec-bound-2.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-bound-2.ck tests/userprog/exec-bound-2 tests/userprog/exec-bound-2.result
}

test-exec-bound-3() 
{
    echo -e "\nBooting pintos for test: exec-bound"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-bound-3 -a exec-bound-3 -- -q  -f run exec-bound-3 < /dev/null 2> tests/userprog/exec-bound-3.errors |tee tests/userprog/exec-bound-3.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-bound-3.ck tests/userprog/exec-bound-3 tests/userprog/exec-bound-3.result
}

test-exec-multiple() 
{
    echo -e "\nBooting pintos for test: exec-multiple"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-multiple -a exec-multiple -p tests/userprog/child-simple -a child-simple -- -q  -f run exec-multiple < /dev/null 2> tests/userprog/exec-multiple.errors |tee tests/userprog/exec-multiple.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-multiple.ck tests/userprog/exec-multiple tests/userprog/exec-multiple.result
}

test-exec-missing() 
{
    echo -e "\nBooting pintos for test: exec-missing"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-missing -a exec-missing -- -q  -f run exec-missing < /dev/null 2> tests/userprog/exec-missing.errors |tee tests/userprog/exec-missing.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-missing.ck tests/userprog/exec-missing tests/userprog/exec-missing.result
}

test-exec-bad-ptr() 
{
    echo -e "\nBooting pintos for test: exec-bad-ptr"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/exec-bad-ptr -a exec-bad-ptr -- -q  -f run exec-bad-ptr < /dev/null 2> tests/userprog/exec-bad-ptr.errors |tee tests/userprog/exec-bad-ptr.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/exec-bad-ptr.ck tests/userprog/exec-bad-ptr tests/userprog/exec-bad-ptr.result
}

test-wait-simple() 
{
    echo -e "\nBooting pintos for test: wait-simple"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/wait-simple -a wait-simple -p tests/userprog/child-simple -a child-simple -- -q  -f run wait-simple < /dev/null 2> tests/userprog/wait-simple.errors |tee tests/userprog/wait-simple.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/wait-simple.ck tests/userprog/wait-simple tests/userprog/wait-simple.result
}

test-wait-twice() 
{
    echo -e "\nBooting pintos for test: wait-twice"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/wait-twice -a wait-twice -p tests/userprog/child-simple -a child-simple -- -q  -f run wait-twice < /dev/null 2> tests/userprog/wait-twice.errors |tee tests/userprog/wait-twice.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/wait-twice.ck tests/userprog/wait-twice tests/userprog/wait-twice.result
}

test-wait-killed() 
{
    echo -e "\nBooting pintos for test: wait-killed"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/wait-killed -a wait-killed -p tests/userprog/child-bad -a child-bad -- -q  -f run wait-killed < /dev/null 2> tests/userprog/wait-killed.errors |tee tests/userprog/wait-killed.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/wait-killed.ck tests/userprog/wait-killed tests/userprog/wait-killed.result
}

test-wait-bad-pid() 
{
    echo -e "\nBooting pintos for test: wait-bad-pid"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/wait-bad-pid -a wait-bad-pid -- -q  -f run wait-bad-pid < /dev/null 2> tests/userprog/wait-bad-pid.errors |tee tests/userprog/wait-bad-pid.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/wait-bad-pid.ck tests/userprog/wait-bad-pid tests/userprog/wait-bad-pid.result
}

test-multi-recurse() 
{
    echo -e "\nBooting pintos for test: multi-recurse"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/multi-recurse -a multi-recurse -- -q  -f run 'multi-recurse 15' < /dev/null 2> tests/userprog/multi-recurse.errors |tee tests/userprog/multi-recurse.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/multi-recurse.ck tests/userprog/multi-recurse tests/userprog/multi-recurse.result
}

test-multi-child-fd() 
{
    echo -e "\nBooting pintos for test: multi-child-fd"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/multi-child-fd -a multi-child-fd -p ../../tests/userprog/sample.txt -a sample.txt -p tests/userprog/child-close -a child-close -- -q  -f run multi-child-fd < /dev/null 2> tests/userprog/multi-child-fd.errors |tee tests/userprog/multi-child-fd.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/multi-child-fd.ck tests/userprog/multi-child-fd tests/userprog/multi-child-fd.result
}

test-rox-simple() 
{
    echo -e "\nBooting pintos for test: rox-simple"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/rox-simple -a rox-simple -- -q  -f run rox-simple < /dev/null 2> tests/userprog/rox-simple.errors |tee tests/userprog/rox-simple.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/rox-simple.ck tests/userprog/rox-simple tests/userprog/rox-simple.result
}

test-rox-child() 
{
    echo -e "\nBooting pintos for test: rox-child"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/rox-child -a rox-child -p tests/userprog/child-rox -a child-rox -- -q  -f run rox-child < /dev/null 2> tests/userprog/rox-child.errors |tee tests/userprog/rox-child.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/rox-child.ck tests/userprog/rox-child tests/userprog/rox-child.result
}

test-rox-multichild() 
{
    echo -e "\nBooting pintos for test: rox-multichild"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/rox-multichild -a rox-multichild -p tests/userprog/child-rox -a child-rox -- -q  -f run rox-multichild < /dev/null 2> tests/userprog/rox-multichild.errors |tee tests/userprog/rox-multichild.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/rox-multichild.ck tests/userprog/rox-multichild tests/userprog/rox-multichild.result
}

test-bad-read() 
{
    echo -e "\nBooting pintos for test: bad-read"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-read -a bad-read -- -q  -f run bad-read < /dev/null 2> tests/userprog/bad-read.errors |tee tests/userprog/bad-read.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-read.ck tests/userprog/bad-read tests/userprog/bad-read.result
}

test-bad-write() 
{
    echo -e "\nBooting pintos for test: bad-write"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-write -a bad-write -- -q  -f run bad-write < /dev/null 2> tests/userprog/bad-write.errors |tee tests/userprog/bad-write.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-write.ck tests/userprog/bad-write tests/userprog/bad-write.result
}

test-bad-read2() 
{
    echo -e "\nBooting pintos for test: bad-read2"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-read2 -a bad-read2 -- -q  -f run bad-read2 < /dev/null 2> tests/userprog/bad-read2.errors |tee tests/userprog/bad-read2.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-read2.ck tests/userprog/bad-read2 tests/userprog/bad-read2.result
}

test-bad-write2() 
{
    echo -e "\nBooting pintos for test: bad-write2"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-write2 -a bad-write2 -- -q  -f run bad-write2 < /dev/null 2> tests/userprog/bad-write2.errors |tee tests/userprog/bad-write2.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-write2.ck tests/userprog/bad-write2 tests/userprog/bad-write2.result
}

test-bad-jump() 
{
    echo -e "\nBooting pintos for test: bad-jump"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-jump -a bad-jump -- -q  -f run bad-jump < /dev/null 2> tests/userprog/bad-jump.errors |tee tests/userprog/bad-jump.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-jump.ck tests/userprog/bad-jump tests/userprog/bad-jump.result
}

test-bad-jump2() 
{
    echo -e "\nBooting pintos for test: bad-jump2"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/userprog/bad-jump2 -a bad-jump2 -- -q  -f run bad-jump2 < /dev/null 2> tests/userprog/bad-jump2.errors |tee tests/userprog/bad-jump2.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/bad-jump2.ck tests/userprog/bad-jump2 tests/userprog/bad-jump2.result
}

test-multi-oom() 
{
    echo -e "\nBooting pintos for test: multi-oom"
    pintos -v -k -T 360 --qemu $GDB --filesys-size=2 -p tests/userprog/no-vm/multi-oom -a multi-oom -- -q  -f run multi-oom < /dev/null 2> tests/userprog/no-vm/multi-oom.errors |tee tests/userprog/no-vm/multi-oom.output
    echo -e "Result:"
    perl -I../.. ../../tests/userprog/no-vm/multi-oom.ck tests/userprog/no-vm/multi-oom tests/userprog/no-vm/multi-oom.result
}

test-lg-create() 
{
    echo -e "\nBooting pintos for test: lg-create"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/lg-create -a lg-create -- -q  -f run lg-create < /dev/null 2> tests/filesys/base/lg-create.errors |tee tests/filesys/base/lg-create.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/lg-create.ck tests/filesys/base/lg-create tests/filesys/base/lg-create.result
}

test-lg-full() 
{
    echo -e "\nBooting pintos for test: lg-full"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/lg-full -a lg-full -- -q  -f run lg-full < /dev/null 2> tests/filesys/base/lg-full.errors |tee tests/filesys/base/lg-full.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/lg-full.ck tests/filesys/base/lg-full tests/filesys/base/lg-full.result
}

test-lg-random() 
{
    echo -e "\nBooting pintos for test: lg-random"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/lg-random -a lg-random -- -q  -f run lg-random < /dev/null 2> tests/filesys/base/lg-random.errors |tee tests/filesys/base/lg-random.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/lg-random.ck tests/filesys/base/lg-random tests/filesys/base/lg-random.result
}

test-lg-seq-block() 
{
    echo -e "\nBooting pintos for test: lg-seq-block"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/lg-seq-block -a lg-seq-block -- -q  -f run lg-seq-block < /dev/null 2> tests/filesys/base/lg-seq-block.errors |tee tests/filesys/base/lg-seq-block.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/lg-seq-block.ck tests/filesys/base/lg-seq-block tests/filesys/base/lg-seq-block.result
}

test-lg-seq-random() 
{
    echo -e "\nBooting pintos for test: lg-seq-random"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/lg-seq-random -a lg-seq-random -- -q  -f run lg-seq-random < /dev/null 2> tests/filesys/base/lg-seq-random.errors |tee tests/filesys/base/lg-seq-random.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/lg-seq-random.ck tests/filesys/base/lg-seq-random tests/filesys/base/lg-seq-random.result
}

test-sm-create() 
{
    echo -e "\nBooting pintos for test: sm-create"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/sm-create -a sm-create -- -q  -f run sm-create < /dev/null 2> tests/filesys/base/sm-create.errors |tee tests/filesys/base/sm-create.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/sm-create.ck tests/filesys/base/sm-create tests/filesys/base/sm-create.result
}

test-sm-full() 
{
    echo -e "\nBooting pintos for test: sm-full"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/sm-full -a sm-full -- -q  -f run sm-full < /dev/null 2> tests/filesys/base/sm-full.errors |tee tests/filesys/base/sm-full.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/sm-full.ck tests/filesys/base/sm-full tests/filesys/base/sm-full.result
}

test-sm-random() 
{
    echo -e "\nBooting pintos for test: sm-random"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/sm-random -a sm-random -- -q  -f run sm-random < /dev/null 2> tests/filesys/base/sm-random.errors |tee tests/filesys/base/sm-random.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/sm-random.ck tests/filesys/base/sm-random tests/filesys/base/sm-random.result
}

test-sm-seq-block() 
{
    echo -e "\nBooting pintos for test: sm-seq-block"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/sm-seq-block -a sm-seq-block -- -q  -f run sm-seq-block < /dev/null 2> tests/filesys/base/sm-seq-block.errors |tee tests/filesys/base/sm-seq-block.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/sm-seq-block.ck tests/filesys/base/sm-seq-block tests/filesys/base/sm-seq-block.result
}

test-sm-seq-random() 
{
    echo -e "\nBooting pintos for test: sm-seq-random"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/sm-seq-random -a sm-seq-random -- -q  -f run sm-seq-random < /dev/null 2> tests/filesys/base/sm-seq-random.errors |tee tests/filesys/base/sm-seq-random.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/sm-seq-random.ck tests/filesys/base/sm-seq-random tests/filesys/base/sm-seq-random.result
}

test-syn-read() 
{
    echo -e "\nBooting pintos for test: syn-read"
    pintos -v -k -T 300 --qemu $GDB --filesys-size=2 -p tests/filesys/base/syn-read -a syn-read -p tests/filesys/base/child-syn-read -a child-syn-read -- -q  -f run syn-read < /dev/null 2> tests/filesys/base/syn-read.errors |tee tests/filesys/base/syn-read.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/syn-read.ck tests/filesys/base/syn-read tests/filesys/base/syn-read.result
}

test-syn-remove() 
{
    echo -e "\nBooting pintos for test: syn-remove"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/syn-remove -a syn-remove -- -q  -f run syn-remove < /dev/null 2> tests/filesys/base/syn-remove.errors |tee tests/filesys/base/syn-remove.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/syn-remove.ck tests/filesys/base/syn-remove tests/filesys/base/syn-remove.result
}

test-syn-write() 
{
    echo -e "\nBooting pintos for test: syn-write"
    pintos -v -k -T 60 --qemu $GDB --filesys-size=2 -p tests/filesys/base/syn-write -a syn-write -p tests/filesys/base/child-syn-wrt -a child-syn-wrt -- -q  -f run syn-write < /dev/null 2> tests/filesys/base/syn-write.errors |tee tests/filesys/base/syn-write.output
    echo -e "Result:"
    perl -I../.. ../../tests/filesys/base/syn-write.ck tests/filesys/base/syn-write tests/filesys/base/syn-write.result
}

if [[ $1 == debug ]]; then
  GDB=--gdb
fi
main "$@"
