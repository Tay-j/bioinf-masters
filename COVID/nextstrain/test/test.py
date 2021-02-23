import os
os.chdir("D:\\Documents\\John\\University\\Master\\Project\\Data\\COVID\\nextstrain")

import bioinfokit
import bioinfokit.analys
bioinfokit.analys.fasta.extract_seq("test.fasta","test.txt")