#!/bin/csh

/usr/bin/rsync -avp --include="*/" --include='*.cam.h0.*.nc' --exclude='*'  $1 $2
