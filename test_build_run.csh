#!/bin/csh
#set echo verbose

set clean = 0
if ( $#argv == 1 ) then
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
./{$CASE}.test_build || echo 'Model failed to buils' && exit -1
./{$CASE}.submit
