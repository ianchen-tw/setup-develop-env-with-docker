#! /usr/bin/env python3

# This dockerfile is intended to be used by students
import sys
import subprocess
import pathlib
import argparse
from pathlib import Path
import os

assert sys.version_info >= (3, 4)

parser = argparse.ArgumentParser(
    description='Activate homework environment for compiler-s20')
parser.add_argument( '-t','--test-src-fld',
                    nargs=1,
                    default=[None],
                    help="Append different test folder")
args = parser.parse_args()
test_src_fld = args.test_src_fld[0]

dirpath = os.path.dirname(os.path.abspath(__file__))

DOCKER_USER_NAME = 'yian'
DOCKER_HOST_NAME = 'docker-env'
DOCKER_IMG_NAME = 'my-test-env'

dk_home = f'home/{DOCKER_USER_NAME}'

def main():
    # print(f'dirpath :{dirpath}')
    cwd = os.getcwd()

    bash_his = Path(f'{dirpath}/.history/docker_bash_history')
    bash_his.parent.mkdir(exist_ok=True)
    bash_his.touch(exist_ok=True)

    if test_src_fld and not Path(test_src_fld).exists():
        raise FileNotFoundError(f"Folder: `{test_src_fld}` doesnt exist.")

    docker_options = [
        'docker', 'run',
        '--rm', '-it',
        '--hostname', DOCKER_HOST_NAME,
        '-e', f'LOCAL_USER_ID={os.getuid()}',
        '-e', f'LOCAL_USER_GID={os.getgid()}',
        '-v', f'{os.getcwd()}:/home/{DOCKER_USER_NAME}',
        f'-v {os.path.abspath(test_src_fld)}:/{dk_home}/test' if test_src_fld else '',

        # bash history file
        '-v', f'{dirpath}/.history/docker_bash_history:/{dk_home}/.bash_history',
        DOCKER_IMG_NAME,
    ]
    os.system(' '.join(docker_options))


if __name__ == "__main__":
    main()
