#!/bin/bash -eu

echo "*** Calling SV using BreakSeq: $BREAKSEQ ***"

if [ $# -lt 2 ]
then
	echo "Usage: $0 <output> <bam>..."
	exit 1
fi

output=`cd \`dirname $1\`; pwd`/`basename $1`
shift

bams=''
for i in $*
do
        bams="$bams `cd \`dirname $i\`; pwd`/`basename $i`"
done

echo ">> Invoking the BreakSeq (Lite) program (Library: $BPLIB)"
$BREAKSEQ/bin/breakseq $output $bams

if [ -e "${output}.2" ]
then
	rm ${output}.2
fi
sort -k1,1 -k4n -k5n < $output >> ${output}.2
mv ${output}.2  $output

echo "*** Finished Calling SV using BreakSeq ***"
