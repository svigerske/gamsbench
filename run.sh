#!/bin/sh

# stop on error
set -e

# path the MINLPLib2 GAMS model files
# (download: http://www.gamsworld.org/minlp/minlplib2/minlplib2.zip)
MINLPLIB=/home/stefan/work/gams/minlplib/data/gms

# path to GAMS executable (GAMS >= 24.5 !)
GAMS=/home/stefan/work/gams/gams/gams

TESTSET=test
SOLVERS="ANTIGONE BARON COUENNE LINDO SCIP"
TIMELIMIT=30
GAPLIMIT=0.000001
MEMLIMIT=20000  # usually ignored

# setup .test file for SCIP script
mkdir -p testset
rm -f testset/${TESTSET}.test
for t in `cat ${TESTSET}`
do
  echo "${MINLPLIB}/${t}.gms" >> testset/${TESTSET}.test
done

for s in ${SOLVERS}
do
  SETTINGS=default
  if [ -e settings/${s}.gamsset ]; then
    SETTINGS=${s}
  fi

  echo "Running $s with $SETTINGS settings"
  ./check_gamscluster.sh ${TESTSET} ${GAMS} ${s} ${SETTINGS} "" ${TIMELIMIT} 2100000000 ${MEMLIMIT} ${GAPLIMIT} 1 false no local dummy dummy /tmp 1 true 0

done

awk -f cmpres.awk results/check.${TESTSET}.*res | tee compare.txt

