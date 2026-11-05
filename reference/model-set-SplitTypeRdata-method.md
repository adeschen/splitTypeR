# Replacement of model slot in a `SplitTypeRdata` object

A function for replacement of the model slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
model(x) <- value
```

## Arguments

- x:

  a `SplitTypeRdata` object.

- value:

  `NULL` or a `list` of the mixture models calculated for each
  signature. The `list` should have one entry per signature.

## Value

the modified `SplitTypeRdata` object when the new value is valid.

## Author

Astrid Deschênes

## Examples

``` r

## Load required library
library(mixtools)

## Two demo signatures
sign <- list("SignatureA"=c("EGFR", "CTTN", "ACTB"), 
    "SignatureB"=c("ACTR2", "AKT1"))
    
## Create a SplitTypeRdata object with the signatures
demo <- new("SplitTypeRdata", signatures=sign)

## Create demo model
set.seed(121)
modelExp <- normalmixEM(c(sample(1:25, size=12, replace=TRUE), 
                sample(23:45, size=12, replace=TRUE)), k=2, verb=FALSE)
#> number of iterations= 10 
                
## Create demo models
demoModels <- list()
demoModels[[names(sign)[1]]] <- modelExp
demoModels[[names(sign)[2]]] <- modelExp

model(demo) <- demoModels
```
