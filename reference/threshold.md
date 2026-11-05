# Generic function for getting the threshold slot in a class

A generic function for getting the threshold slot in a class. The
function is implemented for the `SplitTypeRdata` class.

## Usage

``` r
threshold(x)
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
setClass("MyClass", slots = list(threshold="character"))

# Create an instance
obj <- new("MyClass", threshold="123")

# Call the generic (assuming a method is implemented)
# threshold(obj)
```
