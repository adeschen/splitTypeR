# An S4 class to represent the splitTypeR data

An S4 class to represent the splitTypeR data

## Slots

- `signatures`:

  `NULL` or a `list` of the genes for each signature. The `list` should
  have one entry per signature. Default: `NULL`.

- `gsvaResults`:

  `NULL` or a `numeric` `matrix` with the sample GSVA results for each
  signature. The `matrix` should be have one row per signature. Default:
  `NULL`.

- `permutations`:

  `NULL` or a `list` of the permutations results for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

- `standardDeviation`:

  `NULL` or a `list` of the sample standard deviation for each
  signature. The `list` should have one entry per signature. Default:
  `NULL`.

- `upscaling`:

  `NULL` or a `list` of the upscaling data for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

- `model`:

  `NULL` or a `list` of the mixture models calculated for each
  signature. The `list` should have one entry per signature. Default:
  `NULL`.

- `threshold`:

  `NULL` or a `list` of the classification thresholds for each
  signature. The threshold corresponds to the 95th percentile of the
  "low-mean" distribution of the mixture model. The `list` should have
  one entry per signature. Default: `NULL`.

- `classification`:

  `NULL` or a `list` of the classification for each signature. The
  `list` should have one entry per signature. Default: `NULL`.

## Author

Astrid Deschênes
