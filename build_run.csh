#!/bin/csh


#if any argument is supplied, this script will submit the run using *.run script
set run_scr_sub = 0
if( $#argv > 0 ) then
    set run_scr_sub = 1
endif



set RUNDIR = `./xmlquery RUNDIR -value`
set CASE = `./xmlquery CASE -value`

echo 'Delete *.log* file in RUNDIR'
/bin/rm $RUNDIR/*.log.*

echo 'Build and submit case:'$CASE
./{$CASE}.build || echo 'Model failed to buils' && exit -1

if ( $run_scr_sub == 0  ) then
    echo '*****************************************'
    echo 'SUBMITING THE RUN USING SUBMIT SCRIPT'
    echo '*****************************************'
    ./{$CASE}.submit|| echo 'Model failed to buils' && exit -1
else
    set BATCHSUBMIT = `./xmlquery BATCHSUBMIT  -value`
    echo '*****************************************'
    echo 'SUBMITING THE RUN USING ' $BATCHSUBMIT
    echo '*****************************************'
    $BATCHSUBMIT {$CASE}.run
endif
