# Validate parameters for the plotPermutationSamplesNormal() function

This function validates the parameters for the
plotPermutationSamplesNormal function. When a parameter is incorrect, a
message is sent to the user before quitting the program.

## Usage

``` r
validatePlotPermutationSamplesNormal(x, signature, samples, pointColor)
```

## Arguments

- x:

  a `list` of class "splitTypeResults", the output object from
  `runSubtyping`function, to be graphed.

- signature:

  a `character` string representing the signature that will be used to
  create the graph. The signature must be present in the object.

- samples:

  a `list` of `character` string representing the names of the samples
  that will be used to create the graph. The samples must be present in
  the object.

- pointColor:

  a `character` string representing the color of the dots representing
  the enrichment scores for the sampled values, obtained during the
  upscaling step, in the graph.

## Value

`TRUE` when all parameters are valid

## Author

Astrid Deschênes

## Examples

``` r

## Loading signatures
data("signaturesDemo")

## Load demo normalized expected counts for 30 patients
data("expNormalCountsDemo")

## Fix seed for reproducibility
set.seed(1221)

## Run classification on the 30 patients using 10 permutations on 75% of 
## the dataset, and 10 points per patient for the up-scaling step
results <- runSubtypingBimodal(geneLists=signaturesDemo, 
    expectedCountsMatrix=log2(expNormalCountsDemo + 1), 
    permRatio=0.75, permNbr=10, upscaleNbr=5)
    
## Validation should return TRUE when all parameters are valid
splitTypeR:::validatePlotPermutationSamplesNormal(x=results, 
    signature="Basal-like", samples=c("Patient_9", "Patient_25"), 
    pointColor="black")
#> [1] TRUE

```
