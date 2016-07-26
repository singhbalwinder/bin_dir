#!/bin/csh
#set echo verbose


set RUNDIR = `./xmlquery RUNDIR -value`
set CASE = `./xmlquery CASE -value`

echo 'Delete *.log* file in RUNDIR'
/bin/rm $RUNDIR/*.log.*

echo 'Build and submit case:'$CASE
./{$CASE}.test_build || echo 'Model failed to buils' && exit -1
./{$CASE}.submit
