# Generic function for getting the upscaling slot in a class

A generic function for getting the upscaling slot in a class. The
function is implemented for the `SplitTypeRdata` class.

## Usage

``` r
upscaling(x)
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
setClass("MyClass", slots = list(upscaling="character"))

# Create an instance
obj <- new("MyClass", upscaling="123")

# Call the generic (assuming a method is implemented)
# upscaling(obj)
```
