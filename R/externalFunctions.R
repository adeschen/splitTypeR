#' @title Classification of heterogeneous biological samples 
#' based on gene signature lists using a mixture of two normal distributions
#'
#' @description This function classifies heterogeneous biological samples 
#' based on gene signature lists, effectively isolating signature-positive 
#' samples through an automated statistical framework. 
#' 
#' The workflow begins by calculating a Gene Set Variation Analysis (GSVA) 
#' score for each sample to quantify the relative pathway activity. A 
#' subsequent permutation step extracts sample-specific standard 
#' deviations to capture the variance. By combining these metrics, a unique 
#' normal distribution is established for each sample. Through an up-scaling 
#' step, values are randomly drawn from these individual distributions 
#' and pooled to construct a comprehensive mixture of normal 
#' distributions that represent the entire sample population. A 
#' hypothesis-testing approach in which the null hypothesis posits that a 
#' sample belongs to this alternative distribution with the lower mean is 
#' applied. Samples that successfully reject the null hypothesis are 
#' assigned to the signature classification. 
#'
#' @param geneLists a \code{list} containing signature gene lists. At least 
#' two signature gene lists must be present.
#'
#' @param expectedCountsMatrix a normalized gene expression data 
#' \code{matrix} with rows corresponding to genes and columns to samples. 
#'
#' @param permRatio a \code{numeric} between 0 and 1 representing the
#' number of samples that are retained for the permutation step. The 
#' rounded value of the number of patients multiplied by this \code{numeric}  
#' should be inferior to the total number of patients so that the 
#' permutation step is not done on the entire cohort.
#' Default: \code{0.75}.
#'
#' @param permNbr a \code{integer}, 5 or higher, representing the
#' number of permutation sampling done. In addition, the number of permutations 
#' must be equal or inferior to the total number of unique permutations 
#' possible with the dataset considering the parameters selected by the user. 
#' Default: \code{20}.
#' 
#' @param upscaleNbr a \code{integer}, 2 or higher, representing the
#' number of values taken for the normal distribution for each sample to run 
#' the up-scaling step. Default: \code{10}.
#'
#' @return a \code{list} of class \code{splitTypeResults} containing the 
#' signature-specific classification for each sample as well as all the 
#' results generated at each step of the statistical workflow.
#'
#' @examples
#'
#' ## Loading signatures
#' data("signaturesDemo")
#'
#' ## Load demo normalized expected counts for 30 patients
#' data("expNormalCountsDemo")
#' 
#' ## Fix seed for reproducibility
#' set.seed(121)
#' 
#' ## Run classification on the 30 patients using 20 permutations on 75% of 
#' ## the dataset, and 10 points per patient for the up-scaling step
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=20, upscaleNbr=10)
#'
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @encoding UTF-8
#' @export
runSubtypingBimodal <- function(geneLists, expectedCountsMatrix, permRatio=0.75, 
    permNbr=20, upscaleNbr=10) {

    ## Validate parameters
    validateRunSubtyping(geneLists=geneLists,
        expectedCountsMatrix=expectedCountsMatrix, permRatio=permRatio, 
        permNbr=permNbr, upscaleNbr=upscaleNbr)

    ## If fewer than 10 samples, a warning
    if (ncol(expectedCountsMatrix) < 10) {
        warning("! A minimum of 10 samples is recommended to run a GSVA ", 
            "analysis.")
    }
    
    ## Retain genes present in the expression matrix
    genes <- unique(unlist(geneLists, use.names=FALSE))
    genes <- genes[genes %in% rownames(expectedCountsMatrix)]

    ## Subset matrix to retained genes
    retained <- expectedCountsMatrix[genes, ]

    ## Object will all results
    finalSaveData <- list()
    
    ## GSVA on the real dataset
    gsvaParameter <- gsvaParam(exprData=as.matrix(retained),
        geneSets=geneLists)
    resGSVA <- gsva(param=gsvaParameter, verbose=FALSE)
    finalSaveData[["GSVA_RESULTS"]] <- resGSVA

    ## Permutation step
    permResult <- permuteGSVA(geneLists=geneLists, countMatrix=retained, 
        permRatio=permRatio, permNbr=permNbr)
    finalSaveData[["PERMUTATIONS"]] <- permResult$PERMUTATIONS
    finalSaveData[["SD"]] <- permResult$SD

    ## Up-scaling step
    normResult <- extractFromNormalDist(geneLists=geneLists, gsvaRes=resGSVA, 
        gsvaSD=permResult$SD, nbValues=upscaleNbr)
    finalSaveData[["UPSCALING"]] <- normResult

    ## Mixture of normal distributions step
    resMix <- normalMix(geneLists=geneLists, resultNorm=normResult)
    finalSaveData[["MODEL"]] <- resMix
    
    ## Classification step
    resClass <- classification(geneLists=geneLists, gsvaRes=resGSVA, 
            modelMix=resMix)
    finalSaveData[["CLASSIFICATION"]] <- resClass
    
    ## The returned list is of class "splitTypeResults"
    class(finalSaveData) <- "splitTypeResults"
    attr(finalSaveData, "mode") <- "bimodal"
    
    return(finalSaveData)
}

#' @title List the names of the available signatures
#'
#' @description The function lists the names of all the available signatures.
#'
#' @return a \code{vector} of available signature names
#'
#' @details
#' 
#' The PDAC PDO classical and basal-like signatures are 
#' associated to this publication:
#' 
#' Tiriac et al. Organoid Profiling Identifies Common Responders to 
#' Chemotherapy in Pancreatic Cancer. Cancer Discov. 2018 Sep;8(9):1112-1129. 
#' doi: 10.1158/2159-8290.CD-18-0349. Epub 2018 May 31. PMID: 29853643; 
#' PMCID: PMC6125219.
#' 
#' @examples
#'
#' ## Print the names of the available signatures
#' getGeneSignaturesNames()
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
getGeneSignaturesNames <- function() {
    return(names(signatures))
}

#' @title Return the selected gene list signatures
#'
#' @description The function returns the selected gene list signatures.
#'
#' @param nameList a \code{list} of signature names. At least one name is 
#' required. The signature names must all be present in the gene list 
#' signatures. When \code{NULL}, all gene signatures are returned. 
#' Default: \code{NULL}. 
#' 
#' @return a \code{list} of selected signatures. Each signature is composed of 
#' a \code{vector} of gene names.
#' 
#' @details
#' 
#' The PDAC PDO classical and basal-like signatures are 
#' associated to this publication:
#' 
#' Tiriac et al. Organoid Profiling Identifies Common Responders to 
#' Chemotherapy in Pancreatic Cancer. Cancer Discov. 2018 Sep;8(9):1112-1129. 
#' doi: 10.1158/2159-8290.CD-18-0349. Epub 2018 May 31. PMID: 29853643; 
#' PMCID: PMC6125219.
#' 
#' @examples
#'
#' ## Extract the basal-like signature from Tiriac et al 2018
#' getGeneSignatures(nameList=c("2018_Tiriac_PDAC_PDO_basal-like_signature"))
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
getGeneSignatures <- function(nameList=NULL) {
    if (!is.null(nameList) &&!(is.character(nameList) && 
                        is.vector(nameList))) {
        stop("The \'nameList\' parameter must be a vector of characters ", 
            "representing the selected signature names or \'NULL\'.")
    }

    if (!is.null(nameList) && !all(nameList %in% names(signatures))) {
        stop("At least one signature is not available.")
    }

    res <- signatures
    if (!is.null(nameList)) {
        res <- signatures[nameList]
    }

    return(res)
}