### Unit tests for externalFunctions functions

library(splitTypeR)
library(testthat)

#############################################################################
### Tests runSubtyping() results
#############################################################################

test_that("runSubtyping() must return error when geneLists is a list with 1 entry", {
    
    error_message <- "The \'geneLists\' object must be a list with a least 2 entries."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- "The \'geneLists\' object must be a list with a least 2 entries."
    
    gList <- "test001"
    
    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})