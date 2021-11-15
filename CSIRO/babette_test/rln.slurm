#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=32G
#SBATCH --time=6:00:00

# Load required modules

# Run BEAST
beast australian_H7_aligned.fasta.xml
