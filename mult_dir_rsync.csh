#!/bin/csh
set echo verbose
set dirs      = ( v1ac15 )#  v1ac19  v1af15 v1af19 ) #( v01 )#  v01  v03  v04  v05 )
set to_path   = /global/project/projectdirs/PNNL-PJR/bsingh/amwg_out/climo/03282016_pma/
set from_path = `pwd`
set rmt_mach = $edi

foreach dir ($dirs)
    echo processing $dir ...
    /usr/bin/rsync -avp ${from_path}/$dir {$rmt_mach}:${to_path}
end
