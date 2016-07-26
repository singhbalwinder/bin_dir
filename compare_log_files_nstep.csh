#!/bin/csh

set other_dir = 1st_run_out
set nstep = $1

gunzip atm.log.*
grep nstep atm.log.* |grep " "$nstep" " >& 1tmp_nstep_${nstep}
cd $other_dir
gunzip atm.log.*
grep nstep atm.log.* |grep " "$nstep" " >& 2tmp_nstep_${nstep}

pyunload
cd -
meld 1tmp_nstep_{$nstep} $other_dir/2tmp_nstep_{$nstep}

