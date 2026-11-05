# Simulated normalized expected counts for 30 demonstration samples

A small normalized expected gene counts matrix for 30 patients generated
to be used as a demonstration set in this package.

## Usage

``` r
data(expNormalCountsDemo)
```

## Format

a `matrix` containing normalized gene counts for 30 patients (columns).
Only genes related to 2018 Tiriac PDAC PDO classical and basal-like
signatures are present (row).

## Source

Simulated values generated for demonstration purposes. The genes
correspond to the genes of the PDAC patient-derived organoids (PDO)
classical and basal-like signatures published in Tiriac et al. (2018).

## See also

- [runSubtypingBimodal](https://adeschen.github.io/splitTypeR/reference/runSubtypingBimodal.md)
  for the classification of heterogeneous biological samples based on
  gene signature lists using a mixture of two normal distributions

- [getGeneSignaturesNames](https://adeschen.github.io/splitTypeR/reference/getGeneSignaturesNames.md)
  for the names of the available and ready-to-use gene signature lists

- [getGeneSignatures](https://adeschen.github.io/splitTypeR/reference/getGeneSignatures.md)
  for the available and ready-to-use gene signature lists

## Examples

``` r

## Load the demo normalized expected count matrix
data("expNormalCountsDemo")

## Load the demo signatures
data("signaturesDemo")

## Fix seed for reproducibility
set.seed(221)

## Run classification on the 30 patients using 25 permutations on 70% of 
## the cohort, and 10 points per patient for the up-scaling step
results <- runSubtypingBimodal(geneLists=signaturesDemo, 
    expectedCountsMatrix=expNormalCountsDemo, 
    permRatio=0.70, permNbr=25, upscaleNbr=10)
```
