#!/bin/bash

while getopts "lfgsb:tv:o" option; do
  case $option in
    l) L=" -l";;
    f) F=" -f";;
    g) G=" -g";;
    s) S=" ";;
    b) B=" -b ${OPTARG}";;
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
    o) O=" -o"
  esac
done

i="0"
while [ $i -lt 10 ]
do
R=" -r $i"
echo "./run_exp.sh$L$F$G$S$B$T$V$R$O"
./run_exp.sh$L$F$G$S$B$T$V$R$O
i=$[$i+1]
done
