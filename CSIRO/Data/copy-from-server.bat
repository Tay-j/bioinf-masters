D:
cd Documents\GitHub\bioinf-masters\CSIRO\
@echo off
set /p file="Enter File: "
pscp -P 22 -pw M6_a9!@1.B.C. tayj1@spartan.hpc.unimelb.edu.au:%file% .