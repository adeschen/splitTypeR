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
        permRatio=0.8, permNbr=10, upscaleNbr=4), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- "The \'geneLists\' object must be a list with at least 2 entries."
    
    gList <- "test001"
    
    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        permRatio=0.8, permNbr=10, upscaleNbr=4), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- "The \'expectedCountsMatrix\' object must be a matrix."
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- data.frame(P1=c(2, 3, 4), P2=c(3, 4, 5))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10, 
        upscaleNbr=4), error_message)
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
        permRatio=0.8, permNbr=10), error_message)
})

test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
        "matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC2", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10, 
        upscaleNbr=3), error_message)
})


test_that("runSubtyping() must return error when geneLists is a character vector", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
        "matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC2", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10), 
        error_message)
})

test_that("runSubtyping() must return error when genes not present for one signatures", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
            "matrix.")

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:17, 3), byrow=TRUE, nrow=4)
    rownames(exCounts) <- c("ABC11", "KRAS", "ABC22", "FYN")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=-0.8, permNbr=10, 
        upscaleNbr=5), error_message)
})


test_that("runSubtyping() must return error when 1 gene present for one signatures", {
    
    error_message <- paste0("For at least one gene signature, only one gene ", 
        "is present in the row names of the 'expectedCountsMatrix' ", 
        "matrix.")

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:17, 3), byrow=TRUE, nrow=4)
    rownames(exCounts) <- c("ABC1", "KRAS", "ABC22", "FYN")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=-0.8, permNbr=10, upscaleNbr=3), error_message)
})

test_that("runSubtyping() must return error when permRatio is a numeric vector", {
    
    error_message <- "The \'permRatio\' must be a numeric between 0 and 1."

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:7, 8), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("ABC1", "KRAS", "FYN", "ABC2")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=c(0.3, 0.4), permNbr=10, upscaleNbr=3), error_message)
})

test_that("runSubtyping() must return error when permNbr is a character vector", {
    
    error_message <- paste0("The \'permNbr\' must be an integer higher", 
        " than or equal to 5.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5, 12, 11), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC1", "ABC2", "FYN")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=0.8, permNbr="toto", upscaleNbr=3), error_message)
})

test_that("runSubtyping() must return error when permNbr is 4", {
    
    error_message <- paste0("The \'permNbr\' must be an integer higher", 
        " than or equal to 5.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5, 12, 11), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC1", "ABC2", "FYN")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=4, upscaleNbr=5), 
        error_message)
})

test_that("runSubtyping() must return error when permRatio is a character vector", {
    
    error_message <- "The \'permRatio\' must be a numeric between 0 and 1."
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:13, 4), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio="TEST", permNbr=10, 
        upscaleNbr=10), error_message)
})

test_that("runSubtyping() must return error when permRatio is too close to one", {
    
    error_message <- paste0("The \'permRatio\' is too close to one. All", 
        " samples are selected for the permutation step rather than a subset.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 10)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:10))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.99, permNbr=10), 
        error_message)
})

test_that("runSubtyping() must return error when permNbr is too high for the number of samples", {
    
    error_message <- paste0("The \'permNbr\' is too high for the number of", 
        " samples. The number of unique combinations for selecting 8 out of ", 
        "10 samples is 45.")
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 10)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:10))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=200), 
        error_message)
})

test_that("runSubtyping() must return a warning when not enough samples", {
    
    message <- paste0("! A minimum of 10 samples is recommended to run ", 
        "a GSVA analysis.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 5)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:5))

    set.seed(1211)

    expect_warning(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr=10), message)
})

test_that("runSubtyping() must return an error when upscaleNbr is string", {
    
    message <- paste0("The \'upscaleNbr\' must be an integer equal to or ", 
                "higher than 2.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 12)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr="info"), message)
})

test_that("runSubtyping() must return an error when upscaleNbr is 1", {
    
    message <- paste0("The \'upscaleNbr\' must be an integer equal to or ", 
                "higher than 2.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 12)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtyping(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr=1), message)
})

#############################################################################
### Tests geneSignaturesListNames() results
#############################################################################

test_that("geneSignaturesListNames() must return the expected signature names", {
    
    expResults <- c("2018_Tiriac_PDAC_PDO_classical_signature",
                     "2018_Tiriac_PDAC_PDO_basal-like_signature")

    results <- geneSignaturesListNames()

    expect_equal(results, expResults)
})
