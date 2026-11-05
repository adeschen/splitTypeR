# Use the permutation method to calculate the standard deviation associated with the GSVA score obtained for each sample

This function calculates GSVA score for multiple permutation sampling of
the dataset to obtain the standard deviation associated with each
sample.

## Usage

``` r
permuteGSVA(geneLists, countMatrix, permRatio, permNbr)
```

## Arguments

- geneLists:

  a `list` containing signature gene lists.

- countMatrix:

  a normalized gene expression data `matrix` with rows corresponding to
  genes and columns to samples. The `matrix` has been filtered to
  contain only the genes present in the signature gene lists.

- permRatio:

  a `numeric` between 0 and 1 representing the number of samples that
  are retained for the permutation step.

- permNbr:

  a `integer` bigger than or equal to 5 representing the number of
  permutation samplings done.

## Value

a `list` containing two entries named "PERMUTATIONS" and "SD".

- The "PERMUTATIONS" entry is a `list` with one entry per signature
  name. The entry contains the `matrix` with all the GSVA scores for the
  permutations done on this signature.

- The "SD" entry is a `list` with one entry per signature name. The
  entry contains the `vector` of `numeric` corresponding to the standard
  deviation calculated for each sample. The `NA` value is present when
  the standard deviation could not be calculated.

## Author

Astrid Deschênes

## Examples

``` r

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

## Calculate standard deviation for each sample using permutation method
result <- splitTypeR:::permuteGSVA(geneLists=geneLists, 
    countMatrix=expNormalCountsDemo, permRatio=0.75, permNbr=20)

## The output contains all the permutations and the calculated standard 
## deviation in two lists called "SD" and "PERMUTATIONS"

## The standard deviation of the samples for the classical signature
head(result[["SD"]][["classical"]])
#>  Patient_1  Patient_2  Patient_3  Patient_4  Patient_5  Patient_6 
#> 0.07928929 0.08489351 0.02375852 0.10266426 0.02003059 0.06175357 

## Some of the GSVA results for the permutations related to the basal
## signature
result[["PERMUTATIONS"]][["basal"]][5:8, 1:5]
#>                 [,1]       [,2]      [,3]       [,4]       [,5]
#> Patient_5         NA  0.8579320 0.8109489  0.8294574         NA
#> Patient_6 -0.5500000 -0.5037037        NA -0.6133738 -0.5892815
#> Patient_7  0.1731537         NA 0.1201357  0.1308321         NA
#> Patient_8  0.3629630  0.3411765 0.2590580  0.2621622  0.2823758
```
