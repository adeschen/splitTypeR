#' @title TODO
#' 
#' @description TODO.
#' 
#' @param geneLists a \code{list} TODO
#' 
#' @param expectedCountsMatrix a TODO
#' 
#' @return \code{TRUE}
#' 
#' @examples
#'
#' ## Loading signatures
#' data(signatures)
#' 
#' ## Some of the enrichment results present in the dataset
#' ## TODO
#' 
#' @author Astrid Deschênes
#' @importFrom gprofiler2 gconvert
#' @encoding UTF-8
#' @export
runSubtyping <- function(geneLists, expectedCountsMatrix) {
    
    
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
#' @export
geneSignaturesListNames <- function() {
    data("signatures")
    return(names(signatures))
}
    
    