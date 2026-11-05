# Replacement of permutations slot in a `SplitTypeRdata` object

A function for replacement of the permutations slot in a
`SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
permutations(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the permutations results for each signature. The
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

## Demo study data frame
demoPerm1 <- matrix(data=c(0.23772165, -0.71262458, 0.42328775, 
        -0.65149268, 0.18324268, 0.007158662), nrow=2, ncol=3, byrow=FALSE)
rownames(demoPerm1) <- paste0("Patient_", 1:2)

demoPerm2 <- matrix(data=c(0.29772165, 0.21262458, 0.42218775, 
        0.65133268, 0.18324268, -0.017158662), nrow=2, ncol=4, byrow=FALSE)
#> Warning: data length [6] is not a sub-multiple or multiple of the number of columns [4]
rownames(demoPerm2) <- paste0("Patient_", 1:2)
demoPerm <- list()
demoPerm[[names(sign)[1]]] <- demoPerm1
demoPerm[[names(sign)[2]]] <- demoPerm2


permutations(demo) <- demoPerm
```
