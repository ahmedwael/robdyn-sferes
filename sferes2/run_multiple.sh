#!/bin/bash

while getopts "ap:lfqgsb:ntv:" option; do
  case $option in
    a) A=" -a";;
    p) if [ "${OPTARG}" = "o" ]
        then
          P=" -p o"
       else
         if [ "${OPTARG}" = "a" ]
          then
            P=" -p a"
         else
           if [ "${OPTARG}" = "pn" ]
            then
              P=" -p pn"
           else
              P=" -p t"
          fi
        fi
      fi;;
    l) L=" -l";;
    f) F=" -f";;
    q) Q=" -q";;
    g) G=" -g";;
    s) S=" -s";;
    b) B=" -b ${OPTARG}";;
    n) N=" -n";;
    t) T=" -t";;
    v) if [ "${OPTARG}" = "0" ]
        then
          V=" -v 0"
       else
         if [ "${OPTARG}" = "180" ]
          then
            V=" -v 180"
         else
            V=" -v ${OPTARG}"
        fi
      fi;;
  esac
done

i="0"
# R=" -r 1"
while [ $i -lt 10 ]
do
# E=" -e $i"
R=" -r $i"
echo "./run_exp.sh$E$A$P$L$F$G$S$B$T$N$V$R"
./run_exp.sh$E$A$P$L$F$Q$G$S$B$N$T$V$R
i=$[$i+1]
done
