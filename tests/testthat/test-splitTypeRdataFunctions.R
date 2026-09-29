### Unit tests for splitTypeRdata class functions

library(splitTypeR)

#############################################################################
### Tests splitTypeRdata class
#############################################################################

context("splitTypeRdata class results")


test_that("create a splitTypeRdata class with all default parameters should return an object", {
    
    ## New splitTypeRdata with all default values
    paramTest <- new("SplitTypeRdata")
    
    ## Test signatures
    expect_true(is.null(paramTest@signatures))
    
    ## Test gsvaResults
    expect_true(is.null(paramTest@gsvaResults))
    
    ## Test permutations
    expect_true(is.null(paramTest@permutations))
    
    ## Test standardDeviation
    expect_true(is.null(paramTest@standardDeviation))
    
    ## Test upscaling
    expect_true(is.null(paramTest@upscaling))
    
    ## Test model
    expect_true(is.null(paramTest@model))
    
    ## Test classification
    expect_true(is.null(paramTest@classification))
})

test_that("create a splitTypeRdata() function with all default parameters should return an object", {
    
    ## New splitTypeRdata with all default values
    paramTest <- SplitTypeRdata()
    
    ## Test signatures
    expect_true(is.null(paramTest@signatures))
    
    ## Test gsvaResults
    expect_true(is.null(paramTest@gsvaResults))
    
    ## Test permutations
    expect_true(is.null(paramTest@permutations))
    
    ## Test standardDeviation
    expect_true(is.null(paramTest@standardDeviation))
    
    ## Test upscaling
    expect_true(is.null(paramTest@upscaling))
    
    ## Test model
    expect_true(is.null(paramTest@model))
    
    ## Test classification
    expect_true(is.null(paramTest@classification))
})


test_that("create a SplitTypeRdata class with integer for signatures parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", signatures=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for gsvaResults parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", gsvaResults=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for permutations parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", permutations=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for sd parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", standardDeviation=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for upscaling parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", upscaling=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for model parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", model=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with integer for classification parameter should generate an error", {
    
    expect_error(new("SplitTypeRdata", classification=33), 
                 "got class \"numeric\", should be or extend class \"ListOrNULL\"")
})

test_that("create a SplitTypeRdata class with signatures setter and getter should return an object", {
    
    exp <- list("SignatureA"=c("Gene1", "Gene2", "Gene3"), 
                        "SignatureB"=c("Gene10", "Gene12"))
    
    paramTest <- new("SplitTypeRdata")
    signatures(paramTest) <- exp
    
    expect_equal(signatures(paramTest), exp)
    expect_error(signatures(paramTest) <- 33L)
    expect_equal(signatures(paramTest), exp)
})
