# Show a summary of a SplitTypeRdata object

A function that displays a summary of a `SplitTypeRdata` object: the
signatures with their number of genes, the number of samples, the steps
of the method that have been run and, for each signature, the number of
samples assigned to the signature. The function is called when the
object is printed at the console.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
show(object)
```

## Arguments

- object:

  a `SplitTypeRdata` object.

## Value

`NULL`, invisibly. The function is called for its side effect: the
summary of the object is displayed at the console.

## Author

Astrid Deschênes

## Examples

``` r

## Two demo signatures
sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"),
    "SignatureB"=c("ACTR2", "AKT1"))

## Create a SplitTypeRdata object with the signatures
demo <- SplitTypeRdata(signatures=sign)

## Show the summary of the object
demo
#> A SplitTypeRdata object
#> Signatures (2): SignatureA (3 genes), SignatureB (2 genes)
#> Completed steps: none
```
