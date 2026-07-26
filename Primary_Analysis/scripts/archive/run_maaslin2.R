library(Maaslin2)

cat("Loading pathway abundance table...\n")

# ===========================
# Load pathway abundance table
# ===========================
pathways <- read.csv(
  "results/metacardis_filtered_pathways.csv",
  row.names = 1,
  check.names = FALSE
)

# Remove summary rows
pathways <- pathways[
  !rownames(pathways) %in% c(
    "UNMAPPED",
    "UNINTEGRATED"
  ),
]

cat("Pathways:", nrow(pathways), "\n")
cat("Samples :", ncol(pathways), "\n")

# ======================================
# Convert to MaAsLin2 format
# Rows = samples
# Columns = pathways
# ======================================

input_data <- as.data.frame(t(pathways))

cat("Feature table dimensions:\n")
print(dim(input_data))

# ==================
# Load metadata
# ==================

input_metadata <- read.csv(
  "results/metacardis_analysis_metadata.csv",
  row.names = 1,
  check.names = FALSE
)

# Keep only T2D and controls

input_metadata <- subset(
  input_metadata,
  study_condition %in% c("T2D", "control")
)

# ==========================================
# Remove samples with missing covariates
# ==========================================

input_metadata <- input_metadata[
  complete.cases(
    input_metadata[, c(
      "study_condition",
      "age_category",
      "gender",
      "BMI"
    )]
  ),
]

cat("Metadata after filtering:", nrow(input_metadata), "\n")

# ==========================================
# Keep only shared samples
# ==========================================

common_samples <- intersect(
  rownames(input_data),
  rownames(input_metadata)
)

input_data <- input_data[common_samples, ]
input_metadata <- input_metadata[common_samples, ]

cat("Common samples:", length(common_samples), "\n")

# Safety checks

stopifnot(
  identical(
    rownames(input_data),
    rownames(input_metadata)
  )
)

cat("Data alignment OK\n")

# ==========================================
# Run MaAsLin2
# ==========================================

fit <- Maaslin2(
  input_data = input_data,
  input_metadata = input_metadata,

  output = "results/maaslin2_T2D_control",

  fixed_effects = c(
    "study_condition",
    "age_category",
    "gender",
    "BMI"
  ),

  normalization = "TSS",
  transform = "LOG",
  analysis_method = "LM",

  min_prevalence = 0.10,

  standardize = FALSE,

  plot_heatmap = TRUE,
  plot_scatter = TRUE
)

cat("\n==============================\n")
cat("MaAsLin2 analysis completed!\n")
cat("==============================\n")
