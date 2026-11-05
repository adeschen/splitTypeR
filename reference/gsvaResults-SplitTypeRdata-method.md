# Getter for the signatures slot in a SplitTypeRdata class

A function for getting the gsvaResults slot in a `SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
gsvaResults(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `matrix` of the GSVA results for each signature. The
`matrix` should have one entry per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the gsvaResults slot for the object
gsvaResults(splitData)
#> NULL
```
