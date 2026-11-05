# Generic function for getting the permutations slot in a class

A generic function for getting the permutations slot in a class. The
function is implemented for the `SplitTypeRdata` class.

## Usage

``` r
permutations(x)
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
setClass("MyClass", slots = list(permutations="character"))

# Create an instance
obj <- new("MyClass", permutations="123")

# Call the generic (assuming a method is implemented)
# permutations(obj)
```
