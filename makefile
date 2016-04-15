.PHONY: clean all

all: venv
	mkdir -p reports
	python all_repos.py

venv:
	virtualenv venv
	venv/bin/pip install pep8 autopep8 pydiff
	patch -p1 <pydiff.patch
	rm -f venv/lib/python2.7/site-packages/pydiff.pyc # To recompile.

clean:
	rm -Rf original reindented venv
