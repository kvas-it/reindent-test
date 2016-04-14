#!/bin/bash

for i in `find $1 -name '*.py'`
do
	j=$2/${i#$1/}
	venv/bin/pydiff $i $j
done
