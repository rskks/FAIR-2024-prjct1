title: "Tools to access publicly available transcriptomic databases-- FAIR2024"
author: "Zhongyou Li  Ph.D." 
"University of Colorado Anschutz Medical campus"
date: '2024-07-15'

### use recount3 package is a interface to the recount3 project. 
### recount3 provides uniformly processed RNA-seq data 
### for hundreds of thousands of samples.

BiocManager::install("recount3")
library("recount3")

## Find all available human projects
human_projects <- available_projects()

## Find the project you are interested in,
## here we use SRP194165 as an example
## You can use online shiny wed tool interface to facilatate your search
## https://jhubiostatistics.shinyapps.io/recount3-study-explorer/
proj_info <- subset(
  human_projects,
  project == "SRP194165" & project_type == "data_sources"
)

## Create a RangedSummarizedExperiment (RSE) object at the gene level for the project of 
## interest.
rse_gene_SRP194165 <- create_rse(proj_info)

## Explore that RSE object
rse_gene_SRP194165

## Transform/scale the count Scale counts 
## by taking into account the total coverage per sample
assay(rse_gene_SRP194165, "counts") <- transform_counts(rse_gene_SRP194165)

## Use DEFormats package to transform a RSE object 
## into a DGE object for edgeR analysis
BiocManager::install("DEFormats")
library(DEFormats)
dge_transform<-DGEList(rse_gene_SRP194165)
## this DGE object (dge_transform) just like the first obeject
## you created in the edgeR module, using code:
## DGE <- DGEList(counts = counts, remove.zeros = TRUE, genes = rownames(counts))

dge_transform$samples$sra.sample_name
dge_transform$samples$sra.sample_name

## match the sample information to the sample ID
## https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE130449
## and create a sample info matrix and a model matrix 
## at the beginning of edgeR analysis.

