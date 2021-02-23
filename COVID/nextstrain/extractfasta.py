import os
os.chdir("D:\\Documents\\John\\University\\Master\\Project\\Data\\COVID\\nextstrain")

import bioinfokit
import bioinfokit.analys
bioinfokit.analys.fasta.extract_seq("mmsa_2021-02-15.fa","get_sequences.txt")