# Getter for the standardDeviation slot in a SplitTypeRdata class

A function for getting the standardDeviation slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
standardDeviation(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

`NULL` or a `list` of the sample standard deviation for each signature.
The `list` should have one entry per signature.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the sd slot for the object
standardDeviation(splitData)
#> NULL
```
