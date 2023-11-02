#!/bin/bash

#SBATCH --account=CHEM014742
#SBATCH --job-name=Ben_LL
#SBATCH --partition=veryshort
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=900M
#SBATCH --time=0:05:00
#SBATCH --array=1-8
echo 'Computing LL Model of a Liquid Cryatal'

module load languages/miniconda
source activate testenv

size=$((SLURM_ARRAY_TASK_ID*25))

python3 LebwohlLasher.py 50 $size 0.5 0
