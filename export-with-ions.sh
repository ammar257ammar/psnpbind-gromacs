#!/usr/bin/expect

set VARIANT [lindex $argv 0];

spawn gmx trjconv -f ${VARIANT}.trr -s ${VARIANT}.tpr -center -o ${VARIANT}_final.pdb

expect -re "non-Water"

set output $expect_out(buffer)

set response [ exec grep "(      non-Water" << $output | sed {s/Group[[:blank:]]*//} | sed {s/[[:blank:]]*(      non-Water//} ]

send "$response $response\n"

expect eof


