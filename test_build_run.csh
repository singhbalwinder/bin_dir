#!/bin/csh
#set echo verbose

set clean = 0
set cmdargs = '_no_'
if ( $#argv >= 1 ) then
    if ( $1 == 'clean' ) then
	set clean = 1
    else
	echo 'please specify a valid argument:' $1
	exit -1
    endif
    if ( $#argv == 2 ) then
	set cmdargs = $2
    endif
endif

set RUNDIR = `./xmlquery RUNDIR -value`
set BLDDIR = `./xmlquery EXEROOT -value`
set CASE = `./xmlquery CASE -value`

echo 'Delete *.log* file in RUNDIR'
/bin/rm $RUNDIR/*.log.*

echo 'Delete *.bldlog* file in BLDDIR'
/bin/rm $BLDDIR/*.bldlog.*

echo 'Build and submit case:'$CASE
if ( $clean == 1 ) then
    echo '********************'
    echo 'cleaning the code with' $cmdargs 'command line option(s)'
    echo '********************'
    if ( $cmdargs == '_no_') then
	set cmdargs = ''
    endif
    ./{$CASE}.clean_build $cmdargs    
    /bin/rm -rf $RUNDIR/*
endif
echo 'Remove Test status files...'
/bin/rm TestStatus.log TestStatus CaseStatus
echo 'Regenerate CaseStatus file ...'
touch CaseStatus

./{$CASE}.test_build || echo 'Model failed to buils' && exit -1
./{$CASE}.submit
