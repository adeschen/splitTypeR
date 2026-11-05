# Generic function for replacement of standardDeviation slot in a class

A generic function for replacement of standardDeviation slot in a S4
object.

## Usage

``` r
standardDeviation(x) <- value
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
setClass("MyClass", slots = list(standardDeviation="character"))

# Create an instance
obj <- new("MyClass", standardDeviation="123")

# Call the generic (assuming a method is implemented)
# standardDeviation(obj) <- "333"
```
