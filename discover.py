#!/usr/bin/env python

"""Discover repository names and URLs from a page."""

import re
import urllib2

ROOT = 'https://hg.adblockplus.org/'


def get_html(url):
    response = urllib2.urlopen(url)
    return response.read()


def get_repos(root):
    html = get_html(root)
    href_regexp = re.compile(r'href=[\'"]([^\'"]+)[\'"]', re.I)
    for url in href_regexp.findall(html):
        name = url.strip('/')
        if '/' not in name:
            yield name, ROOT + name


if __name__ == '__main__':
    print '[repos]'
    for name, url in get_repos(ROOT):
        print '{} = {}'.format(name, url)
