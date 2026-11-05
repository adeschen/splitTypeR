# Getter for the signatures slot in a SplitTypeRdata class

A function for getting the permutations slot in a `SplitTypeRdata`
class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
permutations(x)
```

## Arguments

- x:

  a `SplitTypeRdata` object.

## Value

a `list`.

## Author

Astrid Deschênes

## Examples

``` r

## Create a SplitTypeRdata object
splitData <- SplitTypeRdata()

## Extract the permutations slot for the object
permutations(splitData)
#> NULL
```
