# Generic function for getting the signatures slot in a class

A generic function for getting the signatures slot in a class. The
function is implemented for the `SplitTypeRdata` class.

## Usage

``` r
signatures(x)
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
setClass("MyClass", slots = list(signatures="character"))

# Create an instance
obj <- new("MyClass", signatures="123")

# Call the generic (assuming a method is implemented)
# signatures(obj)
```
