#!/bin/bash
set -e

# First command line argument gives prefix of the language. 'no' for
# Norwegian wikipedia

PREFIX=${1}
echo "Prefix for language in wikipedia $PREFIX"
FILENAME=${PREFIX}wiki-latest-pages-articles.xml.bz2
if [ ! -f ${FILENAME} ]; then
    echo "File not found: ${FILENAME}. Downloading..."
    WIKILINK="http://download.wikimedia.org/${PREFIX}wiki/latest/${FILENAME}"
    echo Wikipedia download link: ${WIKILINK}
    wget ${WIKILINK}
fi
XMLFILE="${FILENAME%.*}"
if [ ! -f ${XMLFILE} ]; then
    echo "File not found: ${XMLFILE}. bzunzip2ing..."
    bunzip2 --keep ${FILENAME}
    #wget ${WIKILINK}
fi

TXTWIKI="${XMLFILE%.*}".txt
echo $TXTWIKI

if [ ! -f ${TXTWIKI} ]; then
    echo "File not found: ${TXTWIKI}. Running wikipedia extractor"
    python wikiextractor/WikiExtractor.py -o - ${XMLFILE} > ${TXTWIKI}
    #wget ${WIKILINK}
fi

TXTWIKILOWER="${XMLFILE%.*}"_lower.txt
if [ ! -f ${TXTWIKILOWER} ]; then
    echo "File not found: ${TXTWIKILOWER}. Lowercasing..."
    tr '[:upper:]' '[:lower:]' < ${TXTWIKI} > ${TXTWIKILOWER}
    #wget ${WIKILINK}
fi

WIKICLEAN="${XMLFILE%.*}"_clean.txt
if [ ! -f ${WIKICLEAN} ]; then
    echo "File not found: ${WIKICLEAN}. Cleaning..."
    python3 stripdoctag.py ${TXTWIKILOWER} ${WIKICLEAN}
    #wget ${WIKILINK}
fi
