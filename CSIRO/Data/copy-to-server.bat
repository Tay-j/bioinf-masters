D:
cd Documents\GitHub\bioinf-masters\CSIRO\Data
@echo off
set /p file="Enter File: "
pscp -P 22 -pw M6_a9!@1.B.C. %file% tayj1@spartan.hpc.unimelb.edu.au: