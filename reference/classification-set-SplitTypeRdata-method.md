# Replacement of the classification slot in a `SplitTypeRdata` object

A function for replacement of the classification slot in a
`SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
classification(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the classification data for each signature. The
  `list` should have one entry per signature.

## Value

the modified `SplitTypeRdata` object when the new value is valid.

## Author

Astrid Deschênes

## Examples

``` r

## Two demo signatures
sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"),
    "SignatureB"=c("ACTR2", "AKT1"))

## Create a SplitTypeRdata object with the signatures
demo <- new("SplitTypeRdata", signatures=sign)

## Create the classification of 3 samples for each signature
## Each entry contains the GSVA score of each sample and its
## classification (the signature name or "unclassified")
demoClass <- list()
demoClass[["SignatureA"]] <- data.frame(GSVA_score=c(0.45, -0.32, 0.12),
    classification=c("SignatureA", "unclassified", "unclassified"),
    row.names=c("Sample_1", "Sample_2", "Sample_3"))
demoClass[["SignatureB"]] <- data.frame(GSVA_score=c(-0.51, 0.38, 0.29),
    classification=c("unclassified", "SignatureB", "SignatureB"),
    row.names=c("Sample_1", "Sample_2", "Sample_3"))

## Assign the classification to the object
classification(demo) <- demoClass

## Get the classification for the first signature
classification(demo)[["SignatureA"]]
#>          GSVA_score classification
#> Sample_1       0.45     SignatureA
#> Sample_2      -0.32   unclassified
#> Sample_3       0.12   unclassified
```
