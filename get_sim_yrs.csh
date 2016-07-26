#!/bin/csh
#set echo verbose 
set csmd = /autofs/nccs-svm1_home1/bsingh/CSM/titan
set partial_dir_name = upcam_l125_3d_scaling_pgi_titan_ntasks_ #partial name so that we can use it as wild card


cd $csmd

foreach dir(`ls -d ${partial_dir_name}*`)
    set sim_per_yr = `cat $dir/timing/ccsm_timing.{$dir}* | grep "Model Throughput" |cut -d':' -f2`
    echo $dir : $sim_per_yr

end
