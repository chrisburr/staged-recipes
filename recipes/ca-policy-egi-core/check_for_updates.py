#!/usr/bin/env python
from __future__ import print_function

import argparse
import requests
import sys

from pkg_resources import parse_version

anaconda_api = 'https://api.anaconda.org/package/conda-forge'
igtf_url = 'https://dl.igtf.net/distribution/igtf/current/version.txt'
package_name = 'ca-policy-egi-core'
current_version = parse_version('###CURRENT_VERSION###')


def log(*args, **kwargs):
    """
    Only log output if running as a module or --debug is passed
    """
    if debug_output:
        print(*args, **kwargs)


def exit():
    """
    If running as a module or --debug is passed raise an exception
    else exit silently.
    """
    if debug_output:
        raise RuntimeError('Error occurred while checking for updates')
    else:
        sys.exit()


def https_get(url):
    try:
        response = requests.get(anaconda_api+'/'+package_name, timeout=1)
    except requests.ConnectTimeout:
        log('Failed to access', url, 'due to connection timeout')
        exit()

    if not response.ok:
        log('Got error code ', response.status_code, 'from', url)
        log(response.text)
        exit()

    return response


def check_for_updates():
    response = https_get(igtf_url, timeout=1)
    latest_version = parse_version(response.text.strip().split()[-1])
    log('Got version', repr(latest_version), 'from', repr(response.text))

    if current_version == latest_version:
        log('Already using the latest version')
        return

    response = https_get(anaconda_api+'/'+package_name, timeout=1)
    available_versions = [parse_version(v) for v in response.json()['versions']]
    log('Found versions from anaconda.org:', available_versions)

    if latest_version in available_versions:
        sys.stderr.write(
            'WARNING: Currently using ' + package_name + ' version ' +
            str(current_version) + ' but ' + str(latest_version) +
            ' is available. To ensure continued grid access please run:\n' +
            '    conda update '+package_name)
    else:
        log('WARNING: The latest version from IGTF is', latest_version,
            'but conda-forge only has', sorted(available_versions))


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--debug', action='store_true')
    args = parser.parse_args()
    debug_output = args.debug

    check_for_updates()
else:
    debug_output = True