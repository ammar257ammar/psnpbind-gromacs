#!/usr/bin/expect

set VARIANT [lindex $argv 0];

spawn gmx genion -s ${VARIANT}.tpr -o ${VARIANT}_solv_ions.gro -p ${VARIANT}.top -pname NA -nname CL -neutral

expect -re "SOL"

set output $expect_out(buffer)

set response [ exec grep "(            SOL" << $output | sed {s/Group[[:blank:]]*//} | sed {s/[[:blank:]]*(            SOL//} ]

send "$response\n"

expect eof


