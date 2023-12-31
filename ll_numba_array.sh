#!/bin/bash

#SBATCH --account=PHYS030544
#SBATCH --job-name=Ben_LL
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5GB
#SBATCH --time=0:30:00
#SBATCH --array=1-10

echo 'running numba environment test'

module load languages/miniconda

#echo "Before activation: $(which python)"

#/mnt/storage/software/languages/miniconda/miniconda3.11.3-CompressAI-Vision0.1.3/condabin/conda activate desktop_clone_env
#conda init bash
#possibly I need to run "conda init bash" every time i open a new terminal
source activate desktop_clone_env

#echo "After activation: $(which python)"

size=$((SLURM_ARRAY_TASK_ID*75))

python LebwohlLasher_Numba.py 50 $size 0.5 0
