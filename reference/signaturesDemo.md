# Demonstration gene signatures for PDAC subtyping

A short collection of published gene signatures that primarily focuses
on PDAC classification for patient-derived organoids (PDO). While the
signatures are accurate, this list is mainly compiled for demonstration
purposes.

## Usage

``` r
data(signaturesDemo)
```

## Format

a `list` containing one entry per signature:

- `"Classical"`: a `vector` of gene names associated to the PDAC
  Patient-derived Organoid (PDO) Classical signature as published in
  Tiriac et al 2018

- `"Basal-like"`: a `vector` of gene names associated to the PDAC
  Patient-derived Organoid (PDO) Basal-like signature as published in
  Tiriac et al 2018

## Source

Tiriac H, Belleau P, Engle DD, et al. Organoid Profiling Identifies
Common Responders to Chemotherapy in Pancreatic Cancer. Cancer Discov.
2018;8(9):1112-1129. doi:10.1158/2159-8290.CD-18-0349

## Details

The PDAC patient-derived organoids (PDO) classical and basal-like
signatures are associated with this publication:

Tiriac et al. Organoid Profiling Identifies Common Responders to
Chemotherapy in Pancreatic Cancer. Cancer Discov. 2018
Sep;8(9):1112-1129. doi: 10.1158/2159-8290.CD-18-0349. Epub 2018 May 31.
PMID: 29853643; PMCID: PMC6125219.

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

## Load the published signature gene list
data(signaturesDemo)

```
