# Generic function for getting the standardDeviation slot in a class

A generic function for getting the standardDeviation slot in a class.
The function is implemented for the `SplitTypeRdata` class.

## Usage

``` r
standardDeviation(x)
```

## Arguments

- x:

  an object.

## Value

an object.

## Author

Astrid Deschênes

## Examples

``` r

# Define a dummy class to show usage
setClass("MyClass", slots = list(standardDeviation="character"))

# Create an instance
obj <- new("MyClass", standardDeviation="123")


```
