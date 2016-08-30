#!/usr/bin/python

ofilename = 'atm_files_compile_cmd_2ndhalf.txt'
ifilename = '/gpfs/mira-fs1/projects/HiRes_EarthSys_2/bsingh/tests_acme/SMS_Ln5.ne30_ne30.FC5AV1C-04.mira_ibm.linozne30/bld/atm/obj/Srcfiles'

ofile = open(ofilename, 'w')

#find number of lines in a file
tot_lines = sum(1 for line in open(ifilename) if line.rstrip())

#Number of lines to process
num_lines = tot_lines/2

#number of lines to skip in the begining
num_skip  = tot_lines/2 -1
i   = 0
i_p = 0
with open(ifilename, "r") as f:
    for x in f:        
        i = i + 1
        xstrp = x.strip()
        xrep1  = xstrp.replace('.F90','.o')
        xrep2  = xrep1.replace('.f90','.o')
        if(i>=num_skip and i_p<=num_lines):
            i_p = i_p + 1
            ofile.write(xrep2 + ': ' + xstrp + "\n")
            ofile.write("\t$(FC) -c $(INCLDIR) $(INCS) $(FFLAGS) $(FREEFLAGS) -O0 $<\n")
            
print i
print i_p
