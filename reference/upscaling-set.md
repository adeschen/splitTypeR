# Generic function for replacement of the upscaling slot in a class

A generic function for replacement of the upscaling slot in a S4 object.

## Usage

``` r
upscaling(x) <- value
```

## Arguments

- x:

  a S4 object.

- value:

  the new value to assign or update.

## Value

the modified S4 object when the new value is valid.

## Author

Astrid Deschênes

## Examples

``` r
 
# Define a dummy class to show usage
setClass("MyClass", slots = list(upscaling="character"))

# Create an instance
obj <- new("MyClass", upscaling="123")

# Call the generic (assuming a method is implemented)
# upscaling(obj) <- "333"
```
