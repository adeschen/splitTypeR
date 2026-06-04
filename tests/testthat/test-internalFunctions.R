### Unit tests for internalFunctions functions

library(splitTypeR)
library(testthat)

#############################################################################
### Tests permuteGSVA() results
#############################################################################

test_that("permuteGSVA() must return expected results", {
    
    ## Demo normalized expected counts matrix
    expectedCountsMatrix <- splitTypeR::expNormalCountsDemo[, 1:15]
    
    ## Basal and classical gene list signatures
    gList <- list()
    gList[["classical"]] <- 
        splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_classical_signature`
    gList[["basal"]] <- 
        splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_basal-like_signature`

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

    expSD <- list()
    expSD[["classical"]] <- c(0.10273488, 0.03622632, NA, 0.11087233, 
        0.03055436, 0.03655507, 0.08054100, 0.07157925, 0.10636982,
        0.08411299, 0.07672066, 0.05807137, 0.04191741, 0.11095127, 0.11108967)
    names(expSD[["classical"]]) <- paste0("Patient_", 1:15)    
    expSD[["basal"]] <- c(0.09652651, 0.07183212, NA, 0.11841886, 0.02106352, 
        0.01166254, 0.11538878, 0.06553981, 0.13836817, 0.09841366, 0.06659764, 
        0.11975838, 0.12796290, 0.11051607, 0.13049066)
    names(expSD[["basal"]]) <- paste0("Patient_", 1:15)

    ## Fix seed
    set.seed(121)

    results <- splitTypeR:::permuteGSVA(geneLists=gList, 
        countMatrix=expectedCountsMatrix, permRatio=0.8, permNbr=5)
    
    expect_true(is.list(results))
    expect_equal(names(results), c("PERMUTATIONS", "SD"))
    expect_equal(rownames(results$PERMUTATIONS$classical), 
        rownames(expResults$classical))
    expect_equal(results$PERMUTATIONS$classical, expResults$classical, 
        tolerance=1e-4)
    expect_equal(rownames(results$PERMUTATIONS$basal), 
        rownames(expResults$basal))
    expect_equal(results$PERMUTATIONS$basal, expResults$basal, tolerance=1e-4)
    expect_equal(rownames(results$PERMUTATIONS$basal), 
        rownames(expResults$basal))
    expect_equal(rownames(results$SD$basal), rownames(expSD$basal))
    expect_equal(results$SD$basal, expSD$basal, tolerance=1e-4)
    expect_equal(rownames(results$SD$classical), rownames(expSD$classical))
    expect_equal(results$SD$classical, expSD$classical, tolerance=1e-4)
})

#############################################################################
### Tests extractFromNormalDist() results
#############################################################################

test_that("extractFromNormalDist() must return expected results", {
    
    ## Basal and classical gene list signatures
    gList <- list()
    gList[["classical"]] <- 
        splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_classical_signature`
    gList[["basal"]] <- 
        splitTypeR::signatures$`2018_Tiriac_PDAC_PDO_basal-like_signature`

    gsvaRes<- matrix(data=NA, nrow=2, ncol=12, byrow=FALSE)
    colnames(gsvaRes) <- paste0("Patient_", 1:12)
    rownames(gsvaRes) <- c("classical", "basal")
    gsvaRes["classical", ] <- c(0.1422663,  0.4274225, -0.7532768,  0.3479971, 
        -0.6732937,  0.5735090, -0.1247647, -0.1261704, -0.1287452,  0.4370278, 
        0.5913501, -0.2002262)
    gsvaRes["basal", ] <- c(-0.2385417, -0.4403292,  0.8006550, -0.4500838,  
        0.8175287, -0.6076389,  0.1209839, 0.2276770, 0.1643817, -0.4448441, 
        -0.6485138, 0.1993417)

    gsvaSD <- list()
    gsvaSD[["classical"]] <- c(0.10273488, 0.03622632, NA, 0.11087233, 
        0.03055436, 0.03655507, 0.08054100, 0.07157925, 0.10636982,
        0.08411299, 0.07672066, 0.05807137)
    names(gsvaSD[["classical"]]) <- paste0("Patient_", 1:12)    
    gsvaSD[["basal"]] <- c(0.09652651, 0.07183212, NA, 0.11841886, 0.02106352, 
        0.01166254, 0.11538878, 0.06553981, 0.13836817, 0.09841366, 0.06659764, 
        0.11975838)
    names(gsvaSD[["basal"]]) <- paste0("Patient_", 1:12)

    expResults <- list()
    expResults[["classical"]] <- matrix(data=NA, nrow=12, ncol=3)
    rownames(expResults[["classical"]]) <- paste0("Patient_", 1:12)
    expResults[["classical"]][, 1] <- c(0.11603187, 0.42448551, NA, 0.38095574, 
        -0.64538079, 0.55885569, -0.04416501, -0.20911208, -0.09669008, 
        0.49115370, 0.50398990, -0.12025550)
    expResults[["classical"]][, 2] <- c(0.15340016,  0.40156837, NA, 
        0.34160496, -0.63043219, 0.55282036, -0.24308195, -0.09021758, 
        -0.13315220, 0.36913511, 0.52457597, -0.18797949)
    expResults[["classical"]][, 3] <- c(0.15539382,  0.48594004, NA, 
        0.22608098, -0.69961528,  0.59341924, -0.02684826, -0.09962719,
        -0.03222638, 0.50282396, 0.55008371, -0.22744472)
    expResults[["basal"]] <- matrix(data=NA, nrow=12, ncol=3)
    rownames(expResults[["basal"]]) <- paste0("Patient_", 1:12)
    expResults[["basal"]][, 1] <- c(-0.374418011, -0.406328077, NA, 
        -0.374606267, 0.780689038, -0.610763217, 0.154905628, 0.093331315, 
        -0.001235112, -0.413533630, -0.640828328,  0.276673695)
    expResults[["basal"]][, 2] <- c(-0.2588540, -0.3890133, NA, -0.5394992, 
        0.8190593, -0.5998769, 0.1731128, 0.1678703, 0.2572114,
        -0.3855583, -0.7094234, 0.2126101)
    expResults[["basal"]][, 3] <- c(-0.16896966, -0.44142794, NA, -0.37024311, 
        0.80471797, -0.60270496, 0.01350371, 0.29972715, -0.28054256, 
        -0.32014899, -0.78445331, 0.26931493)

    ## Fix seed
    set.seed(121)

    results <- splitTypeR:::extractFromNormalDist(geneLists=gList, 
        gsvaRes=gsvaRes, gsvaSD=gsvaSD, nbValues=3)
    
    expect_true(is.list(results))
    expect_equal(names(results), names(expResults))
    expect_equal(rownames(results$classical), rownames(expResults$classical))
    expect_equal(results$classical, expResults$classical, tolerance=1e-4)
    expect_equal(rownames(results$basal), rownames(expResults$basal))
    expect_equal(results$basal, expResults$basal, tolerance=1e-4)
})