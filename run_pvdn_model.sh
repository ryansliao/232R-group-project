#!/bin/bash
#SBATCH --job-name=pvdn_model
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

# Unset local JAVA_HOME so the container uses its own Java installation
unset JAVA_HOME

singularity exec \
    --bind /expanse/lustre/projects/uci157 \
    ~/esolares/singularity_images/spark_py_latest_jupyter_dsc232r.sif \
    jupyter nbconvert \
        --to notebook \
        --execute milestone_3.ipynb \
        --output milestone_3_executed.ipynb \
        --ExecutePreprocessor.timeout=7200
