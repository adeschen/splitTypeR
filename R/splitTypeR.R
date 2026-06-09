#' Transcriptomic subtyping using multimodal distributions
#'
#' The \code{splitTypeR} package enables the typing of transcriptomic samples 
#' using multimodal distributions. 
#' 
#' Using gene signature list, this package first assigns a Gene Set 
#' Variation Analysis (GSVA) score to 
#' each sample. Through a permutation step, it then extract the standard 
#' deviation for each sample. By combining both the GSVA score and the 
#' standard deviation, the package can establish a normal distribution for 
#' each sample. Through an upscaling step, TODO
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
#'     \item{\code{\link{runSubtyping}} for TODO}
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
#'     \item{\link{runSubtyping} for TODO}
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
#'     \item{\link{runSubtyping} for TODO}
#' }
#'
#' @usage data(expNormalCountsDemo)
#'
#' @keywords datasets
#'
#' @details
#' 
#' The TODO
#' 
#' @examples
#' 
#' ## Load the demo normalized expected count matrix
#' data(expNormalCountsDemo)
#' 
#'
"expNormalCountsDemo"

#' TODO
#' 
#' Long description TODO
#' 
#' @format A \code{list} of signatures. Each entry contains a \code{vector} 
#' of gene names:
#' \itemize{
#' \item{\code{"2018_Tiriac_PDAC_PDO_classical_signature"}: a \code{vector} of 
#' gene names associated with the PDAC patient-derived organoid (PDO) Classical 
#' signature as published in Tiriac et al 2018}
#' \item{\code{"2018_Tiriac_PDAC_PDO_basal-like_signature"}: a \code{vector} of 
#' gene names associated with the PDAC patient-derived organoid (PDO) 
#' Basal-like signature as published in Tiriac et al 2018}
#' }
#' 
#' @source TODO
#' 
"signatures"