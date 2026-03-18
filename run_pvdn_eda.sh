#!/bin/bash
#SBATCH --job-name=pvdn_eda
#SBATCH --account=TG-SEE260003
#SBATCH --partition=debug
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128G
#SBATCH --time=00:30:00
#SBATCH --output=logs/pvdn_%j.out
#SBATCH --error=logs/pvdn_%j.err

mkdir -p logs

module load singularitypro

singularity exec \
    --bind /expanse/lustre/projects/uci157 \
    ~/esolares/spark_py_latest_jupyter_dsc232r.sif \
    jupyter nbconvert \
        --to notebook \
        --execute group_project_p2.ipynb \
        --output group_project_p2_executed.ipynb \
        --ExecutePreprocessor.timeout=7200
