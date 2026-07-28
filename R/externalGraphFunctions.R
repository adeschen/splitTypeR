#' @title  Graph both the alternative and the signature distributions 
#' obtained for a specific signature
#'
#' @description The function generates a graph showing the signature and 
#' alternative distributions obtained from the upscaling step followed by the 
#' extraction of the mixture of two normal distributions for each 
#' selected signature. The graph also contains the histogram of the 
#' enriched scores for the upscaled dataset (not the original dataset).
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
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=20, upscaleNbr=5)
#'     
#' ## Graph result
#' plotDensityWithUpscalingSamplesBimodal(x=results, 
#'     signature="2018_Tiriac_PDAC_PDO_classical_signature")
#'
#' @author Astrid Deschênes
#' @importFrom graphics hist legend par
#' @importFrom stats rnorm density
#' @encoding UTF-8
#' @export
plotDensityWithUpscalingSamplesBimodal <- function(x, signature, 
    colorSignature="black", colorAlternative="#A9A9AD", 
    colorBorderSamples="azure4", colorFillingSamples="azure3") {
    
    if (!inherits(x, "splitTypeResults")) {
        stop("The x object must be of class \'splitTypeResults\'.")
    }

    if (!"mode" %in% names(attributes(x)) || attr(x, "mode") != "bimodal") {
        stop("The x object must be for a bimodal distribution.")
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

#' @title Graph showing both the alternative and the signature distributions 
#' obtained for a specific signature
#'
#' @description The function generates a graph of all the enrichment results 
#' obtained during the permutation step for the selected signature and the 
#' specified samples. The graph also includes a compact display of the 
#' continuous distribution of the values for each sample. 
#'
#' @param x a \code{list} of class "splitTypeResults", the output object 
#' from \code{runSubtyping}function, to be graphed.
#'
#' @param signature a \code{character} string representing the signature 
#' that will be used to create the graph. The signature must 
#' be present in the object.
#' 
#' @param samples a \code{list} of \code{character} string representing 
#' the names of the samples that will be used to create the graph. The samples 
#' must be present in the object.
#'
#' @param violinColor a \code{character} string representing the color of the 
#' line for the kernel density distributions in the graph. 
#' Default: \code{"black"}.
#' 
#' @param pointColor a \code{character} string representing the color of the 
#' dots representing the enrichment scores for the selected samples in 
#' the graph. Default: \code{"black"}.
#' 
#' @param positionJitter a \code{numeric} representing the amount of 
#' vertical and horizontal jitter added to the position of the points on the 
#' graph. Default: \code{0.20}.
#' 
#' @param alpha a \code{numeric} representing the amount of the opacity of 
#' the points on the graph. If \code{NA}, the color is completely transparent. 
#' Default: \code{0.25}.
#' 
#' @param size a \code{numeric} that represents the size of the points 
#' on the graph. Default: \code{0.95}.
#' 
#' @param seed a \code{integer} that will be used as seed to make the jitter 
#' reproducible. If \code{NA}, the seed is initialized with a random value. 
#' Default: \code{NA}.
#' 
#' @return a \code{ggplot} object that contains all the enrichment scores 
#' obtained through the permutation step with the kernel desntiy distributions 
#' for the selected samples and the selected signature.
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
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=30, upscaleNbr=5)
#'     
#' ## Graph the enrichment results from the permutation for 3 samples
#' plotPermutationSamplesDistribution(x=results, 
#'     signature="2018_Tiriac_PDAC_PDO_basal-like_signature",
#'     samples=c("Patient_9", "Patient_25", "Patient_29"), 
#'     violinColor="darkred", pointColor="darkviolet", positionJitter=0.20, 
#'     size=1.2, seed=121)
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom stringr str_replace_all
#' @importFrom rlang .data
#' @importFrom ggplot2 ggplot aes ggtitle geom_violin element_text xlab theme_minimal position_jitter geom_jitter ylab ylim theme
#' @export
plotPermutationSamplesDistribution <- function(x, signature, samples, 
    violinColor="black", pointColor="black", positionJitter=0.20, alpha=0.25, 
    size=0.95, seed=NA) {

    if (!inherits(x, "splitTypeResults")) {
        stop("The x object must be of class \'splitTypeResults\'.")
    }

    if (!signature %in% names(x$PERMUTATIONS)) {
        stop("The signature \'", signature, "\' must be present in the ", 
                "\'splitTypeResults\' object.")
    }
    
    if (!is.vector(samples) || !is.character(samples) || length(samples) == 0 || 
            !all(samples %in% rownames(x$PERMUTATIONS[[signature]]))) {
        stop("All the samples must all be present in the ", 
                "\'splitTypeResults\' object.")
    }

    permutRes <- x$PERMUTATIONS[[signature]]
    nPerm <- ncol(permutRes)

    allRes <- list()
    for (i in unique(samples)) {
        tmp <- data.frame(sample=rep(i, nPerm), score=permutRes[i, ])
        allRes[[length(allRes) + 1]] <- tmp
    }
    allRes <- do.call(rbind, allRes)
    allRes <- allRes[which(!is.na(allRes$score)),]

    g1 <- ggplot(allRes, aes(x=.data$sample, y=.data$score)) + 
            geom_violin(color=violinColor, trim=FALSE) + 
            ggtitle(str_replace_all(signature, "_", " ")) +
            geom_jitter(shape=16, color=pointColor, alpha=alpha, size=size, 
                            position=position_jitter(positionJitter, 
                                                        seed=seed)) +
            ylab("Enrichment score") + theme_minimal() + 
            ylim(-1, 1) + xlab("") +
            theme(axis.text = element_text(size=10),
                axis.title = element_text(face="bold", size=11),
                plot.title = element_text(size=12, hjust = 0.5))

    return(g1)
}

#' @title Graph TODO
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
#' @param samples a \code{list} of \code{character} string representing 
#' the names of the samples that will be used to create the graph. The samples 
#' must be present in the object.
#' 
#' @param pointColor a \code{character} string representing the color of the 
#' dots representing the enrichment scores for the sampled values, obtained 
#' during the upscaling step, in the graph. Default: \code{"darkred"}.
#' 
#' @return a \code{ggplot} object that contains the density distribution of the
#' enrichment score (shown as dashed lines) from the normal distribution 
#' calculated for each selected sample. The mean of the distribution is 
#' the enrichment score for the selected sample (shown as a vertical dotted 
#' line in the graph) while the standard deviation is obtained from the 
#' permutation step. The enrichment scores values sampled at the upscaling 
#' step are shown as dots in the graph. 
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
#' results <- runSubtypingBimodal(geneLists=signaturesDemo, 
#'     expectedCountsMatrix=expNormalCountsDemo, 
#'     permRatio=0.75, permNbr=30, upscaleNbr=5)
#'     
#' ## Graph the enrichment results from the permutation for 3 samples
#' plotPermutationSamplesNormal(x=results, 
#'     signature="2018_Tiriac_PDAC_PDO_basal-like_signature",
#'     samples=c("Patient_9", "Patient_25", "Patient_29"))
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @importFrom stringr str_replace_all
#' @importFrom rlang .data
#' @importFrom stats dnorm
#' @importFrom ggplot2 ggplot aes geom_line geom_vline ylab xlim geom_point facet_grid theme_bw xlab theme
#' @export
plotPermutationSamplesNormal <- function(x, signature, samples, 
    pointColor="darkred") {

    if (!inherits(x, "splitTypeResults")) {
        stop("The x object must be of class \'splitTypeResults\'.")
    }

    if (!signature %in% names(x$UPSCALING)) {
        stop("The signature \'", signature, "\' must be present in the ", 
                "\'splitTypeResults\' object.")
    }
    
    if (!is.vector(samples) || !is.character(samples) || 
            length(samples) == 0 || 
            !all(samples %in% rownames(x$UPSCALING[[signature]]))) { ## || 
         ##   !all(samples %in% colnames(x$GSVA_RESULTS))) {                                                        ) {
        stop("All the samples must all be present in the ", 
                "\'splitTypeResults\' object.")
    }

    samples <- unique(samples) 
    upscaleRes <- x$UPSCALING[[signature]]
    nPerm <- ncol(upscaleRes)
    nSample <- length(samples)

    allPoints <- list()
    for (i in samples) {
        tmp <- data.frame(sample=rep(i, nPerm), score=upscaleRes[i, ])
        allPoints[[length(allPoints) + 1]] <- tmp
    }
    allPoints <- do.call(rbind, allPoints)

    realGSEA <- data.frame(sample=samples,
                    score=x$GSVA_RESULTS[signature, samples])

    seqPos <- seq(from=-1, to=1, by=0.005)
    nbPositions <- length(seqPos)
    dataTmp <- data.frame(x_value=rep(seqPos, nSample),
                    sample=rep(samples, each=nbPositions))
    
    for (i in samples) {
        dataTmp$density[dataTmp$sample == i] <- 
            dnorm(seqPos, mean=x$GSVA_RESULTS[signature, i],
                    sd=x$SD[[signature]][i]) 
    }
  
    maxValue <- max(dataTmp$density)
    allPoints$y_value <- sample(seq(from=0.03, to=floor(maxValue-0.03), 
                                    by=0.01), size=nrow(allPoints), 
                                    replace=TRUE)
  
    densityPlot <-  ggplot(dataTmp, aes(x=.data$x_value)) +
        geom_line(aes(y=.data$density), size=1, linetype="longdash", 
                    show.legend=TRUE) + 
        xlim(-1, 1) + ylab("Density") +
        geom_vline(data=realGSEA, aes(xintercept=.data$score), 
                    linetype="dotted",  color = "gray15", size=1) +
        geom_point(data=allPoints, aes(x=.data$score, y=.data$y_value), 
                    color=pointColor, show.legend=TRUE) +
        facet_grid(sample ~ .) + theme_bw() + xlab("Enrichment score") +
        theme(axis.title=element_text(size=12, face="bold"), 
            axis.text=element_text(size=9), 
            strip.text=element_text(size=11, face="bold"))

    return(densityPlot)
}
