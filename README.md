# 232R Group Project - Provident Vehicle Detection at Night (PVDN)

**Dataset:** [Provident Vehicle Detection at Night (PVDN)](https://www.kaggle.com/datasets/saralajew/provident-vehicle-detection-at-night-pvdn/data)

**Goal:** Preprocessing and modeling on PVDN using Apache Spark on SDSC Expanse: data load, feature engineering, PCA dimensionality reduction, and RandomForest classification (reflection label) with evaluation, explained variance, fitting analysis, and test-set prediction analysis.

**Branch for this work:** `Milestone4`

---

## Notebooks & code

| Artifact | Description |
|----------|-------------|
| [milestone_4.ipynb](milestone_4.ipynb) | Main notebook: data load, preprocessing, PCA (k=10) + RandomForest, train/val/test evaluation, explained variance (scree + cumulative), fitting analysis, conclusion, and test-set predictions (correct / FP / FN). |

All code and notebooks are in the repo; the link above points to the M4 notebook. Commit and push the `Milestone4` branch so the link resolves (e.g. on GitHub).

---

## Running on SDSC Expanse

### 1. First-time setup (run once after login)

```bash
ln -sf /expanse/lustre/projects/uci157/$USER
ln -sf /expanse/lustre/projects/uci157/esolares
```

### 2. Fetch the repo and checkout Milestone 4

```bash
cd 232R-group-project
git fetch origin Milestone4
git checkout Milestone4
```

### 3. Submit a job

The SLURM script `run_pvdn_eda.sh` is pre-configured with the correct account, partition, cores, and memory. Run:

```bash
sbatch run_pvdn_eda.sh
```

| SLURM Setting | Value            |
|---------------|------------------|
| Account       | `TG-SEE260003`   |
| Partition     | `debug`          |
| Cores         | 8                |
| Memory        | 128 GB           |
| Wall Time     | 30 min           |
| Output        | `logs/pvdn_<jobid>.out` |

Then run [milestone_4.ipynb](milestone_4.ipynb) on Expanse (e.g. Jupyter in an interactive job or a job that runs the notebook). The notebook writes outputs under `_m4_outputs`.

---

## SDSC Expanse environment

### Cluster resources

Spark jobs use a single compute node on [SDSC Expanse](https://www.sdsc.edu/services/hpc/expanse/):

| Resource    | Value   |
|-------------|---------|
| Total Cores | 8       |
| Total Memory| 128 GB  |
| Partition   | shared  |

### SparkSession configuration

```python
spark = SparkSession.builder \
    .config("spark.driver.memory", "2g") \
    .config("spark.executor.memory", "18g") \
    .config("spark.executor.instances", 7) \
    .getOrCreate()
```

One core is reserved for the driver; the remaining 7 run executors. Executor memory is (128 GB − 2 GB) / 7 ≈ 18 GB per executor.

### Data location on Expanse

```
DATA_ROOT = /expanse/lustre/projects/uci157/kkravchenko/provident-vehicle-detection-at-night-pvdn
```

PVDN lives on Lustre for high-throughput I/O during Spark reads.
