# Getter for the threshold slot in a SplitTypeRdata class

A function for getting the threshold slot in a `SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
threshold(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `list` of the classification thresholds for each signature.
The threshold corresponds to the 95th percentile of the "low-mean"
distribution of the mixture model. The `list` should be have one entry
per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the threshold slot for the object
threshold(splitData)
#> NULL
```
