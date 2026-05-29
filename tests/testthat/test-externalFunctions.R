### Unit tests for externalFunctions functions

library(splitTypeR)
library(testthat)

#############################################################################
### Tests runSubtyping() results
#############################################################################

test_that("runSubtyping() must return error when geneLists is a list with 1 entry", {
    
    error_message <- "The \'geneLists\' object must be a list with at least 2 entries."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- "The \'geneLists\' object must be a list with at least 2 entries."
    
    gList <- "test001"
    
    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- "The \'expectedCountsMatrix\' object must be a matrix."
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- data.frame(P1=c(2, 3, 4), P2=c(3, 4, 5))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- paste0("None of the genes in the signatures are present", 
        " in the row names of the \'expectedCountsMatrix\' matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("TT1", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        bootstrapRatio=0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when bootstrapRatio is a negative numeric", {
    
    error_message <- "The \'bootstrapRatio\' must be a numeric between 0 and 1."

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC1", "KRAS", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        bootstrapRatio=-0.8, bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when bootstrapRatio is a numeric vector", {
    
    error_message <- "The \'bootstrapRatio\' must be a numeric between 0 and 1."

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC1", "KRAS", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        bootstrapRatio=c(0.3, 0.4), bootstrapNbr=10), error_message)
})

test_that("runSubtyping() must return error when bootstrapNbr is a character vector", {
    
    error_message <- "The \'bootstrapNbr\' must be an integer higher than 0."
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("KRAS", "ABC1", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        bootstrapRatio=0.8, bootstrapNbr="toto"), error_message)
})