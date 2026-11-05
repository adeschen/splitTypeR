# Getter for the upscaling slot in a SplitTypeRdata class

A function for getting the upscaling slot in a `SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
upscaling(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `list` of the upscaling data for each signature. The `list`
should have one entry per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the upscaling slot for the object
upscaling(splitData)
#> NULL
```
