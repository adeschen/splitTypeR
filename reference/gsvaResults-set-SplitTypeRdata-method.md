# Replacement of gsvaResults slot in a `SplitTypeRdata` object

A function for replacement of the gsvaResults slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
gsvaResults(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `matrix` of the GSVA results for each signature. The
  `matrix` should have one row per signature. Default: `NULL`.

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

## Demo study data frame
signaDemo <- matrix(data=c(0.23772165, -0.71262458, 0.42328775, 
    -0.65149268, 0.18324268, 0.007158662), nrow=2, ncol=3, byrow=FALSE)
colnames(signaDemo) <- paste0("Patient_", 1:3)
rownames(signaDemo) <- c("SignatureA", "SignatureB")

gsvaResults(demo) <- signaDemo
```
