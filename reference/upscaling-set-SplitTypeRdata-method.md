# Replacement of the upscaling slot in a `SplitTypeRdata` object

A function for replacement of the upscaling slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
upscaling(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the upscaling data for each signature. The
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

## Create demo upscaling data
demoUp <- list()
demoUp[[names(sign)[1]]] <- matrix(data=c(0.0174988, 0.0892500, 0.1178101, 
0.0744401, 0.0654692, 0.2546492), nrow=2, ncol=3, byrow=FALSE)
demoUp[[names(sign)[2]]] <- matrix(data=c(0.3749488, 0.4894500, 0.2118101, 
0.4444401, 0.4154692, 0.8543392), nrow=2, ncol=3, byrow=FALSE)

upscaling(demo) <- demoUp
```
