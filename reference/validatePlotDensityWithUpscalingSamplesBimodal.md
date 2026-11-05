# Validate parameters for the plotDensityWithUpscalingSamplesBimodal() function

This function validates the parameters for the
plotDensityWithUpscalingSamplesBimodal function. When a parameter is
incorrect, a message is sent to the user before quitting the program.

## Usage

``` r
validatePlotDensityWithUpscalingSamplesBimodal(
  x,
  signature,
  breaks,
  colorSignature,
  colorAlternative,
  colorBorderSamples,
  colorFillingSamples
)
```

## Arguments

- x:

  a "SplitTypeRdata" object, the output object from
  `runSubtyping`function, to be graphed.

- signature:

  a `character` string representing the signature that will be used to
  create the graph. The signature must be present in the object.

- breaks:

  a single `integer` value giving the number of cells for the histogram,

- colorSignature:

  a `character` string representing the color of the signature
  distribution curve.

- colorAlternative:

  a `character` string representing the color of the alternative
  distribution curve.

- colorBorderSamples:

  a `character` string representing the color of the histogram border
  for the sample distribution.

- colorFillingSamples:

  a `character` string representing the color of the histogram filling
  for the sample distribution.

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
    expectedCountsMatrix=expNormalCountsDemo, 
    permRatio=0.75, permNbr=10, upscaleNbr=5)
    
## Validation should return TRUE when all parameters are valid
splitTypeR:::validatePlotDensityWithUpscalingSamplesBimodal(x=results, 
    signature="Classical", colorSignature="blue", colorAlternative="red", 
    colorBorderSamples="gray20", colorFillingSamples="black")
#> [1] TRUE

```
