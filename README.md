# Reindent test

Test of the effectiveness and correctness of
[autopep8](https://pypi.python.org/pypi/autopep8) for fixing PEP8
violations. By default the target is
[sitescripts](https://hg.adblockplus.org/sitescripts/)
but that can be changed by adjusting `REPO` variable in the makefile.

## Usage

To display the differences between the original and reindented versions
using [pydiff](https://pypi.python.org/pypi/pydiff):

    $ make diff

To display PEP8 statistics of the original and reindented versions:

    $ make pep8

To remove all created files:

    $ make clean

## Notes about pydiff

Pydiff ignores whitespace differences in docstrings (which autopep8 introduces
when it reindents code). However, it detects whitespace differences other strings.

### Patching

Out of the box pydiff can't correctly deal with encoding declarations
in python files. It loads them as unicode and then passes to the compiler
which complains about encoding declarations in already unicode string.

The patch changes it to not decode file content when reading and pass byte
strings to the compiler. With this adjustment it works.