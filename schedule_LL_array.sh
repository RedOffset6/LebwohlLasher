#!/bin/bash

#SBATCH --account=CHEM014742
#SBATCH --job-name=Ben_LL
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5GB
#SBATCH --time=0:40:00
#SBATCH --array=1-10
echo 'Computing LL Model of a Liquid Cryatal'

module load languages/miniconda
source activate testenv

size=$((SLURM_ARRAY_TASK_ID*75))

python3 LebwohlLasher.py 50 $size 0.5 0
