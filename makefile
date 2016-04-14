.PHONY: clean diff pep8

REPO=abpbot
URL="https://hg.adblockplus.org/${REPO}/"

ORIGINAL=original/${REPO}
REINDENTED=reindented/${REPO}

venv:
	virtualenv venv
	venv/bin/pip install pep8 autopep8 pydiff
	patch -p1 <pydiff.patch
	rm -f venv/lib/python2.7/site-packages/pydiff.pyc # To recompile.

${ORIGINAL}:
	mkdir -p original
	hg clone ${URL} ${ORIGINAL}

${REINDENTED}: ${ORIGINAL} venv
	mkdir -p reindented
	cp -r ${ORIGINAL} ${REINDENTED}
	venv/bin/autopep8 -ir ${REINDENTED}

diff: ${ORIGINAL} ${REINDENTED}
	./pydiff.sh ${ORIGINAL} ${REINDENTED}

pep8: ${ORIGINAL} ${REINDENTED}
	@echo "PEP8 violations in ${ORIGINAL}:"
	@venv/bin/pep8 --statistics -qq ${ORIGINAL} | cat
	@echo "PEP8 violations in ${REINDENTED}:"
	@venv/bin/pep8 --statistics -qq ${REINDENTED} | cat

clean:
	rm -Rf original reindented venv
