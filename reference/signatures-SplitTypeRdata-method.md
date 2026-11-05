# Getter for the signatures slot in a SplitTypeRdata class

A function for getting the signatures slot in a `SplitTypeRdata` class.

## Usage

``` r
# S4 method for class 'SplitTypeRdata'
signatures(x)
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

## Extract the signature slot for the object
signatures(splitData)
#> NULL
```
