# Replacement of threshold slot in a `SplitTypeRdata` object

A function for replacement of the threshold slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
threshold(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the classification thresholds for each
  signature. The `list` should have one entry per signature.

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

## Assign a classification threshold to each signature
threshold(demo) <- list("SignatureA"=0.12, "SignatureB"=-0.05)
```
