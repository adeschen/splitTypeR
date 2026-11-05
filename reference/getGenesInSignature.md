# Return the genes for a specific signature

The function returns the genes for the selected signature.

## Usage

``` r
getGenesInSignature(name)
```

## Arguments

- name:

  a `character` string representing the name of the signature names. The
  signature name must all be present in the gene list signatures.

## Value

a `list` of genes associated to a specific signature.

## Details

The PDAC PDO classical and basal-like signatures are associated with
this publication:

Tiriac et al. Organoid Profiling Identifies Common Responders to
Chemotherapy in Pancreatic Cancer. Cancer Discov. 2018
Sep;8(9):1112-1129. doi: 10.1158/2159-8290.CD-18-0349. Epub 2018 May 31.
PMID: 29853643; PMCID: PMC6125219.

## Author

Astrid Deschênes

## Examples

``` r

## Extract the genes for the basal-like signature from Tiriac et al 2018
getGenesInSignature(name="Tiriac_PDAC_PDO_Basal_like")
#>  [1] "ANO1"     "ADORA2B"  "S100A2"   "CSF2"     "ANXA1"    "EREG"    
#>  [7] "RGS20"    "CELSR1"   "WNT7B"    "AMIGO2"   "PTHLH"    "C12orf54"
#> [13] "TGM2"     "REEP3"    "DCBLD2"   "NMB"      "IKZF2"    "GPR87"   
#> [19] "MUC16"    "IVL"      "SPRR1B"   "BCAR3"    "TTC9"     "PTGES"   
#> [25] "CST6"     "CATSPER1"
```
