#' @title  Graph both the alternative and the signature distributions 
#' obtained for a specific signature
#'
#' @description TODO
#' 
#' @param x a \code{list} of class "splitTypeResults", the output object 
#' from \code{runSubtyping}function, to be graphed.
#'
#' @param signature a \code{character} string representing the signature 
#' that will be used to create the graph. The signature must 
#' be present in the object.
#' 
#' @param colorSignature a \code{character} string representing the color of 
#' the signature distribution curve. Default: \code{"black"}.
#' 
#' @param colorAlternative a \code{character} string representing the color of 
#' the alternative distribution curve. Default: \code{"#A9A9AD"}.
#' 
#' @param colorBorderSamples a \code{character} string representing the color 
#' of the histogram border for the sample distribution. 
#' Default: \code{"azure4"}.
#' 
#' @param colorFillingSamples a \code{character} string representing the 
#' color of the histogram filling for the sample distribution. 
#' Default: \code{"azure3"}.
#'
#' @return TODO
#' 
#' @examples
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
#' results <- runSubtyping(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=20, upscaleNbr=5)
#'     
#' ## Graph result
#' plotDensityWithUpscalingSamples(x=results, 
#'     signature="2018_Tiriac_PDAC_PDO_classical_signature")
#'
#' @author Astrid Deschênes
#' @importFrom graphics hist legend par
#' @importFrom stats rnorm density
#' @encoding UTF-8
#' @export
plotDensityWithUpscalingSamples <- function(x, signature, 
    colorSignature="black", colorAlternative="#A9A9AD", 
    colorBorderSamples="azure4", colorFillingSamples="azure3") {
    
    if (!inherits(x, "splitTypeResults")) {
        stop("The x object must be of class \'splitTypeResults\'.")
    }

    if (!signature %in% names(x$MODEL) || !signature %in% names(x$UPSCALING)) {
        stop("The signature \'", signature, "\' must be present in the ", 
                "\'splitTypeResults\' object.")
    }

    model <- x$MODEL[[signature]]

    posMin <- which.min(model$mu)
    posMax <- which.max(model$mu)

    upscalingResults <- x$UPSCALING[[signature]]
    
    curveMin <- density(c(rnorm(n=1000000, mean = model$mu[posMin], 
                            sd=model$sigma[posMin])))
    curveMax <- density(c(rnorm(n=1000000, mean = model$mu[posMax], 
                            sd=model$sigma[posMax])))
    
    ## Obtain the counts per bin
    histTmp <- hist(upscalingResults, breaks=22, plot=FALSE) 
    
    yMax <- max(curveMax$y, curveMin$y, max(histTmp$density))
    yMax <- yMax + 0.4

    par(new=FALSE)
    par(lwd=3)
    hist(upscalingResults, freq=FALSE, breaks=22, ylab="", xlab="", 
        col=colorFillingSamples, ylim=c(0, yMax), xlim=c(-1, 1), main="", 
        border=colorBorderSamples) 
    par(new=TRUE)
    plot(curveMin$x[which(curveMin$x>=-1 & curveMin$x<=1)], 
        curveMin$y[which(curveMin$x>=-1 & curveMin$x<=1)], 
        bty="n", xlab="", ylab="", type="l", lty=4, lwd=3, 
        col=colorAlternative, xlim=c(-1, 1), ylim=c(0, yMax))
    par(new=TRUE)
    plot(curveMax$x[which(curveMax$x>=-1 & curveMax$x<=1)], 
        curveMax$y[which(curveMax$x>=-1 & curveMax$x<=1)], 
        type="l", lty=4, lwd=3, col=colorSignature, 
        xlab="GSEA score", ylab="Density", bty="n",
        xlim = c(-1, 1), ylim=c(0, yMax), cex.lab=1.4)
    legend(x=-0.98, y=yMax+0.2, legend=c("Alternative distribution", 
        "Signature distribution", "Sampled values (upscaling step)"), 
        col=c(colorAlternative, colorSignature, colorBorderSamples), 
        box.lty=0, lty=c(4,4,1), cex=0.9)
}