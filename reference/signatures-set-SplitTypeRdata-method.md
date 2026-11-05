# Replacement of signatures slot in a `SplitTypeRdata` object

A function for replacement of the signatures slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
signatures(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the genes for each signature. The `list` should
  have one entry per signature.

## Value

the modified `SplitTypeRdata` object when the new value is valid.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
paramDemo <- new("SplitTypeRdata")

## Demo study data frame
signaDemo <- list("SignatureA"=c("KRAS", "AKT1", "MTOR"), 
    "SignatureB"=c("PIK3CB", "CTTN"))

## Assign the new list to the signatures slot in the object
signatures(paramDemo) <- signaDemo
```
