# Permutation parameters validation for the runSubtyping function

This function validates the permutation parameters for the runSubtyping
function. When a parameter is incorrect, a message is sent to the user
before quitting the program.

## Usage

``` r
validateRunSubtypingSubSection(nbAll, permRatio, permNbr, upscaleNbr)
```

## Arguments

- nbAll:

  a `integer` representing the total number of samples present in the
  expression matrix.

- permRatio:

  a `numeric` between 0 and 1 representing the number of samples that
  are retained for the permutation step. The rounded value of the number
  of patients multiplied by this `numeric` should be inferior to the
  total number of patients so that the permutation step is not done on
  the entire cohort.

- permNbr:

  a `integer` bigger than or equal to 5 representing the number of
  permutation samplings done.

- upscaleNbr:

  a `integer`, 2 or higher, representing the number of values taken from
  the normal distribution for each sample to run the upscaling step.

## Value

`TRUE` when all parameters are valid

## Author

Astrid Deschênes

## Examples

``` r

## The function returns TRUE when all parameters are valid
splitTypeR:::validateRunSubtypingSubSection(nbAll=15, permRatio=0.8, 
    permNbr=10, upscaleNbr=10)
#> [1] TRUE
```
