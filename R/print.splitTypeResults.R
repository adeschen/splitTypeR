#' @rdname splitTypeResults
#'
#' @title  Print a \code{splitTypeResults} object
#'
#' @method print splitTypeResults
#'
#' @description Print a \code{splitTypeResults} object
#'
#' @param x the output object from \code{runSubtyping}
#' function to be printed
#'
#' @param \ldots arguments passed to or from other methods
#'
#' @return an object of class
#' \code{splitTypeResults}
#'
#' @examples
#'
#' 
#' ## Loading signatures
#' data("signaturesDemo")
#'
#' ## Load demo normalized expected counts for 30 patients
#' data("expNormalCountsDemo")
#' 
#' ## Fix seed for reproducibility
#' set.seed(1221)
#' 
#' ## Run classification on the 30 patients using 20 permutations on 75% of 
#' ## the dataset, and 10 points per patient for the up-scaling step
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=10, upscaleNbr=10)
#'     
#' ## Print result
#' print(results)
#'
#' @export
print.splitTypeResults <- function(x, ...) {
    
    cat("Classification: \n")
    
    summary <- NULL
    if(!is.null(x$CLASSIFICATION)) {
        for (i in names(x$CLASSIFICATION)) {
            if (!all(is.na(x$CLASSIFICATION[[i]]))) {
                tmp <- x$CLASSIFICATION[[i]][, "classification",  drop=FALSE]
                colnames(tmp) <- c(i)
                if (is.null(summary)) {
                    summary <- tmp
                } else {
                    summary <- cbind(summary, tmp)
                }
            }
        }
    }
    
    print.data.frame(summary)
    
    invisible(x)
}
    