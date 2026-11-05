# Transcriptomic classification using multimodal distributions

The `splitTypeR` package provides an automated statistical framework for
classifying heterogeneous biological samples based on gene signature
lists, effectively isolating signature-positive samples. This
classification method is designed for bulk transcriptomic datasets.

## Details

The workflow begins by calculating a Gene Set Variation Analysis (GSVA)
score for each sample to quantify the relative pathway activity. A
subsequent permutation step extracts sample-specific standard deviations
to capture the variance. By combining these metrics, the package
establishes a unique normal distribution for each sample. Through an
up-scaling step, values are randomly drawn from these individual
distributions and pooled to construct a comprehensive mixture of normal
distributions that represent the entire sample population.

Within this mixture model, the sub-distribution with the lower mean
value is designated as the alternative distribution. The framework
applies a hypothesis-testing approach in which the null hypothesis
posits that a sample belongs to this alternative distribution. Samples
that successfully reject the null hypothesis are assigned to the
signature classification. Conversely, samples that fail to reject the
null hypothesis remain unclassified.

By automating the classification workflow, the `splitTypeR` package
provides an objective method to identify patient or sample subgroups in
heterogeneous transcriptomic datasets.

## See also

- [runSubtypingBimodal](https://adeschen.github.io/splitTypeR/reference/runSubtypingBimodal.md)
  for the classification of heterogeneous biological samples based on
  gene signature lists using a mixture of two normal distributions

- [getGeneSignaturesNames](https://adeschen.github.io/splitTypeR/reference/getGeneSignaturesNames.md)
  for the names of the available and ready-to-use gene signature lists

- [getGeneSignatures](https://adeschen.github.io/splitTypeR/reference/getGeneSignatures.md)
  for the available and ready-to-use gene signature lists

## Author

Astrid Deschênes, Pascal Belleau

Maintainer: Astrid Deschênes \<adeschen@hotmail.com\>
