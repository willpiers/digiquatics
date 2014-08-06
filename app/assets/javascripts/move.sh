#!/bin/bash

for i in `ls ./**/*-*`
do
NEW=`echo $i|tr '_' '-'`
mv $i $NEW
done
