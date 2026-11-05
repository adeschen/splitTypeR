# Generic function for replacement of threshold slot in a class

A generic function for replacement of threshold slot in a S4 object.

## Usage

``` r
threshold(x) <- value
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
setClass("MyClass", slots = list(threshold="character"))

# Create an instance
obj <- new("MyClass", threshold="123")

# Call the generic (assuming a method is implemented)
# threshold(obj) <- "333"
```
