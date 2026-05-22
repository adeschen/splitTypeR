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

#' @title List the available signature names
#' 
#' @description The function lists all the available signatures.
#' 
#' @return a \code{vector} of available signature names
#' 
#' @examples
#' ## TODO
#' 
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @export
geneListNames <- function() {
    data("signatures")
    return(names(signatures))
}
    
    