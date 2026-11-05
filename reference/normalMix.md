# Construct the mixture of two normal distributions for each signature

This function constructs a comprehensive mixture of two normal
distributions for each signature using the pooled sampled values from
the up-scaling step.

## Usage

``` r
normalMix(geneLists, resultNorm)
```

## Arguments

- geneLists:

  a `list` containing signature gene lists.

- resultNorm:

  a `list` containing one entry for each gene signature present in the
  `geneLists` object. Each entry contains a `matrix` with all the values
  sampled from the normal distribution obtained from the GSVA score
  (mean) and the permutations (standard deviation). One row of the
  `matrix` represents one sample. The columns correspond to the number
  of draws.

## Value

a `list` containing one entry for each gene signature present in the
`geneLists` object. Each entry contains the mixtures of two normal
distributions for the signature calculated with sampled values. The
entry corresponds to the object returned by the
\`mixtools::normalmixEM\` function. When the mixture of two normal
distributions cannot be calculated successfully, the \\NA\\ value is
present.

## Author

Astrid Deschênes

## Examples

``` r

## Required library
library(GSVA)

## Load signatures
data(signaturesDemo)

## Create a list of two signatures
geneLists <- list()
geneLists[["classical"]] <- 
    signaturesDemo$`Classical`
geneLists[["basal"]] <- 
    signaturesDemo$`Basal-like`

## Load demo normalized expected counts
data(expNormalCountsDemo)

## Fix seed for reproducibility
set.seed(144)

## Calculate GSVA scores for the signatures
gsvaParameter <- gsvaParam(exprData=as.matrix(expNormalCountsDemo),
    geneSets=geneLists)
resClass <- gsva(param=gsvaParameter, verbose=FALSE)

## Calculate standard deviation for each sample using the permutation method
permResult <- splitTypeR:::permuteGSVA(geneLists=geneLists, 
    countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)

## For each sample, randomly select 10 values (nbValues) from the normal 
## curve where mean is the real GSVA value, and the standard deviation is 
## calculated from the permutation step.
normResult <- splitTypeR:::extractFromNormalDist(geneLists=geneLists, 
    gsvaRes=resClass, gsvaSD=permResult$SD, nbValues=10)

## Extracting the mixtures of two normal distributions for each signature
model <- splitTypeR:::normalMix(geneLists=geneLists, resultNorm=normResult)

## The two means of the normal distributions for the basal signature
model[["basal"]]$mu
#> [1] -0.5352405  0.3578356
```
