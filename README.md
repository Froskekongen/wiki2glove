# wiki2glove
Simple workflow to generate glove vectors from a wikipedia dump

## Usage
```
parsewiki.sh language_prefix
```

This downloads and parses wikipedia into a format that GloVe can use. Example:
```
parsewiki.sh no
```
for Norwegian wikipedia.

Then do:
```
glovewiki.sh language_prefix vector_size
```
Here language_prefix is as above, and vector_size determines the dimensionality of the glove-vectors.
