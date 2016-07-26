#!/bin/csh

tar cf - -C $1 . | tar xf -

exit 0
