#!/bin/csh

#files to download have to start with "inputdata" directory
set files_to_download = (  \
    d/f/e)

set svn_path          = https://acme-svn2.ornl.gov/acme-repo/acme/
set mach_acme_inp_dir = /lustre/atlas1/cli900/world-shared/cesm/ 


foreach file($files_to_download)
    
    echo $svn_path$file
    
end
