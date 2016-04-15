#!/usr/bin/env python

"""Run the checks on all the repos according to repos.conf."""

import ConfigParser
import subprocess


if __name__ == '__main__':
    config = ConfigParser.ConfigParser()
    config.read(['repos.conf'])
    for name, url in config.items('repos'):
        print '>>> Running checks on {} at {}'.format(name, url)
        cmd = './check_repo.sh {0} {1} | tee reports/{0}.txt'.format(name, url)
        print '>>> {}'.format(cmd)
        subprocess.call(cmd, shell=True)
