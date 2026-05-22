#' @title Parameters validation for the runSubtyping function
#' 
#' @description This function is validation the parameters for the 
#' runSubtyping function. When a parameter is incorrect, a message is sent to 
#' the user before quitting the program.
#' 
#' @param geneLists a \code{list} containing signature gene lists. At least 
#' two signatures gene lists must be present.
#' 
#' @param collection a \code{character} string representing the collection 
#' name assigned to the network. Default: "enrichment results".
#' 
#' @param expectedCountsMatrix a \code{matrix}
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
#'      expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2))
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @keywords internal
validateRunSubtyping <- function(geneLists, expectedCountsMatrix) {
    
    if (!(inherits(geneLists, "list") && length(geneLists) > 1)) {
        stop("The \'geneLists\' object must be a list with a least 2 entries.")
    }
    
    return(TRUE)
}