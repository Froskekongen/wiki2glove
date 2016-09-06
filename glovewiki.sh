#!/bin/bash
set -e

cd GloVe
make


PREFIX=${1}
VECSIZE=${2}
FILENAME=${PREFIX}wiki-latest-pages-articles.xml.bz2
XMLFILE="${FILENAME%.*}"
WIKICLEAN="${XMLFILE%.*}"_clean.txt
if [ ! -f ../${WIKICLEAN} ]; then
    echo "File not found: ${WIKICLEAN}. Exiting"
    exit 1
    #wget ${WIKILINK}
fi

PREFIX2=_wiki_${PREFIX}_${VECSIZE}

CORPUS=../${WIKICLEAN}
VOCAB_FILE=vocab${PREFIX2}.txt
COOCCURRENCE_FILE=cooccurrence${PREFIX2}.bin
COOCCURRENCE_SHUF_FILE=cooccurrence${PREFIX2}.shuf.bin
BUILDDIR=build
SAVE_FILE=vectors${PREFIX2}
VERBOSE=2
MEMORY=4.0
VOCAB_MIN_COUNT=5
VECTOR_SIZE=${VECSIZE}
MAX_ITER=15
WINDOW_SIZE=15
BINARY=2
NUM_THREADS=8
X_MAX=10

echo "$ $BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE"
$BUILDDIR/vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $CORPUS > $VOCAB_FILE
echo "$ $BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE"
$BUILDDIR/cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $CORPUS > $COOCCURRENCE_FILE
echo "$ $BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE"
$BUILDDIR/shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE
echo "$ $BUILDDIR/glove -save-file $SAVE_FILE -threads $NUM_THREADS -input-file $COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE"
$BUILDDIR/glove -save-file $SAVE_FILE -threads $NUM_THREADS -input-file $COOCCURRENCE_SHUF_FILE -x-max $X_MAX -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE
