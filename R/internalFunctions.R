#' Title
#'
#' @param geneLists TODO
#'
#' @param retainedCounts TODO
#'
#' 
#' @returns TODO
#'
#' @examples TODO
#'
#' ## Load signatures
#' data(signatures)
#' 
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
#'     retainedCounts=expNormalCountsDemo, bootstrapRatio=0.75, 
#'     bootstrapNbr=20)
#' 
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @encoding UTF-8
#' @keywords internal
bootstrapGSVA <- function(geneLists, retainedCounts, bootstrapRatio, 
    bootstrapNbr) {
    ## Number of samples used for bootstrap
    nb <- round(ncol(retained) * bootstrapRatio)

    ## Storage for the results of the bootstrap
    resultBoot <- list()
    for (i in names(geneLists)) {
        tmpM <- matrix(data = NA, nrow = ncol(retained), ncol = bootstrapNbr)
        rownames(tmpM) <- colnames(retained)
        resultBoot[[i]] <- tmpM
    }

    for (i in seq_len(bootstrapNbr)) {
        selected <- sample(x=seq_len(ncol(retained)), size=nb, replace=FALSE)

        gsvaParamTmp <- gsvaParam(
            exprData = as.matrix(retainedCounts[, selected]),
            geneSets = geneLists)
      
        resTmp <- gsva(param=gsvaParamTmp, verbose=FALSE)

        for (g in names(geneLists)) { 
            resultBoot[[g]][selected, i] <- resTmp[g, ]
        }
    }

  varLists <- list()
  for (g in names(geneLists)) { 
      varLists[[g]] <- apply(resultBoot[[g]], MARGIN=1, FUN=function(x) {
                                                        sd(x, na.rm=TRUE)})
  }

  return(varLists)
}
