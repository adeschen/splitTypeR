#' Transcriptomic classification using multimodal distributions
#'
#' The \code{splitTypeR} package provides an automated statistical 
#' framework for classifying heterogeneous biological samples based on 
#' gene signature lists, effectively isolating signature-positive 
#' samples. This classification method is designed for bulk 
#' transcriptomic datasets. 
#' 
#' The workflow begins by calculating a Gene Set Variation Analysis (GSVA) 
#' score for each sample to quantify the relative pathway activity. A 
#' subsequent permutation step extracts sample-specific standard deviations to
#' capture the variance. By combining these metrics, the package establishes a 
#' unique normal distribution for each sample. Through an up-scaling step, 
#' values are randomly drawn from these individual distributions and pooled 
#' to construct a comprehensive mixture of normal distributions that represent  
#' the entire sample population. 
#' 
#' Within this mixture model, the sub-distribution with 
#' the lower mean value is designated as the alternative distribution. The 
#' framework applies a hypothesis-testing approach in which the null hypothesis 
#' posits that a sample belongs to this alternative distribution. Samples 
#' that successfully reject the null hypothesis are assigned to the signature 
#' classification. Conversely, samples that fail to reject the null hypothesis 
#' remain unclassified. 
#' 
#' By automating the classification workflow, the \code{splitTypeR} package 
#' provides an objective method to identify patient or sample subgroups in 
#' heterogeneous transcriptomic datasets.
#' 
#' @name splitTypeR-package
#'
#' @aliases splitTypeR-package splitTypeR
#'
#' @author Astrid Deschênes, Pascal Belleau
#'
#' Maintainer:
#' Astrid Deschênes <adeschen@hotmail.com>
#'
#' @seealso
#' \itemize{
#'     \item{\link{runSubtypingBimodal} for the classification of heterogeneous 
#'     biological samples based on gene signature lists using a mixture of 
#'     two normal distributions}
#'     \item{\link{getGeneSignaturesNames} for the names of the available and 
#'     ready-to-use gene signature lists}
#'     \item{\link{getGeneSignatures} for the available and 
#'     ready-to-use gene signature lists}
#' }
#' 
#' @encoding UTF-8
#' @keywords package
"_PACKAGE"

#' A short collection of published gene signatures primarily focuses on PDAC 
#' classification for patient-derived organoids (PDO). While the 
#' signatures are accurate, this list is mainly 
#' compiled for demonstration purposes.
#' 
#' @name signaturesDemo
#'
#' @docType data
#'
#' @aliases signaturesDemo
#'
#' @format a \code{list} containing one entry per signature:
#' \itemize{
#'     \item{\code{"2018_Tiriac_PDAC_PDO_classical_signature"}: a 
#'     \code{vector} of gene names associated to the PDAC Patient-derived 
#'     Organoid (PDO) Classical signature as published in Tiriac et al 2018 }
#'     \item{\code{"2018_Tiriac_PDAC_PDO_basal-like_signature"}: a 
#'     \code{vector} of gene names associated to the PDAC Patient-derived 
#'     Organoid (PDO) Basal-like signature as published in Tiriac et al 2018 }
#' }
#'
#' @return a \code{list} containing one entry per signature:
#' \itemize{
#'     \item{\code{"2018_Tiriac_PDAC_PDO_classical_signature"}: a 
#'     \code{vector} of gene names associated to the PDAC Patient-derived 
#'     Organoid (PDO) Classical signature as published in Tiriac et al 2018 }
#'     \item{\code{"2018_Tiriac_PDAC_PDO_basal-like_signature"}: a 
#'     \code{vector} of gene names associated to the PDAC Patient-derived 
#'     Organoid (PDO) Basal-like signature as published in Tiriac et al 2018 }
#' }
#'
#' @seealso
#' \itemize{
#'     \item{\link{runSubtypingBimodal} for the classification of heterogeneous 
#'     biological samples based on gene signature lists using a mixture of 
#'     two normal distributions}
#'     \item{\link{getGeneSignaturesNames} for the names of the available and 
#'     ready-to-use gene signature lists}
#'     \item{\link{getGeneSignatures} for the available and 
#'     ready-to-use gene signature lists}
#' }
#'
#' @usage data(signaturesDemo)
#'
#' @keywords datasets
#'
#' @details
#' 
#' The PDAC patient-derived organoids (PDO) classical and basal-like 
#' signatures are associated to this publication:
#' 
#' Tiriac et al. Organoid Profiling Identifies Common Responders to 
#' Chemotherapy in Pancreatic Cancer. Cancer Discov. 2018 Sep;8(9):1112-1129. 
#' doi: 10.1158/2159-8290.CD-18-0349. Epub 2018 May 31. PMID: 29853643; 
#' PMCID: PMC6125219.
#' 
#' @examples
#' 
#' ## Load the published signature gene list
#' data(signaturesDemo)
#' 
#'
"signaturesDemo"


#' A small normalized expected gene counts matrix for 30 patients generated to 
#' be used as a demonstration set in this package.
#' 
#' @name expNormalCountsDemo
#'
#' @docType data
#'
#' @aliases expNormalCountsDemo
#'
#' @format a \code{matrix} containing normalized gene counts for 30 patients 
#' (columns). Only genes related to 2018 Tiriac PDAC PDO classical and 
#' basal-like signatures are present (row). 
#'
#' @return a \code{matrix} containing normalized gene counts for 30 patients 
#' (columns). Only genes related to 2018 Tiriac PDAC PDO classical and 
#' basal-like signatures are present (row). 
#'
#' @seealso
#' \itemize{
#'     \item{\link{runSubtypingBimodal} for the classification of heterogeneous 
#'     biological samples based on gene signature lists using a mixture of 
#'     two normal distributions }
#'     \item{\link{getGeneSignaturesNames} for the names of the available and 
#'     ready-to-use gene signature lists}
#'     \item{\link{getGeneSignatures} for the available and 
#'     ready-to-use gene signature lists}
#' }
#'
#' @usage data(expNormalCountsDemo)
#'
#' @keywords datasets
#' @examples
#' 
#' ## Load the demo normalized expected count matrix
#' data("expNormalCountsDemo")
#' 
#' ## Load the demo signatures
#' data("signaturesDemo")
#' 
#' ## Fix seed for reproducibility
#' set.seed(221)
#' 
#' ## Run classification on the 30 patients using 25 permutations on 70% of 
#' ## the cohort, and 10 points per patient for the up-scaling step
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.70, permNbr=25, upscaleNbr=10)
#' 
"expNormalCountsDemo"
