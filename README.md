# Reindent test

Test of the effectiveness and correctness of
[autopep8](https://pypi.python.org/pypi/autopep8) for fixing PEP8
violations. By default it checks all repositories at https://hg.adblockplus.org/
that are not forks of other repos and that contain Python code beyond
`ensure_dependencies.py` (which is updated automatically).

## Usage

To create the virtualenv:

    $ make venv

To check out the repositories, autopep8 them and run the checks:

    $ make checks

To remove all created files except for reports:

    $ make clean

## Notes about pydiff

Pydiff ignores whitespace differences in docstrings (which autopep8 introduces
when it reindents code). However, it detects whitespace differences in other strings.

### Patching

Out of the box pydiff can't correctly deal with encoding declarations
in python files. It loads them as unicode and then passes to the compiler
which complains about encoding declarations in already unicode string.

The patch changes it to not decode file content when reading and pass byte
strings to the compiler. With this adjustment it works.
