### Unit tests for internalFunctions functions

library(splitTypeR)
library(testthat)

#############################################################################
### Tests bootstrapGSVA() results
#############################################################################

test_that("bootstrapGSVA() must return expected results", {
    
    ## Demo normalized expected counts matrix
    expectedCountsMatrix <- splitTypeR::expNormalCountsDemo[, 1:15]
    
    ## Basal and classical gene list signatures
    gList <- list()
    gList[["classical"]] <- splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_classical_signature`
    gList[["basal"]] <- splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_basal-like_signature`

    ## Expected results
    expResults <- list()

    expResults[["classical"]] <- matrix(data=NA, nrow=15, ncol=5, byrow=FALSE)
    rownames(expResults[["classical"]]) <- paste0("Patient_", 1:15)
    expResults[["classical"]][, 1] <- c(0.23772165, NA, -0.71262458, 
        0.42328775, -0.65149268, NA, -0.07469342, -0.19742005, -0.01890578, 
        0.47035256, 0.67170660, -0.20823921, NA, 0.39589943, 0.18324268)
    expResults[["classical"]][, 2] <- c(0.007158662, 0.263418803, NA, 
        0.169815921, -0.708384551, 0.440403512, NA, -0.351134689, NA,
        0.305921856, 0.540939967, -0.303309838, 0.052986107, 0.258202913, 
        0.053654644)
    expResults[["classical"]][, 3] <- c(0.01796580, 0.23866531, NA, NA, NA, 
        0.50844922, -0.25080407, -0.35912813, -0.25468975, 0.23963536,
        0.52130559, -0.33078168, 0.03280886, 0.13481364, -0.04663262)
    expResults[["classical"]][, 4] <- c(0.19319771, 0.30978292, NA, 0.24622011, 
        -0.70603931, NA, -0.13058732, -0.23788099, -0.04454898, 0.34173721,
        NA, -0.19735820, 0.11336639, 0.39769231, 0.18150815)
    expResults[["classical"]][, 5] <- c(0.1129726, 0.3127388, NA, 0.2158457, 
        -0.7197987, 0.4975814, -0.2179930, -0.3168637, -0.1311704, 0.3299132, 
        0.5023573, -0.2594268, NA, 0.2531843, NA)

    expResults[["basal"]] <- matrix(data=NA, nrow=15, ncol=5, byrow=FALSE)
    rownames(expResults[["basal"]]) <- paste0("Patient_", 1:15)
    expResults[["basal"]][, 1] <- c(-0.30640228, NA, 0.80038760, -0.48927739, 
        0.79044715, NA, 0.09408284, 0.28918919, -0.03114754, -0.48410982, 
        -0.71500000, 0.17477477, NA, -0.44432624, -0.23141704)
    expResults[["basal"]][, 2] <- c(-0.07991004, -0.27665331, NA, -0.25871664, 
        0.83787879, -0.51058302, NA, 0.38835784, NA, -0.26052632, -0.62409910, 
        0.27693603, -0.09385965, -0.33888889, -0.04606625)
    expResults[["basal"]][, 3] <- c(-0.06358025, -0.23503401, NA, NA, NA, 
        -0.48773234, 0.36407513, 0.44368932, 0.28437725, -0.27644516,
        -0.55453048, 0.48167482, 0.03440454, -0.16904762, 0.01407867)
    expResults[["basal"]][, 4] <- c(-0.13638498, -0.40303030, NA, -0.48589744, 
        0.79920040, NA, 0.19536341, 0.29351145, 0.07734205, -0.43893557, NA, 
        0.20622776, -0.22152104, -0.42586521, -0.24416270)
    expResults[["basal"]][, 5] <- c(-0.1275785, -0.3200000, NA, -0.3137120, 
        0.8178843, -0.5032110, 0.2782609, 0.3647727, 0.1999366, -0.3446735, 
        -0.6529557, 0.3031940, NA, -0.3018909, NA)

    ## Fix seed
    set.seed(121)

    results <- splitTypeR:::bootstrapGSVA(geneLists=gList, 
        countMatrix=expectedCountsMatrix, 
        bootstrapRatio=0.8, bootstrapNbr=5)
    
    expect_true(is.list(results))
    expect_equal(names(results), names(expResults))
    expect_equal(rownames(results$classical), rownames(expResults$classical))
    expect_equal(results$classical, expResults$classical, tolerance=1e-4)
    expect_equal(rownames(results$basal), rownames(expResults$basal))
    expect_equal(results$basal, expResults$basal, tolerance=1e-4)
})
