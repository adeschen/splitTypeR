# List the names of the available signatures

The function lists the names of all the available signatures.

## Usage

``` r
getGeneSignaturesNames()
```

## Value

a `vector` of available signature names

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

## Print the names of the available signatures
getGeneSignaturesNames()
#> [1] "Tiriac_PDAC_PDO_Basal_like" "Tiriac_PDAC_PDO_Classical" 
#> [3] "Moffitt_Basal_like"         "Moffitt_Classical"         
#> [5] "Miyabayashi_Fast"           "Miyabayashi_Slow"          
```
