#!/bin/bash

# http://stackoverflow.com/questions/392022/best-way-to-kill-all-child-processes/15139734#15139734
function killtree {
    local _pid=`cat /tmp/blinkypid`
    local _sig="SIGKILL"
    kill -stop ${_pid} # needed to stop quickly forking parent from producing children between child killing and parent killing
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -${_sig} ${_pid}
}


if [ -f /tmp/blinkypid ]; then
    killtree
fi

# remove previous files
rm -rf /apps/blinky