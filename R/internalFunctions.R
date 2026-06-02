#' @title Use the permutation method to calculate the variance associated 
#' with the GSVA score obtained for each sample
#'
#' 
#' @description Calculate GSVA score for multiple permuatation sampling of the 
#' dataset to obtain the variance associated with each sample.
#' 
#' @param geneLists a \code{list} containing signature gene lists. 
#'
#' @param countMatrix a normalized gene expression data 
#' \code{matrix} with rows corresponding to genes and columns to samples. The 
#' \code{matrix} has been filtered to contained only the genes present in the 
#' signature gene lists.
#' 
#' @param permRatio a \code{numeric} between 0 and 1 representing the
#' number of samples that are retained for the permutation step.
#' 
#' @param permNbr a \code{integer} bigger than or equal to 5 representing the
#' number of permutation samplings done. 
#' 
#' @returns a \code{list} containing an entry for each gene signature present 
#' in the \code{geneLists} object. Each entry contains a \code{matrix} with 
#' all the GSVA results from all the permutation sampling done. Each column 
#' represent one perutation sampling while each row represent a sample 
#' present in the \code{countMatrix}.
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
#'     countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)
#' 
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @importFrom stats sd
#' @encoding UTF-8
#' @keywords internal
bootstrapGSVA <- function(geneLists, countMatrix, permRatio, permNbr) {
    ## Number of samples used for permutation
    nb <- round(ncol(countMatrix) * permRatio)

    ## Storage for the results of the permutation
    resultBoot <- list()
    for (i in names(geneLists)) {
        tmpM <- matrix(data=NA, nrow=ncol(countMatrix), ncol=permNbr)
        rownames(tmpM) <- colnames(countMatrix)
        resultBoot[[i]] <- tmpM
    }

    for (i in seq_len(permNbr)) {
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
