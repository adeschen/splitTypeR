# Getter for the model slot in a SplitTypeRdata class

A function for getting the model slot in a `SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
model(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `list` of the mixture models calculated for each signature.
The `list` should have one entry per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the model slot for the object
model(splitData)
#> NULL
```
