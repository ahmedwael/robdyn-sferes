#!/bin/bash

while getopts "p:lfqgsb:ntv:r:" option; do
  case $option in
    p) if [ "${OPTARG}" = "o" ]
        then
          FILE="orientfb"
       else
         if [ "${OPTARG}" = "a" ]
          then
            FILE="angled"
         else
           if [ "${OPTARG}" = "pn" ]
            then
              FILE="angled_pn"
           else
              FILE="torque"
          fi
        fi
      fi;;
    l) LONG="_long";;
    f) FORCED="_forced";;
    q) TORQUE="_torque";;
    g) GRAPHIC="_graphic";;
    s) SHUTOFF="_shutoff";;
    b) BIAS="_bias_${OPTARG}";;
    n) NEGATIVE="_negative";;
    t) TEXT="_ologs_text";;
    v) if [ "${OPTARG}" = "0" ]
        then
          PROGRAM=""
          VALUE="none"
       else
         if [ "${OPTARG}" = "180" ]
          then
            PROGRAM="_orientfb"
            VALUE="180"
         else
            PROGRAM="_ofbv${OPTARG}_orientfb"
            VALUE=${OPTARG}
        fi
      fi;;
    r) RUN=${OPTARG};;
  esac
done
OUTPUT=$LONG$FORCED$SHUTOFF$BIAS$TORQUE$NEGATIVE$"_"$VALUE"_"$RUN
OUTPUT=${OUTPUT:1}
echo $OUTPUT
# $LONG$SHUTOFF$BIAS$FORCED
echo "./build/default/exp/hexa_supg_hyperneat/hexa_supg_hyperneat${PROGRAM}${LONG}${FORCED}${SHUTOFF}${BIAS}${TORQUE}${NEGATIVE}${GRAPHIC}${TEXT} --load ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/gen_10000 -o ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/$OUTPUT.dat -n 0"
./build/default/exp/hexa_supg_hyperneat/hexa_supg_hyperneat${PROGRAM}${LONG}${FORCED}${SHUTOFF}${BIAS}${TORQUE}${NEGATIVE}${GRAPHIC}${TEXT} --load ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/gen_10000 -o ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/$OUTPUT.dat -n 0
DIR=$(ls -t -d *GS60*/ | head -1)
echo $DIR
ls -A ${DIR}
if [ -z "$(ls -A ${DIR})" ]; then
    echo "${DIR:0:-1} is empty "
 else
    echo "${DIR:0:-1} is Not Empty"
    echo "mv ${DIR:0:-1}/* ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/cppn/"
    mkdir ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/cppn/
    mv ${DIR:0:-1}/* ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/cppn/
fi
rmdir ${DIR:0:-1}


mv traj_simu_1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/traj_simu_1_${OUTPUT}.txt
mv performance_metrics.dat ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/performance_metrics_${OUTPUT}.dat
mv contact_simu_1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/contact_simu_1_${OUTPUT}.txt
mv orientation_simu_1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/orientation_simu_1_${OUTPUT}.txt

# mv traj_simu_-1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/traj_simu_-1_${OUTPUT}.txt
# mv contact_simu_-1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/contact_simu_-1_${OUTPUT}.txt
# mv orientation_simu_-1.txt ${FILE}/${FILE}_${VALUE}/${FILE}_${VALUE}_$RUN/orientation_simu_-1_${OUTPUT}.txt
