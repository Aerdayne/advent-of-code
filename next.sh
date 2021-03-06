#!/usr/bin/env bash

DIRS=$(ls -d */ | cut -f1 -d'/')
RES=$(echo "$DIRS" | grep [0-9] | sort -rn | head -1)
RES=$((10#$RES + 1))

if [ $RES -lt 10 ]
then
  RES="0$((10#$RES))"
fi

mkdir "$RES"
cp utils/template.rb "$RES"/solution.rb
touch "$RES"/input.txt
