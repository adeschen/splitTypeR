### Unit tests for externalGraphFunctions functions

library(splitTypeR)
library(testthat)

data("expNormalCountsDemo")
data("signaturesDemo")


#############################################################################
### Tests plotDensityWithUpscalingSamplesBinomal() 
#############################################################################

test_that("plotDensityWithUpscalingSamplesBimodal() must return an error when x is a list", {
    
    error_message <- "The x object must be of class \'splitTypeResults\'."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(plotDensityWithUpscalingSamplesBimodal(x=gList, 
        signature="test"), error_message)
})

test_that("plotDensityWithUpscalingSamplesBimodal() must return an error when signature is not in object", {

    error_message <- paste0("The signature \'DO_NOT_TEST\' must be present ", 
        "in the 'splitTypeResults\' object.")
    
    set.seed(1221)

    results <- runSubtypingBimodal(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_error(plotDensityWithUpscalingSamplesBimodal(x=results, 
        signature="DO_NOT_TEST"), error_message)
})

test_that("plotDensityWithUpscalingSamplesBimodal() must return an error when x is not bimodal", {
    
    error_message <- "The x object must be for a bimodal distribution."
    
    set.seed(121)

    results <- runSubtypingBimodal(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=5, upscaleNbr=3)
    
    attr(results, "mode") <- "TEST"

    expect_error(plotDensityWithUpscalingSamplesBimodal(x=results, 
        signature="2018_Tiriac_PDAC_PDO_basal-like_signature"), error_message)
})

test_that("plotDensityWithUpscalingSamplesBimodal() must return a list when all parameters valid", {
    
    set.seed(121)

    results <- runSubtypingBimodal(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_true(is.list(plotDensityWithUpscalingSamplesBimodal(x=results, 
        signature="2018_Tiriac_PDAC_PDO_basal-like_signature")))
})

#############################################################################
### Tests plotPermutationSamplesDistribution() 
#############################################################################

test_that("plotPermutationSamplesDistribution() must return an error when x is a list", {
    
    error_message <- "The x object must be of class \'splitTypeResults\'."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(plotPermutationSamplesDistribution(x=gList, 
        signature="test", samples=c("sample_1", "sample_2")), error_message)
})

test_that("plotPermutationSamplesDistribution() must return an error when the signature is not in the object", {
    
    error_message <- paste0("The signature \'DO_NOT_TEST\' must be present ", 
        "in the 'splitTypeResults\' object.")
    
    set.seed(1221)

    results <- runSubtypingBimodal(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_error(plotPermutationSamplesDistribution(x=results, 
        signature="DO_NOT_TEST", samples=c("sample_1", "sample_2")), 
        error_message)
})

test_that("plotPermutationSamplesDistribution() must return an error when one sample is not in the object", {
    
    error_message <- paste0("All the samples must all be present in ", 
                    "the \'splitTypeResults\' object")
    
    set.seed(1221)

    results <- runSubtypingBimodal(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_error(plotPermutationSamplesDistribution(x=results, 
        signature="2018_Tiriac_PDAC_PDO_basal-like_signature", 
        samples=c("sample_154", "sample_2")), error_message)
})