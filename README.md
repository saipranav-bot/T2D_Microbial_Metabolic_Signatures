# T2D Microbial Metabolic Signatures

## Overview

This repository contains a reproducible computational framework for identifying gut microbial signatures associated with Type 2 Diabetes (T2D)-related metabolic dysfunction.

The project consists of a **primary discovery analysis** using the MetaCardis cohort and an **independent validation analysis** using the Human Microbiome Project 2 (HMP2). Together, these analyses identify microbial species associated with clinical metabolic traits, prioritize hub species, and provide biological interpretation through network and functional analyses.

---

# Objectives

- Identify microbial signatures associated with Type 2 Diabetes.
- Discover microbial metabolic pathways altered in T2D.
- Validate microbial associations in an independent cohort.
- Prioritize hub microbial species.
- Generate publication-ready figures and tables.

---

# Study Design

## Phase I – Primary Discovery Analysis

**Dataset**

- MetaCardis gut microbiome cohort

**Objectives**

- Differential pathway analysis
- Species contribution analysis
- Network construction
- Identification of key microbial metabolic signatures

Location:

```
Primary_Analysis/
```

---

## Phase II – Independent Validation Analysis

**Dataset**

- Human Microbiome Project 2 (HMP2)

**Clinical Traits**

- HbA1c
- Glucose
- Triglycerides
- HDL
- LDL

**Statistical Method**

- MaAsLin2 multivariable association analysis
- Benjamini–Hochberg FDR correction
- Cross-trait microbial association analysis

Location:

```
Validation_Analysis/
```

---

# Repository Structure

```
T2D_Microbial_Metabolic_Signatures/

├── Primary_Analysis/
│   ├── scripts/
│   ├── figures/
│   ├── tables/
│   ├── metadata/
│   └── results/
│
├── Validation_Analysis/
│   ├── scripts/
│   ├── figures/
│   ├── tables/
│   ├── metadata/
│   └── results/
│
├── Project_Setup/
├── data/
├── envs/
├── manuscript/
├── metadata/
├── references/
├── LICENSE
├── CITATION.cff
└── README.md
```

---

# Primary Analysis Workflow

1. Data preparation
2. Metadata integration
3. Pathway abundance preprocessing
4. Differential pathway analysis
5. Microbial species contribution analysis
6. Network construction
7. Functional annotation
8. Figure generation
9. Publication table generation

---

# Validation Analysis Workflow

1. HMP2 data preprocessing
2. Clinical metadata preparation
3. Species abundance filtering
4. MaAsLin2 association analysis
5. Multiple testing correction
6. Hub species identification
7. Species–trait overlap analysis
8. Functional annotation
9. Network visualization
10. Publication-ready tables and figures

---

# Statistical Analysis

**Primary Analysis**

- Differential abundance analysis
- Network analysis
- Functional enrichment

**Validation Analysis**

- MaAsLin2
- Linear multivariable modelling
- False Discovery Rate (FDR) correction

**Significance Threshold**

- FDR-adjusted q-value ≤ 0.05

---

# Clinical Traits Analysed

- HbA1c
- Glucose
- Triglycerides
- HDL
- LDL

---

# Major Outputs

## Primary Analysis

- Differential metabolic pathways
- Microbial species contributors
- Species–pathway interaction networks
- Publication-quality figures
- Summary tables

## Validation Analysis

- Complete MaAsLin2 association results
- Significant microbial species
- Hub species ranking
- Species–trait overlap
- Functional annotation tables
- Biological interpretation tables
- Cytoscape network files

---

# Software

- R
- MaAsLin2
- dplyr
- tidyr
- ggplot2
- pheatmap
- igraph
- ggraph
- UpSetR

---

# Reproducibility

All scripts are organized according to execution order.

Software versions and computational environment are available in:

```
envs/
metadata/
```

The repository is designed so that both the discovery and validation analyses can be reproduced independently.

---

# Citation

If you use this repository in your research, please cite the accompanying manuscript and the information provided in `CITATION.cff`.

---

# Author

**Pranav**

M.Sc. Bioinformatics  
REVA University, Bengaluru, India
