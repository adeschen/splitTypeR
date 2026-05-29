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
#' @param bootstrapRatio a \code{numeric} between 0 and 1 representing the
#' number of samples that are retained for the bootstrap step. The 
#' rounded value of the number of patients multiplied by this \code{numeric}  
#' should be inferior to the total number of patients so that the 
#' bootstrap step is not done on the entire cohort.
#'
#' @param bootstrapNbr a \code{integer} bigger than zero representing the
#' number of bootstrap sampling done. 
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
#' expCounts <- matrix(data=rep(22, 12), nrow = 2)
#' rownames(expCounts) <- c("ABC1", "RAS")
#' colnames(expCounts) <- c("Sample1", "Sample2", "Sample3", "Sample4", 
#'                             "Sample5", "Sample6")
#' 
#' ## The function returns TRUE when all parameters are valid
#' splitTypeR:::validateRunSubtyping(geneLists=gList, 
#'      expectedCountsMatrix=expCounts, bootstrapRatio=0.8, bootstrapNbr=10)
#' 
#' @author Astrid Deschênes
#' @importFrom S4Vectors isSingleInteger isSingleNumber
#' @encoding UTF-8
#' @keywords internal
validateRunSubtyping <- function(geneLists, expectedCountsMatrix, 
        bootstrapRatio, bootstrapNbr) {
    
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

    if (!(isSingleNumber(bootstrapRatio) && bootstrapRatio > 0 && 
            bootstrapRatio < 1)) {
        stop("The \'bootstrapRatio\' must be a numeric between 0 and 1.")
    }

    if (!(isSingleInteger(bootstrapNbr) || isSingleNumber(bootstrapNbr) && 
            bootstrapNbr > 0)) {
        stop("The \'bootstrapNbr\' must be an integer higher than 0.")
    }

    nb <- round(ncol(expectedCountsMatrix) * bootstrapRatio)


    return(TRUE)
}