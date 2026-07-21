### Unit tests for externalFunctions functions

library(splitTypeR)
library(testthat)

data("expNormalCountsDemo")
data("signaturesDemo")

#############################################################################
### Tests runSubtypingBimodal() results
#############################################################################

test_that("runSubtypingBimodal() must return error when geneLists is a list with 1 entry", {
    
    error_message <- "The \'geneLists\' object must be a list with at least 2 entries."
    
    gList <- list()
    gList[["test"]] <- c("ABC1", "ABC2")
    
    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        permRatio=0.8, permNbr=10, upscaleNbr=4), error_message)
})

test_that("runSubtypingBimodal() must return error when geneLists is a character vector", {
    
    error_message <- "The \'geneLists\' object must be a list with at least 2 entries."
    
    gList <- "test001"
    
    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=matrix(data=rep(3, 6), nrow = 2), 
        permRatio=0.8, permNbr=10, upscaleNbr=4), error_message)
})

test_that("runSubtypingBimodal() must return error when geneLists is a character vector", {
    
    error_message <- "The \'expectedCountsMatrix\' object must be a matrix."
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- data.frame(P1=c(2, 3, 4), P2=c(3, 4, 5))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10, 
        upscaleNbr=4), error_message)
})

test_that("runSubtypingBimodal() must return error when geneLists is a character vector", {
    
    error_message <- paste0("None of the genes in the signatures are present", 
        " in the row names of the \'expectedCountsMatrix\' matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("TT1", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=0.8, permNbr=10), error_message)
})

test_that("runSubtypingBimodal() must return error when geneLists is a character vector", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
        "matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC2", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10, 
        upscaleNbr=3), error_message)
})


test_that("runSubtypingBimodal() must return error when geneLists is a character vector", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
        "matrix.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5), byrow = FALSE, nrow=3)
    rownames(exCounts) <- c("ABC2", "TT2", "TT3")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=10), 
        error_message)
})

test_that("runSubtypingBimodal() must return error when genes not present for one signatures", {
    
    error_message <- paste0("For at least one gene signature, none of the ", 
        "genes are present in the row names of the \'expectedCountsMatrix\' ", 
            "matrix.")

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:17, 3), byrow=TRUE, nrow=4)
    rownames(exCounts) <- c("ABC11", "KRAS", "ABC22", "FYN")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=-0.8, permNbr=10, 
        upscaleNbr=5), error_message)
})


test_that("runSubtypingBimodal() must return error when 1 gene present for one signatures", {
    
    error_message <- paste0("For at least one gene signature, only one gene ", 
        "is present in the row names of the 'expectedCountsMatrix' ", 
        "matrix.")

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:17, 3), byrow=TRUE, nrow=4)
    rownames(exCounts) <- c("ABC1", "KRAS", "ABC22", "FYN")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=-0.8, permNbr=10, upscaleNbr=3), error_message)
})

test_that("runSubtypingBimodal() must return error when permRatio is a numeric vector", {
    
    error_message <- "The \'permRatio\' must be a numeric between 0 and 1."

    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:7, 8), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("ABC1", "KRAS", "FYN", "ABC2")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=c(0.3, 0.4), permNbr=10, upscaleNbr=3), error_message)
})

test_that("runSubtypingBimodal() must return error when permNbr is a character vector", {
    
    error_message <- paste0("The \'permNbr\' must be an integer higher", 
        " than or equal to 5.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5, 12, 11), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC1", "ABC2", "FYN")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, 
        permRatio=0.8, permNbr="toto", upscaleNbr=3), error_message)
})

test_that("runSubtypingBimodal() must return error when permNbr is 4", {
    
    error_message <- paste0("The \'permNbr\' must be an integer higher", 
        " than or equal to 5.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(2, 3, 4, 3, 4, 5, 12, 11), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC1", "ABC2", "FYN")
    colnames(exCounts) <- c("P1", "P2")

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=4, upscaleNbr=5), 
        error_message)
})

test_that("runSubtypingBimodal() must return error when permRatio is a character vector", {
    
    error_message <- "The \'permRatio\' must be a numeric between 0 and 1."
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(rep(2:13, 4), byrow = FALSE, nrow=4)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio="TEST", permNbr=10, 
        upscaleNbr=10), error_message)
})

test_that("runSubtypingBimodal() must return error when permRatio is too close to one", {
    
    error_message <- paste0("The \'permRatio\' is too close to one. All", 
        " samples are selected for the permutation step rather than a subset.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 10)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:10))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.99, permNbr=10), 
        error_message)
})

test_that("runSubtypingBimodal() must return error when permNbr is too high for the number of samples", {
    
    error_message <- paste0("The \'permNbr\' is too high for the number of", 
        " samples. The number of unique combinations for selecting 8 out of ", 
        "10 samples is 45.")
    
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 10)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:10))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=200), 
        error_message)
})

test_that("runSubtypingBimodal() must return a warning when not enough samples", {
    
    message <- paste0("! A minimum of 10 samples is recommended to run ", 
        "a GSVA analysis.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 5)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:5))

    set.seed(1211)

    expect_warning(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr=10), message)
})

test_that("runSubtypingBimodal() must return an error when upscaleNbr is string", {
    
    message <- paste0("The \'upscaleNbr\' must be an integer equal to or ", 
                "higher than 2.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 12)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr="info"), message)
})

test_that("runSubtypingBimodal() must return an error when upscaleNbr is 1", {
    
    message <- paste0("The \'upscaleNbr\' must be an integer equal to or ", 
                "higher than 2.")
    gList <- list()
    gList[["test1"]] <- c("ABC1", "ABC2")
    gList[["test2"]] <- c("KRAS", "FYN")
    
    exCounts <- matrix(c(rep(2:7, 12)), byrow = TRUE, nrow=6)
    rownames(exCounts) <- c("KRAS", "ABC2", "FYN", "ABC1", "TP53", "MUC12")
    colnames(exCounts) <- c(paste0("P", 1:12))

    expect_error(runSubtypingBimodal(geneLists=gList, 
        expectedCountsMatrix=exCounts, permRatio=0.8, permNbr=5, 
        upscaleNbr=1), regexp=message)
})

test_that("runSubtypingBimodal() must return expected results", {
    
    ## Basal and classical gene list signatures
    gList <- list()
    gList[["classical"]] <- 
        signaturesDemo$`2018_Tiriac_PDAC_PDO_classical_signature`
    gList[["basal"]] <- 
        signaturesDemo$`2018_Tiriac_PDAC_PDO_basal-like_signature`
    
    ## Fix seed
    set.seed(12221)
    
    res <- runSubtypingBimodal(geneLists=gList, 
                    expectedCountsMatrix=expNormalCountsDemo, permNbr=6, 
                    permRatio=0.75, upscaleNbr=10)
    
    expect_equal(class(res), "splitTypeResults")
    expect_true(is.list(res))
    expect_equal(names(res), c("GSVA_RESULTS", "PERMUTATIONS", "SD", 
                "UPSCALING", "MODEL", "CLASSIFICATION"))
    expect_equal(rownames(res$GSVA_RESULTS), c("classical", "basal"))
    expect_equal(colnames(res$GSVA_RESULTS), paste0("Patient_", 1:30))
    expect_equal(unname(res$GSVA_RESULTS[1, 2:3]), c(0.4274225, -0.7532768), 
                    tolerance=1e-5)
    expect_equal(unname(res$GSVA_RESULTS[1, 12:14]), c(-0.2002262, 0.2448591, 
                    0.3249211), tolerance=1e-5)
    expect_equal(unname(res$GSVA_RESULTS[2, 24:27]), c(-0.4255245, 0.9387755, 
                    0.6288557, -0.7916667), tolerance=1e-5)
    expect_equal(unname(res$GSVA_RESULTS[2, 5:7]), c(0.8175287, -0.6076389, 
                    0.1209839), tolerance=1e-5)
    
    expect_equal(names(res$PERMUTATIONS), c("classical", "basal"))
    expect_true(is.matrix(res$PERMUTATIONS$basal))
    expect_true(is.matrix(res$PERMUTATIONS$classical))
    expect_equal(res$PERMUTATIONS$basal[4, ], c(-0.2769297, -0.5514667, 
            NA, -0.1722816, NA, NA), tolerance=1e-5)
    expect_equal(res$PERMUTATIONS$basal[23, ], c(NA, -0.6540043, -0.5772831, 
            -0.3796117, -0.4266846, -0.7001045), tolerance=1e-5)
    expect_equal(res$PERMUTATIONS$classical[14, ], c(0.2802591, NA, NA, 
            0.2105685, 0.2259964, NA), tolerance=1e-5)
    expect_equal(res$PERMUTATIONS$classical[25, ], c(NA, -0.8864572, 
            -0.9043328,NA, -0.8846154, -0.9041733), tolerance=1e-5)
    ## TODO more validations
    expect_equal(names(res$CLASSIFICATION), c("classical", "basal"))
    expect_equal(colnames(res$CLASSIFICATION$basal), c("GSVA_score", 
                                                        "classification"))
    expect_equal(colnames(res$CLASSIFICATION$classical), c("GSVA_score", 
                                                       "classification"))
    expect_equal(rownames(res$CLASSIFICATION$basal), paste0("Patient_", 1:30))
    expect_equal(rownames(res$CLASSIFICATION$classical), 
                 paste0("Patient_", 1:30))
    
})

#############################################################################
### Tests getGeneSignaturesNames() results
#############################################################################

test_that("getGeneSignaturesNames() must return the expected signature names", {
    
    expResults <- c("2018_Tiriac_PDAC_PDO_classical_signature",
                     "2018_Tiriac_PDAC_PDO_basal-like_signature")

    results <- getGeneSignaturesNames()

    expect_equal(results, expResults)
})

#############################################################################
### Tests getGeneSignatures() results
#############################################################################

test_that("getGeneSignatures() must return the expected signatures", {
    
    expNames <- c("2018_Tiriac_PDAC_PDO_classical_signature",
                     "2018_Tiriac_PDAC_PDO_basal-like_signature")
    results <- getGeneSignatures()

    expect_equal(names(results), expNames)
    expect_equal(length(results[[expNames[1]]]), 62L)
    expect_equal(results[[expNames[1]]][1:5], 
            c("MUC13", "GPR35", "USH1C", "BAIAP2L2", "GAL3ST1"))
    expect_equal(results[[expNames[1]]][46:49], 
            c("GATA6", "GPX2", "CA2", "ST6GALNAC1"))
    expect_equal(length(results[[expNames[2]]]), 26L)
    expect_equal(results[[expNames[2]]][1:5], 
            c("ANO1", "ADORA2B", "S100A2", "CSF2", "ANXA1"))
    expect_equal(results[[expNames[2]]][21:24], 
            c("SPRR1B",  "BCAR3", "TTC9", "PTGES"))
})

test_that("getGeneSignatures() must return error when nameList is a number", {
    
    error_message <- paste0("The \'nameList\' parameter must be a vector of ", 
        "characters representing the selected signature names or \'NULL\'.")

    expect_error(getGeneSignatures(nameList=33), regexp=error_message)
})

test_that("getGeneSignatures() must return error when not all names in nameList are present", {
    
    error_message <- paste0("At least one signature is not available.")

    expect_error(getGeneSignatures(
        nameList=c("2018_Tiriac_PDAC_PDO_classical_signature", "Chateau")), 
        regexp=error_message)
})

test_that("getGeneSignatures() must return expected results when nameList is one entry", {
    
    results <- getGeneSignatures(
                nameList=c("2018_Tiriac_PDAC_PDO_classical_signature"))
    
    expect_true(is.list(results))
    expect_equal(length(results), 1L)
    expect_equal(results[[1]][1:5], 
            c("MUC13", "GPR35", "USH1C", "BAIAP2L2", "GAL3ST1"))
    expect_equal(results[[1]][46:49],c("GATA6", "GPX2", "CA2", "ST6GALNAC1"))
    expect_equal(results[[1]][55:58], c("HKDC1", "IYD", "DOK4", "CYP2C18"))
})