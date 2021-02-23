D:
@echo off
set /p file="Enter File: "
java -Xmx16g -jar Documents\John\University\Master\Project\Tools\BEASTv2.6.3\lib\launcher.jar -threads 4 Documents\GitHub\bioinf-masters\BEAST_run\%file%.xml 