# Create a SplitTypeRdata object

This function creates a SplitTypeRdata object using the values present
in the parameters.

## Usage

``` r
SplitTypeRdata(
  signatures = NULL,
  gsvaResults = NULL,
  permutations = NULL,
  standardDeviation = NULL,
  upscaling = NULL,
  model = NULL,
  threshold = NULL,
  classification = NULL
)
```

## Arguments

- signatures:

  `NULL` or a `list` of the genes for each signature. The `list` should
  have one entry per signature. Default: `NULL`.

- gsvaResults:

  `NULL` or a `matrix` of the GSVA results for each signature. The
  `matrix` should have one row per signature. Default: `NULL`.

- permutations:

  `NULL` or a `list` of the permutations results for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

- standardDeviation:

  `NULL` or a `list` of the standard deviation results for each
  signature. The `list` should have one entry per signature. Default:
  `NULL`.

- upscaling:

  `NULL` or a `list` of the upscaling data for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

- model:

  `NULL` or a `list` of the mixture models calculated for each
  signature. The `list` should have one entry per signature. Default:
  `NULL`.

- threshold:

  `NULL` or a `list` of the classification thresholds for each
  signature. The `list` should have one entry per signature. Default:
  `NULL`.

- classification:

  `NULL` or a `list` of the classification for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

## Value

an object of class `SplitTypeRdata` that contains all the required
parameters needed by the RAIDS workflow.

## Author

Astrid Deschênes

## Examples

``` r

## New object of class "SplitTypeRdata" with default parameters
newSplitData1 <- SplitTypeRdata()

## New object of class "SplitTypeRdata" with non-default parameters
newSplitData2 <- SplitTypeRdata(signatures=list("Signature1"=c("ABL1", 
    "BLM", "BRCA1"), "Signature2"=c("COP1", "RAD50", "FANCD2", "TERF2")), 
    gsvaResults=NULL, permutations=NULL,   
    standardDeviation=NULL, upscaling=NULL, model=NULL, threshold=NULL,
    classification=NULL)
```
