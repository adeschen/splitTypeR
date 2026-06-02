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
#' ## Some of the enrichment results present in the dataset
#' ## TODO
#' runSubtyping(geneLists=signatures, expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=20)
#'
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @encoding UTF-8
#' @export
runSubtyping <- function(geneLists, expectedCountsMatrix, permRatio=0.75, 
    permNbr=20) {
  
    ## Validate parameters
    validateRunSubtyping(geneLists=geneLists,
        expectedCountsMatrix=expectedCountsMatrix, permRatio=permRatio, 
        permNbr=permNbr)

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

    resClass <- gsva(param=gsvaParameter, verbose=FALSE)

    finalSaveData <- list()
    finalSaveData[["GSVA_RESULTS"]] <- resClass

    resultBoot <- bootstrapGSVA(geneLists=geneLists, countMatrix=retained, 
        permRatio=permRatio, permNbr=permNbr)

    
    varLists <- list()
    for (g in names(geneLists)) { 
      varLists[[g]] <- apply(resultBoot[[g]], MARGIN=1, FUN=function(x) {
                                                        sd(x, na.rm=TRUE)})
    }
    finalSaveData[["BOOTSTRAP"]] <- resultBoot
    finalSaveData[["BOOTSTRAP_VAR"]] <- varLists
  
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
