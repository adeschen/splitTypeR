# Replacement of the standardDeviation slot in a `SplitTypeRdata` object

A function for replacement of the standardDeviation slot in a
`SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
standardDeviation(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the sample standard deviations for each
  signature. The `list` should have one entry per signature. Each entry
  is a named `numeric` `vector` containing the standard deviation of the
  GSVA scores obtained for each sample during the permutation step.

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

## Create standard deviations
demoSD <- list()
demoSD[[names(sign)[1]]] <- c(0.01748988, 0.08992500, 0.11781061, 0.0747440)
demoSD[[names(sign)[2]]] <- c(0.02058364, 0.08476766, 0.14783058, 0.1009961)

standardDeviation(demo) <- demoSD
```
