#!/bin/csh

set casename  = tms_restart_prb_run_wo_rstrt_pgi
set caseroot  = /autofs/nccs-svm1_home1/bsingh/CSM/CMIP5
set outfile   = fort.102
set outdir    = 1st_run_out
set run_time1 = 00:30:00
set run_time2 = 00:05:00
set rem_files = ( clubb_intr. physpkg. vertical_diffusion. ) # List of files to be removed from the bld directory [NOTE: wild card will be added at the end]


echo 'cd into caseroot dir'

cd $caseroot/$casename

set rundir = `./xmlquery -value RUNDIR` 

echo 'Remove run directory'
/bin/rm -r $rundir

echo 'Remove files from bld directory'
set blddir = `./xmlquery -value EXEROOT`
foreach ofile ($rem_files) 
    echo 'Removing '$ofile' from bld dir...'
    /bin/rm $blddir/atm/obj/{$ofile}*
end

echo 'prepare for initial run'
set stop_n   = 146 #9
set stop_opt = nsteps
set rest_n   = 144 #3 #5
set rest_opt = nsteps #ndays #nsteps #ndays

./xmlchange  STOP_N=$stop_n 
./xmlchange  STOP_OPTION=$stop_opt

./xmlchange REST_N=$rest_n 
./xmlchange REST_OPTION=$rest_opt

./xmlchange CONTINUE_RUN=FALSE

sed -i 's/^#PBS  -l walltime=.*/#PBS  -l walltime='$run_time1' /' {$casename}.run

build_run.csh || echo 'Build or run failed' && exit -1

echo 'wait until job is done'

while ( 1 )
    set is_running = `qstat -u bsingh |grep debug |grep -vw C| wc -l`
    if ( $is_running > 0  ) then
	echo 'waiting for queue to clear'
        sleep 5
    else
	echo 'save the output'
	cd $rundir
 	/bin/mkdir -p $outdir
	/bin/mv $outfile $outdir/
	/bin/mv *.log.*  $outdir/
	/bin/cp *_in $outdir/
	cd $caseroot/$casename
        echo 'prepare the restart run'
	set stop_n   = 1
	set stop_opt = nsteps
	set rest_n   = 3
	set rest_opt = ndays

	./xmlchange  STOP_N=$stop_n
	./xmlchange  STOP_OPTION=$stop_opt

	./xmlchange REST_N=$rest_n
	./xmlchange REST_OPTION=$rest_opt

	./xmlchange CONTINUE_RUN=TRUE
        echo 'Submitted to DEBUG queue'
	sed -i 's/^#PBS  -l walltime=.*/#PBS  -l walltime='$run_time2' /' {$casename}.run
        ./$casename.submit ||echo 'Model failed to submit(1) run' && exit -1
        break
     endif
end





