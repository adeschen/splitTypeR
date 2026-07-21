### Unit tests for externalGraphFunctions functions

library(splitTypeR)
library(testthat)

data("expNormalCountsDemo")
data("signaturesDemo")


#############################################################################
### Tests plotDensityWithUpscalingSamples() 
#############################################################################

test_that("plotDensityWithUpscalingSamples() must return an error when x is a list", {
    
    error_message <- "The x object must be of class \'splitTypeResults\'."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(plotDensityWithUpscalingSamples(x=gList, 
        signature="test"), error_message)
})

test_that("plotDensityWithUpscalingSamples() must return an error when signature is not in object", {

    error_message <- paste0("The signature \'DO_NOT_TEST\' must be present ", 
        "in the 'splitTypeResults\' object.")
    
    set.seed(1221)

    results <- runSubtyping(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_error(plotDensityWithUpscalingSamples(x=results, 
        signature="DO_NOT_TEST"), error_message)
})

test_that("plotDensityWithUpscalingSamples() must return a list when all parameters valid", {
    
    set.seed(121)

    results <- runSubtyping(geneLists=signaturesDemo, 
        expectedCountsMatrix=expNormalCountsDemo, 
        permRatio=0.75, permNbr=10, upscaleNbr=5)
    
    expect_true(is.list(plotDensityWithUpscalingSamples(x=results, 
        signature="2018_Tiriac_PDAC_PDO_basal-like_signature")))
})