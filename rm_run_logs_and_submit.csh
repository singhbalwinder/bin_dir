#!/bin/csh

set RUNDIR = `./xmlquery RUNDIR -value`
set CASE = `./xmlquery CASE -value`

echo 'Delete *.log* file in RUNDIR'
/bin/rm $RUNDIR/*.log.*

set BATCHSUBMIT = `./xmlquery BATCHSUBMIT  -value`
echo '*****************************************'
echo 'SUBMITING THE RUN USING ' $BATCHSUBMIT
echo '*****************************************'
$BATCHSUBMIT {$CASE}.run
