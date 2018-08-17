#!/bin/bash

OUTPUT="tmp.dat"

while getopts "lfgsb:tv:r:o" option; do
  case $option in
    l) LONG="_long"
       111;;
    f) FORCED="_forced";;
    g) GRAPHIC="_graphic";;
    s) SHUTOFF="_shutoff";;
    b) BIAS="_bias_${OPTARG}";;
    t) TEXT="_text";;
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
    o) OUTPUT=$LONG$SHUTOFF$BIAS$FORCED"_"$VALUE"_"$RUN".dat"
       OUTPUT=${OUTPUT:1}
       echo $OUTPUT
  esac
done
echo "./build/default/exp/hexa_supg_hyperneat/hexa_supg_hyperneat${PROGRAM}${LONG}${FORCED}${SHUTOFF}${BIAS}${GRAPHIC}${TEXT} --load orientfb_${VALUE}_$RUN/gen_10000 -o orientfb_${VALUE}_$RUN/$OUTPUT"
./build/default/exp/hexa_supg_hyperneat/hexa_supg_hyperneat${PROGRAM}${LONG}${FORCED}${SHUTOFF}${BIAS}${GRAPHIC}${TEXT} --load orientfb_${VALUE}_$RUN/gen_10000 -o orientfb_${VALUE}_$RUN/$OUTPUT
DIR=$(ls -t -d *GS60*/ | head -1)
echo $DIR
ls -A ${DIR:0:-1}
if [ -z "$(ls -A ${DIR:0:-1})" ]; then
    echo "${DIR:0:-1} is empty "
 else
    echo "${DIR:0:-1} is Not Empty"
    mv ${DIR:0:-1}/* orientfb_${VALUE}_$RUN/cppn_${OUTPUT:0:-4}/
fi
rmdir ${DIR:0:-1}


mv traj_simu.txt orientfb_${VALUE}_$RUN/traj_simu_${OUTPUT:0:-4}.txt
mv performance_metrics.dat orientfb_${VALUE}_$RUN/performance_metrics_${OUTPUT}
mv contact_simu.txt orientfb_${VALUE}_$RUN/contact_simu_${OUTPUT:0:-4}.txt
