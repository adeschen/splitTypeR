### Unit tests for internalValidationFunctions functions

library(splitTypeR)
library(testthat)

#############################################################################
### Tests validateRunSubtyping() results
#############################################################################

test_that("validateRunSubtyping() must return TRUE when all parameters are valid", {

    testSignature <- list()
    testSignature[["signatureA"]] <- c("SMAD4", "KRAS", "CDC")
    testSignature[["signatureB"]] <- c("ABC", "FYN", "DHC")

    testMatrix <- matrix(data=rep(3, 6), nrow = 2)
    rownames(testMatrix) <- c("ABC", "KRAS")

    expect_true(splitTypeR:::validateRunSubtyping(geneLists=testSignature, 
        expectedCountsMatrix=testMatrix, 
        bootstrapRatio=0.8, bootstrapNbr=10))
})


