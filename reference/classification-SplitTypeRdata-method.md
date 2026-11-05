# Getter for the classification slot in a SplitTypeRdata class

A function for getting the classification slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
classification(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `list` NULL or a list of the classification for each
signature. The list should have one entry per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the model slot for the object
classification(splitData)
#> NULL
```
