# T2D Microbial Metabolic Signatures: Integrative Metagenomic Pathway Analysis

## Overview

This repository contains a complete bioinformatics workflow for identifying gut microbial metabolic signatures associated with Type 2 Diabetes (T2D).

The project integrates metagenomic functional profiling, differential pathway analysis, microbial species contribution analysis, correlation-based network analysis, and hub identification to understand disease-associated microbial metabolic alterations.

The main objective is to identify:

- T2D-associated metabolic pathways
- Microbial species contributing to altered metabolism
- Species–pathway interaction networks
- Key metabolic hubs associated with disease status


## Study Workflow

Metagenomic Dataset

↓

Metadata Processing

↓

T2D vs Control Cohort Extraction

↓

Functional Pathway Profiling

↓

Differential Metabolic Pathway Analysis

↓

Metabolic Signature Ranking

↓

Microbial Species Contribution Analysis

↓

Species–Pathway Correlation Network

↓

Network Hub Identification

↓

Integrated Microbial Metabolic Model


# Repository Structure

T2D_Microbial_Metabolic_Signatures/

├── data/
│   ├── raw/
│   ├── processed/
│   └── metadata/

├── envs/
│   └── Environment specifications

├── figures/
│   └── Publication-ready figures

├── manuscript/
│   └── Manuscript preparation files

├── metadata/
│   └── Dataset metadata information

├── references/
│   └── Literature references

├── results/
│   └── Final analysis outputs

└── scripts/
    └── Complete R analysis pipeline


# Dataset

The analysis uses publicly available gut metagenomic data from the MetaCardis cohort.

The dataset includes:

- Microbial metabolic pathway abundance profiles
- Sample metadata
- Disease phenotype information
- Clinical variables


# Analysis Pipeline


## 1. Dataset Preparation

Scripts:

01_download_data.R

02_load_metacardis.R

03_check_metacardis_metadata.R

04_extract_t2d_control.R


Functions:

- Dataset acquisition
- Metadata validation
- Sample filtering
- T2D and control cohort preparation


## 2. Functional Pathway Analysis

Scripts:

05_prepare_pathways.R

06_differential_pathways.R

07_annotate_metabolic_pathways.R


Performed analyses:

- Pathway abundance preprocessing
- Differential metabolic pathway testing
- Functional pathway annotation
- Disease-associated pathway identification


Important outputs:

results/

- metacardis_differential_pathways.csv
- metabolic_pathway_annotation.csv
- pathway_associations.csv


## 3. Metabolic Signature Identification

Scripts:

08_rank_metabolic_signatures.R

09_extract_key_signatures.R


Analysis performed:

- Ranking of metabolic pathways
- Identification of important T2D metabolic signatures
- Selection of key altered pathways


Outputs:

- ranked_metabolic_signatures.csv
- key_T2D_metabolic_signatures.csv


## 4. Microbial Species Contribution Analysis

Script:

10_extract_species_contributors.R


Identifies microbial taxa associated with altered metabolic pathways.


Outputs:

- microbial_species_contributors.csv
- species_associations.csv
- top_species.csv


## 5. Statistical Association Analysis

The workflow uses multivariable microbial association analysis.

Methods include:

- Differential abundance testing
- Correlation analysis
- Network association analysis
- Centrality-based ranking


MAASLIN2 intermediate files are excluded from version control because they contain large temporary model outputs.


## 6. Species–Pathway Network Analysis

Scripts:

species_pathway_correlation.R

species_pathway_network.R

species_pathway_heatmap.R


Analysis:

- Species–pathway correlation calculation
- Significant interaction filtering
- Bipartite network generation


Outputs:

- species_pathway_correlations.csv
- species_pathway_correlations_significant.csv
- network_edges.csv
- final_network_edges.csv


## 7. Hub Identification

Scripts:

network_hubs.R

hub_summary.R

hub_network_plot.R

top_hub_network.R


Identification of:

- Microbial hub species
- Metabolic pathway hubs
- Network driver candidates


Outputs:

- species_hubs.csv
- pathway_hubs.csv
- species_hub_summary.csv
- pathway_hub_summary.csv


# Visualization

Generated publication figures include:


Figure 1:
Cohort characteristics


Figure 2:
Principal Component Analysis (PCA)


Figure 3:
Differential pathway analysis


Figure 4:
Metabolic pathway heatmap


Figure 5:
Species contribution and metabolic network analysis


Figure 6:
Clinical association and network analysis


Figure 7:
Integrated microbial metabolic disease model


# Software Requirements


## Programming Language

R >= 4.2


## Major R Packages

- tidyverse
- dplyr
- ggplot2
- MaAsLin2
- igraph
- ggraph
- pheatmap
- ComplexHeatmap


# Reproducibility


Clone repository:

git clone https://github.com/saipranav-bot/T2D_Microbial_Metabolic_Signatures.git


Move into repository:

cd T2D_Microbial_Metabolic_Signatures


Install required packages:

Rscript scripts/11_install_visual_packages.R


Run analysis workflow:

Rscript scripts/02_load_metacardis.R

Rscript scripts/04_extract_t2d_control.R

Rscript scripts/06_differential_pathways.R

Rscript scripts/16_species_pathway_network.R

Rscript scripts/18_fig7_integrated_model.R


# Key Findings


The analysis identified multiple microbial and metabolic signatures associated with T2D.


Major metabolic categories:

- Nucleotide metabolism
- Amino acid metabolism
- Energy metabolism
- Lipid and cofactor metabolism


Important microbial contributors included:

- Eubacterium eligens
- Bacteroides fragilis
- Dialister invisus
- Lachnospira pectinoschiza
- Faecalibacterium prausnitzii


Major pathway hubs included:

- 5-aminoimidazole ribonucleotide biosynthesis
- Guanosine ribonucleotide biosynthesis
- Valine biosynthesis
- Coenzyme A biosynthesis


# Research Significance

This project provides a systems-level framework connecting:

Gut microbiome

→

Metabolic pathway alterations

→

Microbial interaction networks

→

Type 2 Diabetes-associated metabolic dysfunction


The identified microbial metabolic hubs may serve as potential biomarkers and candidates for future experimental validation.


# Citation

Sai Pranav

T2D Microbial Metabolic Signatures:
Integrative Metagenomic Pathway Analysis.


# Author

V Sai Pranav

Research Interests:

- Microbiome Informatics
- Type 2 Diabetes
- Multi-omics Analysis
- Systems Biology
- Computational Disease Biology


GitHub:

https://github.com/saipranav-bot
