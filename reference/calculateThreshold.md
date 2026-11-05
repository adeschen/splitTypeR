# Calculate the classification threshold of each signature

This function calculates the classification threshold of each signature
using the mixture model of normal distributions. The threshold
corresponds to the 95th percentile of the sub-distribution with the
lower mean value (the alternative distribution). A sample with a score
above the threshold has a probability lower than 0.05 of being part of
the alternative distribution.

## Usage

``` r
calculateThreshold(geneLists, modelMix)
```

## Arguments

- geneLists:

  a `list` containing signature gene lists.

- modelMix:

  a `list` containing one entry for each gene signature present in the
  `geneLists` object. Each entry contains the mixtures of two normal
  distributions for the signature calculated with sampled values. The
  entry corresponds to the object returned by the
  \`mixtools::normalmixEM\` function.

## Value

a `list` containing one entry for each gene signature present in the
`geneLists` object. Each entry contains the classification threshold of
the signature. When the mixture of normal distributions has not been
calculated successfully, the `NA` value is returned.

## Author

Astrid Deschênes

## Examples

``` r

## Required library
library(mixtools)
#> mixtools package, version 2.0.0.1, Released 2022-12-04
#> This package is based upon work supported by the National Science Foundation under Grant No. SES-0518772 and the Chan Zuckerberg Initiative: Essential Open Source Software for Science (Grant No. 2020-255193).

## Two demo signatures
geneLists <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
    "SignatureB"=c("ACTR2", "AKT1"))

## Create a demo mixture model
set.seed(121)
modelExp <- normalmixEM(c(rnorm(50, mean=-0.4, sd=0.2), 
    rnorm(50, mean=0.4, sd=0.2)), k=2, verb=FALSE)
#> number of iterations= 24 
model <- list("SignatureA"=modelExp, "SignatureB"=modelExp)

## Calculate the classification threshold of each signature
splitTypeR:::calculateThreshold(geneLists=geneLists, modelMix=model)
#> $SignatureA
#> [1] -0.09313736
#> 
#> $SignatureB
#> [1] -0.09313736
#> 
```
