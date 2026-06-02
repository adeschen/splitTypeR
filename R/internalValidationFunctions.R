#' @title Parameters validation for the runSubtyping function
#' 
#' @description This function is validation the parameters for the 
#' runSubtyping function. When a parameter is incorrect, a message is sent to 
#' the user before quitting the program.
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
#'
#' @param permNbr a \code{integer} bigger than or equal to 5 representing the
#' number of permutation samplings done. 
#' 
#' @return \code{TRUE} when all parameters are valid
#' 
#' @examples
#'
#' ## Create a list with 2 signatures
#' gList <- list()
#' gList[["signature1"]] <- c("ABC1", "ABC2", "SMAD3", "MUC12")
#' gList[["signature2"]] <- c("FYN", "RAS", "SMAD4")
#' 
#' ## Create a small gene matrix
#' expCounts <- matrix(data=rep(22:25, 15), nrow=4)
#' rownames(expCounts) <- c("ABC1", "RAS", "FYN", "SMAD3")
#' colnames(expCounts) <- c(paste0("Sample_", 1:15))
#' 
#' ## The function returns TRUE when all parameters are valid
#' splitTypeR:::validateRunSubtyping(geneLists=gList, 
#'      expectedCountsMatrix=expCounts, permRatio=0.8, permNbr=10)
#' 
#' @author Astrid Deschênes
#' @importFrom S4Vectors isSingleInteger 
#' @importFrom S4Vectors isSingleNumber
#' @encoding UTF-8
#' @keywords internal
validateRunSubtyping <- function(geneLists, expectedCountsMatrix, 
        permRatio, permNbr) {
    
    if (!(inherits(geneLists, "list") && length(geneLists) > 1)) {
        stop("The \'geneLists\' object must be a list with ",
            "at least 2 entries.")
    }

    if (!(inherits(expectedCountsMatrix, "matrix"))) {
        stop("The \'expectedCountsMatrix\' object must be a matrix.")
    }

    genes <- unique(unlist(geneLists, use.names=FALSE))

    if (sum(genes %in% rownames(expectedCountsMatrix)) < 1) {
        stop("None of the genes in the signatures are present in the row ", 
            "names of the \'expectedCountsMatrix\' matrix.")
    }
    
    test01 <- lapply(geneLists, FUN=function(x) 
                    {sum(x %in% rownames(expectedCountsMatrix)) > 0})

    if (!all(unlist(test01))){
        stop("For at least one gene signature, none of the genes are present ", 
            "in the row names of the \'expectedCountsMatrix\' matrix.")
    }

    test02 <- lapply(geneLists, FUN=function(x) 
                    {sum(x %in% rownames(expectedCountsMatrix)) > 1})

    if (!all(unlist(test02))){
        stop("For at least one gene signature, only one gene is present ", 
            "in the row names of the \'expectedCountsMatrix\' matrix.")
    }

    if (!(isSingleNumber(permRatio) && permRatio > 0 && 
            permRatio < 1)) {
        stop("The \'permRatio\' must be a numeric between 0 and 1.")
    }

    if (!(isSingleInteger(permNbr) || isSingleNumber(permNbr) && 
            permNbr > 4)) {
        stop("The \'permNbr\' must be an integer higher than or ", 
            "equal to 5.")
    }

    nbAll <- ncol(expectedCountsMatrix)
    nb <- round(nbAll * permRatio)

    if (nb == nbAll) {
        stop("The \'permRatio\' is too close to one. All samples are ", 
            "selected for the permutation step rather than a subset.")
    }

    if (permNbr > choose(ncol(expectedCountsMatrix), nb)) {
        stop("The \'permNbr\' is too high for the number of samples. ",
            " The number of unique combinations for selecting ", nb, 
            " out of ", nbAll, " samples is ", 
            choose(ncol(expectedCountsMatrix), nb), ".")
    }

    return(TRUE)
}