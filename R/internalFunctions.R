#' Use bootstrapping method to calculate the variance associated to the GSVA 
#' score obtained for each sample
#'
#' @param geneLists a \code{list} containing signature gene lists. 
#'
#' @param countMatrix a normalized gene expression data 
#' \code{matrix} with rows corresponding to genes and columns to samples. The 
#' \code{matrix} has been filtered to contained only the genes present in the 
#' signature gene lists.
#' 
#' @param permRatio a \code{numeric} between 0 and 1 representing the
#' number of samples that are retained for the bootstrap step.
#' 
#' @returns a \code{list} containing the variance calculated from the 
#' bootstrapping method on each sample for each signature gene list. The 
#' \code{list} contains one entry per signature gene list. 
#'
#' @examples
#'
#' ## Load signatures
#' data(signatures)
#' 
#' ## Create a list of two signatures
#' geneLists <- list()
#' geneLists[["classical"]] <- 
#'     signatures$`2018_Tiriac_PDAC_PDO_classical_signature`
#' geneLists[["basal"]] <- 
#'     signatures$`2018_Tiriac_PDAC_PDO_basal-like_signature`
#' 
#' ## Load demo normalized expected counts
#' data(expNormalCountsDemo)
#' 
#' ## Calculate variance for each sample using boostrap method
#' splitTypeR:::bootstrapGSVA(geneLists=geneLists, 
#'     countMatrix=expNormalCountsDemo, permRatio=0.75, 
#'     bootstrapNbr=20)
#' 
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @importFrom stats sd
#' @encoding UTF-8
#' @keywords internal
bootstrapGSVA <- function(geneLists, countMatrix, permRatio, 
    bootstrapNbr) {
    ## Number of samples used for bootstrap
    nb <- round(ncol(countMatrix) * permRatio)

    ## Storage for the results of the bootstrap
    resultBoot <- list()
    for (i in names(geneLists)) {
        tmpM <- matrix(data=NA, nrow=ncol(countMatrix), ncol=bootstrapNbr)
        rownames(tmpM) <- colnames(countMatrix)
        resultBoot[[i]] <- tmpM
    }

    for (i in seq_len(bootstrapNbr)) {
        selected <- sample(x=seq_len(ncol(countMatrix)), size=nb, replace=FALSE)

        gsvaParamTmp <- gsvaParam(
            exprData=as.matrix(countMatrix[, selected]),
            geneSets=geneLists)
      
        resTmp <- gsva(param=gsvaParamTmp, verbose=FALSE)

        for (g in names(geneLists)) { 
            resultBoot[[g]][selected, i] <- resTmp[g, ]
        }
    }

    return(resultBoot)
}
