#!/bin/csh


# if argument supplied is run, the script will use .run script
# if argument supplied is clean, the script will clean the build and then use .submit script
set run_scr_sub = 0
set clean       = 0
if( $#argv > 0 ) then
    if ( $1 == 'run' ) then
	set run_scr_sub = 1
    endif

    if ( $1 == 'clean' ) then
	set clean = 1
    endif
endif



set RUNDIR = `./xmlquery RUNDIR -value`
set CASE = `./xmlquery CASE -value`

echo 'Delete *.log* file in RUNDIR'
/bin/rm $RUNDIR/*.log.*

echo 'Build and submit case:'$CASE
if ( $clean == 1 ) then
    echo '********************'
    echo 'cleaning the code...'
    echo '********************'
    ./{$CASE}.clean_build
    /bin/rm -rf $RUNDIR/*
endif

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
