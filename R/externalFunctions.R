#' @title TODO
#'
#' @description TODO.
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
#' with the dataset considering the parameters selected by the user. 
#' Default: \code{20}.
#' 
#' @param upscaleNbr a \code{integer}, 2 or higher, representing the
#' number of values taken for the normal distribution for each sample to run 
#' the upscaling step. Default: \code{10}.
#'
#' @return \code{TRUE}
#'
#' @examples
#'
#' ## Loading signatures
#' data("signatures")
#'
#' ## Load demo normalized expected counts for 30 patients
#' data("expNormalCountsDemo")
#' 
#' ## Run subtyping on the 30 patients
#' runSubtyping(geneLists=signatures, expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=20, upscaleNbr=10)
#'
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @encoding UTF-8
#' @export
runSubtyping <- function(geneLists, expectedCountsMatrix, permRatio=0.75, 
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

    gsvaParameter <- gsvaParam(exprData=as.matrix(retained),
        geneSets=geneLists)

    resGSVA <- gsva(param=gsvaParameter, verbose=FALSE)

    finalSaveData <- list()
    finalSaveData[["GSVA_RESULTS"]] <- resGSVA

    permResult <- permuteGSVA(geneLists=geneLists, countMatrix=retained, 
        permRatio=permRatio, permNbr=permNbr)
    
    finalSaveData[["PERMUTATIONS"]] <- permResult$PERMUTATIONS
    finalSaveData[["SD"]] <- permResult$SD

    normResult <- extractFromNormalDist(geneLists=geneLists, gsvaRes=resGSVA, 
        gsvaSD=permResult$SD, nbValues=upscaleNbr)
  
    resMix <- normalMix(geneLists=geneLists, resultNorm=normResult)
    resClass <- classification(geneLists=geneLists, gsvaRes=resGSVA, 
            modelMix=resMix)
    
    return(finalSaveData)
}

#' @title List the names of the available signature
#'
#' @description The function lists the names of all the available signatures.
#'
#' @return a \code{vector} of available signature names
#'
#' @examples
#'
#' ## Print the names of the available signatures
#' geneSignaturesListNames()
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom utils data
#' @export
geneSignaturesListNames <- function() {
    return(names(splitTypeR::signatures))
}
