# Parameter validation for the runSubtyping function

This function validates the parameters for the runSubtyping function.
When a parameter is incorrect, a message is sent to the user before
quitting the program.

## Usage

``` r
validateRunSubtyping(
  geneLists,
  expectedCountsMatrixLog,
  permRatio,
  permNbr,
  upscaleNbr
)
```

## Arguments

- geneLists:

  a `list` containing signature gene lists. At least two signature gene
  lists must be present.

- expectedCountsMatrixLog:

  a log2-normalized gene expression data `matrix` with rows
  corresponding to genes and columns to samples. Other data that also be
  used as long as it conforms with the Gaussian behavior. As examples,
  log2(TPM + 1), log2(CPM + 1), or vst(counts) would be acceptable.

- permRatio:

  a `numeric` between 0 and 1 representing the number of samples that
  are retained for the permutation step. The rounded value of the number
  of patients multiplied by this `numeric` should be inferior to the
  total number of patients so that the permutation step is not done on
  the entire cohort.

- permNbr:

  a `integer` bigger than or equal to 5 representing the number of
  permutation sampling done.

- upscaleNbr:

  a `integer`, 2 or higher, representing the number of values taken for
  the normal distribution for each sample to run the upscaling step.

## Value

`TRUE` when all parameters are valid

## Author

Astrid Deschênes

## Examples

``` r

## Create a list with 2 signatures
gList <- list()
gList[["signature1"]] <- c("ABC1", "ABC2", "SMAD3", "MUC12")
gList[["signature2"]] <- c("FYN", "RAS", "SMAD4")

## Create a small gene matrix
expCounts <- matrix(data=rep(22:25, 15), nrow=4)
rownames(expCounts) <- c("ABC1", "RAS", "FYN", "SMAD3")
colnames(expCounts) <- c(paste0("Sample_", 1:15))
expCountsLog <- log2(expCounts + 1)

## The function returns TRUE when all parameters are valid
splitTypeR:::validateRunSubtyping(geneLists=gList, 
     expectedCountsMatrixLog=expCountsLog, permRatio=0.8, permNbr=10, 
     upscaleNbr=20)
#> [1] TRUE
```
