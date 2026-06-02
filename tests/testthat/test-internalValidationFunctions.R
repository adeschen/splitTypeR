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

    testMatrix <- matrix(data=rep(3:6, 12), nrow = 4)
    rownames(testMatrix) <- c("ABC", "KRAS", "SMAD4", "FYN")
    colnames(testMatrix) <- paste0("Sample_", 1:12)

    expect_true(splitTypeR:::validateRunSubtyping(geneLists=testSignature, 
        expectedCountsMatrix=testMatrix, permRatio=0.8, permNbr=10))
})


