#!/bin/bash
# if [ "$1" = "0" ]
# then
#  PROGRAM=""
#  VALUE="none"
# else
#  if [ "$1" = "180" ]
#  then
#    PROGRAM="_orientfb"
#    VALUE="180"
#  else
#    PROGRAM="_ofbv$1_orientfb"
#    VALUE=$1
#  fi
# fi

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
