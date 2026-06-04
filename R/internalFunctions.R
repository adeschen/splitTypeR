#' @title Use the permutation method to calculate the variance associated 
#' with the GSVA score obtained for each sample
#'
#' @description This function calculates GSVA score for multiple permutation 
#' sampling of the dataset to obtain the variance associated with each sample.
#' 
#' @param geneLists a \code{list} containing signature gene lists. 
#'
#' @param countMatrix a normalized gene expression data 
#' \code{matrix} with rows corresponding to genes and columns to samples. The 
#' \code{matrix} has been filtered to contain only the genes present in the 
#' signature gene lists.
#' 
#' @param permRatio a \code{numeric} between 0 and 1 representing the
#' number of samples that are retained for the permutation step.
#' 
#' @param permNbr a \code{integer} bigger than or equal to 5 representing the
#' number of permutation samplings done. 
#' 
#' @returns a \code{list} containing two entries named "PERMUTATIONS" and "SD".
#' \itemize{
#'     \item The "PERMUTATIONS" entry is a \code{list} with one entry per 
#' signature name. The entry contains the \code{matrix} with all the GSVA 
#' scores for the permutations done on this signature. 
#'     \item The "SD" entry is a \code{list} with one entry per signature name. 
#' The entry contains the \code{vector} of \code{numeric} corresponding to the 
#' standard deviation calculated for each sample. The \code{NA} value is 
#' present when the standard deviation could not be calculated.
#' }
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
#' ## Calculate variance for each sample using permutation method
#' result <- splitTypeR:::permuteGSVA(geneLists=geneLists, 
#'     countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)
#' 
#' ## The output contains all the permutations and the calculated standard 
#' ## deviation in two lists called "SD" and "PERMUTATIONS"
#' 
#' ## The standard deviation of the samples for the classical signature
#' head(result[["SD"]][["classical"]])
#' 
#' ## Some of the GSVA results for the permutations related to the basal
#' ## signature
#' result[["PERMUTATIONS"]][["basal"]][5:8, 1:5]
#' 
#' @author Astrid Deschênes
#' @importFrom GSVA gsvaParam gsva
#' @importFrom stats sd
#' @encoding UTF-8
#' @keywords internal
permuteGSVA <- function(geneLists, countMatrix, permRatio, permNbr) {
    ## Number of samples used for permutation
    nb <- round(ncol(countMatrix) * permRatio)

    ## Storage for the results of the permutations
    resultBoot <- list()
    resultSD <- list()
    for (i in names(geneLists)) {
        resultBoot[[i]] <- matrix(data=NA, nrow=ncol(countMatrix), ncol=permNbr)
        rownames(resultBoot[[i]]) <- colnames(countMatrix)
    }

    ## Run GSVA on the permutations
    for (j in seq_len(permNbr)) {
        selected <- sample(x=seq_len(ncol(countMatrix)), size=nb, 
                                replace=FALSE)

        gsvaParamTmp <- gsvaParam(exprData=as.matrix(countMatrix[, selected]),
                geneSets=geneLists)
      
        resTmp <- gsva(param=gsvaParamTmp, verbose=FALSE)
        
        for (i in names(geneLists)) {
            resultBoot[[i]][selected, j] <- resTmp[i, ]
        }
    }

    ## Calculate standard deviation for each sample
    for (i in names(geneLists)) { 
        resultSD[[i]] <- apply(resultBoot[[i]], MARGIN=1, FUN=function(x) {
                                        sd(x, na.rm=TRUE)})
    }

    return(list("PERMUTATIONS"=resultBoot, "SD"= resultSD))
}

#' @title TODO
#' 
#' @description This function calculates TODO
#' 
#' @param geneLists a \code{list} containing signature gene lists. 
#'
#' @param gsvaRes a TODO
#' 
#' @param gsvaVar a TODO
#' 
#' @param nbValues a \code{integer} superior or egal to 2 representing the 
#' number of values extracted for each sample. 
#' 
#' @returns a \code{list} containing an entry for each gene signature present 
#' in the \code{geneLists} object. Each entry contains a \code{matrix} with 
#' all the GSVA results from all the permutation sampling done. Each column 
#' represent one perutation sampling while each row represent a sample 
#' present in the \code{countMatrix}.
#'
#' @examples
#'
#' ## Required library
#' library(GSVA)
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
#' ## Calculate the real GSVA values
#' gsvaParameter <- gsvaParam(exprData=as.matrix(expNormalCountsDemo), 
#'      geneSets=geneLists)
#' resGSVA <- GSVA::gsva(param=gsvaParameter, verbose=FALSE)
#' 
#' ## Calculate variance for each sample using permutation method
#' permResult <- splitTypeR:::permuteGSVA(geneLists=geneLists, 
#'     countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)
#' 
#' ## Extract values from the normal distribution for each sample
#' normResult <- splitTypeR:::extractFromNormalDist(geneLists=geneLists, 
#'     gsvaRes=resGSVA, gsvaVar=permResult$SD, nbValues=10)
#' 
#' @author Astrid Deschênes
#' @importFrom stats sd rnorm
#' @encoding UTF-8
#' @keywords internal
extractFromNormalDist <- function(geneLists, gsvaRes, gsvaVar, nbValues) {
    
    ## Storage for the results of the drawing
    resultNorm <- list()

    ## Select a specific number of values from a normal distribution 
    ## for each sample
    for (i in names(geneLists)) {
        tmpM <- matrix(data=NA, nrow=ncol(gsvaRes), ncol=nbValues)
        rownames(tmpM) <- colnames(gsvaRes)
    
        for(name in rownames(tmpM)) {
            mean <- gsvaRes[i, name]
            sd <- unname(gsvaVar[[i]][name])
            if (!is.na(mean) && !is.na(sd)) {
                tmpM[name, ] <- rnorm(n=nbValues, mean=mean, sd=sd)
            }
        }
        resultNorm[[i]] <- tmpM
    }
    return(resultNorm)
}

#' @title TODO
#'
#' @description This function calculates TODO
#' 
#' @param geneLists a \code{list} containing signature gene lists. 
#'
#' @param resultNorm a TODO
#' 
#' 
#' @returns a \code{list} TODO
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
#' ## Calculate variance for each sample using permutation method
#' permResult <- splitTypeR:::permuteGSVA(geneLists=geneLists, 
#'     countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)
#' 
#' @author Astrid Deschênes
#' @importFrom mixtools normalmixEM
#' @encoding UTF-8
#' @keywords internal
mixModel <- function(geneLists, resultNorm) {

    ## Storage for the results of the mixed model
    resModel <- list()
    for (i in names(geneLists)) {
        allRes <- sapply(resultNorm[[i]], FUN=unlist)

        resModel[[i]] <- normalmixEM(allRes, k=2, verb=FALSE)
    }
    
    return(resModel)
}