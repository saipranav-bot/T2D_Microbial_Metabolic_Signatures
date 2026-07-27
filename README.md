# Integrated Functional Metagenomic Profiling Reveals Microbial Metabolic Reprogramming and Species-Level Contributors Associated With Type 2 Diabetes

## Overview

This repository contains the complete computational workflow for identifying gut microbial metabolic signatures associated with **Type 2 Diabetes (T2D)** using shotgun metagenomic pathway profiles from the **MetaCardis** cohort.

The project integrates differential pathway analysis, functional annotation, microbial species contribution analysis, pathway prioritization, and publication-quality visualization to characterize microbial metabolic alterations associated with T2D.

The analysis was designed as a fully reproducible R-based workflow and generates publication-ready figures, tables, and summary results.

---

# Study Objective

The primary objective of this study is to identify microbial metabolic pathways that are significantly altered in individuals with Type 2 Diabetes and to determine the microbial species that contribute to these functional changes.

Specifically, the workflow aims to:

* Identify significantly altered microbial metabolic pathways.
* Prioritize biologically relevant metabolic signatures.
* Annotate pathways using KEGG and MetaCyc functional information.
* Identify major microbial contributors for each pathway.
* Construct species–pathway interaction networks.
* Produce publication-ready visualizations.
* Generate reproducible outputs suitable for manuscript preparation.

---

# Dataset

**MetaCardis Human Gut Microbiome Cohort**

This study uses publicly available functional metagenomic pathway abundance profiles from the MetaCardis project.

Samples included:

* Healthy Controls
* Type 2 Diabetes Patients

The dataset provides pathway abundance profiles generated from shotgun metagenomic sequencing of human gut microbiome samples.

---

# Analysis Workflow

## 1. Data Loading

The pathway abundance matrix and accompanying sample metadata are imported into R.

Outputs:

* pathway abundance matrix
* sample metadata

---

## 2. Sample Selection

Only Healthy Control and Type 2 Diabetes samples are retained.

Outputs:

* filtered metadata
* pathway abundance table

---

## 3. Pathway Preprocessing

The workflow

* removes low-abundance pathways
* filters missing values
* prepares the abundance matrix for statistical analysis

---

## 4. Differential Pathway Analysis

Differential pathway abundance between T2D and Healthy samples is calculated.

Outputs include

* log2 Fold Change
* p-value
* adjusted p-value (FDR)

---

## 5. Functional Annotation

Significant pathways are manually annotated into biological categories such as

* Carbohydrate metabolism
* Amino acid metabolism
* Lipid metabolism
* Energy metabolism
* Nucleotide metabolism
* Cofactor and vitamin metabolism
* Xenobiotic metabolism
* Secondary metabolite biosynthesis

---

## 6. Pathway Ranking

Significant pathways are ranked based on

* statistical significance
* fold change
* biological relevance

---

## 7. Species Contribution Analysis

The dominant microbial species contributing to each significant pathway are identified.

Outputs include

* contributing species
* pathway associations
* interaction tables

---

## 8. Network Construction

Species and metabolic pathways are integrated into a bipartite interaction network illustrating microbial functional relationships.

---

## 9. Publication Figure Generation

The workflow automatically generates publication-quality figures.

---

# Repository Structure

```text
Primary_Analysis/

├── scripts/
│
├── results/
│
├── publication_figures/
│
└── t2dmeta_environment.yml
```

---

# Scripts

Scripts are organized in execution order.

| Script                            | Purpose                         |
| --------------------------------- | ------------------------------- |
| 01_download_data.R                | Download dataset                |
| 02_load_metacardis.R              | Load pathway abundance matrix   |
| 03_check_metacardis_metadata.R    | Metadata quality control        |
| 04_extract_t2d_control.R          | Extract Healthy and T2D samples |
| 05_prepare_pathways.R             | Pathway preprocessing           |
| 06_differential_pathways.R        | Differential abundance analysis |
| 07_annotate_metabolic_pathways.R  | Functional annotation           |
| 08_rank_metabolic_signatures.R    | Rank significant pathways       |
| 09_extract_key_signatures.R       | Extract key pathways            |
| 10_extract_species_contributors.R | Identify microbial contributors |
| 10b_species_summary.R             | Species summary table           |
| 12_fig1_cohort.R                  | Generate Figure 1               |
| 13_fig2_PCA.R                     | Generate Figure 2               |
| 14_fig3_volcano.R                 | Generate Figure 3               |
| 15_fig4_dotplot.R                 | Generate Figure 4               |
| 16_fig5_species_pathway_network.R | Generate Figure 5               |
| 17_fig6_clinical_correlation.R    | Generate Figure 6               |
| 18_fig7_integrated_model.R        | Generate Figure 7               |

---

# Results

The workflow generates

* Differential pathway abundance tables
* Functional pathway annotations
* Ranked metabolic signatures
* Species contribution tables
* Publication-quality figures

---

# Publication Figures

The repository contains seven publication-ready figures.

**Figure 1**

Study cohort overview.

**Figure 2**

Principal Component Analysis (PCA) showing separation between Healthy and Type 2 Diabetes samples.

**Figure 3**

Volcano plot highlighting significantly altered microbial metabolic pathways.

**Figure 4**

Dot plot summarizing enriched microbial metabolic functions.

**Figure 5**

Species–Pathway interaction network showing microbial contributors associated with altered metabolic pathways.

**Figure 6**

Integrated pathway signature summary highlighting major functional alterations.

**Figure 7**

Proposed mechanistic model illustrating microbial metabolic dysbiosis in Type 2 Diabetes.

---

# Software

The workflow was implemented entirely in **R**.

Major packages include

* dplyr
* tidyr
* ggplot2
* igraph
* ggraph
* pheatmap
* readr
* stringr

---

# Reproducibility

All analyses can be reproduced by executing the scripts sequentially.

The computational environment is provided in

```
t2dmeta_environment.yml
```

---

# Citation

If you use this workflow in your research, please cite the accompanying manuscript once published.

---

# Author

**Sai Pranav**

M.Sc. Bioinformatics

REVA University

Bengaluru, Karnataka, India

---

# License

This repository is intended for academic and research use.
