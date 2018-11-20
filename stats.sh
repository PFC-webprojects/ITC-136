#!/bin/bash

diskused=$( df -h | grep "/dev/sda1" | awk '{print $5}' )
memfree=$( free -mh | grep Mem: | awk '{print $7}' )
connections=$( netstat | grep tcp )
users=$( who | awk '{print $1}' )

echo "

\e[7mThis is a snapshot of your current system:\e[27m

\e[38;5;208;7mDisk Space Used:           $diskused
\e[38;5;31;7mFree Memory:               $memfree
\e[38;5;208;7mLogged-In Users:           $users
\e[38;5;31;7mOpen Internet Connections: $connections

"
