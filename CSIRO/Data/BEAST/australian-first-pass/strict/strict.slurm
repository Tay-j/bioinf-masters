#!/bin/bash
#SBATCH --qos=covid19
#SBATCH --partition gpgpu
#SBATCH --gres=gpu:1
#SBATCH --time=120:00:00

# Load required modules
module load fosscuda/2019b
module unload beast
module load beast/1.10.4

# Run BEAST
beast -overwrite -beagle_GPU australian_H7_aligned_SC.xml

