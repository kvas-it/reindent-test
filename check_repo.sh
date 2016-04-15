#!/bin/bash

NAME=$1
URL=$2

if [[ $NAME == "" || $URL == "" ]]; then
	echo "Usage: $0 REPO-NAME REPO-URL"
	exit 1
fi

mkdir -p original reindented

ORIGINAL=original/${NAME}
REINDENTED=reindented/${NAME}

if [[ ! -f ${ORIGINAL} ]]; then
	echo ">>> Cloning ${URL} to ${ORIGINAL}"
	hg clone ${URL} ${ORIGINAL}
else
	echo ">>> ${ORIGINAL} is already in place"
fi

if find ${ORIGINAL} -name '*.py' | grep -q -v ensure_dependencies.py; then
	echo ">>> There's python code in ${ORIGINAL}"
else
	echo ">>> No python code in ${ORIGINAL}"
fi

if [[ ! -f ${REINDENTED} ]]; then
	echo ">>> Copying ${ORIGINAL} to ${REINDENTED}"
	cp -r ${ORIGINAL} ${REINDENTED}
	echo ">>> Autopep8ing ${REINDENTED}"
	venv/bin/autopep8 --ignore E501 -ir ${REINDENTED}
else
	echo ">>> ${REINDENTED} is already in place (assume it's autopep8ed)"
fi

echo ">>> pydiff ${ORIGINAL} ${REINDENTED}"
./pydiff.sh ${ORIGINAL} ${REINDENTED}

echo ">>> check for docstring use in ${REINDENTED}"
if grep -nr --include='*.py' __doc__ ${REINDENTED}; then
	echo "!!! WARNING: __doc__ is used in the code (see above)."
fi

echo ">>> PEP8 report for ${ORIGINAL}"
venv/bin/pep8 --statistics -qq ${ORIGINAL}
echo ">>> PEP8 report for ${REINDENTED}"
venv/bin/pep8 --statistics -qq ${REINDENTED}
