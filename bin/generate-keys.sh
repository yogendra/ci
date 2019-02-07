#!/usr/bin/env bash

SCRIPT_DIR=$(cd `dirname $0`; pwd)
PROJECT_DIR=$(cd $SCRIPT_DIR/..; pwd)
WEB_DIR=$PROJECT_DIR/concourse-web
WORKER_DIR=$PROJECT_DIR/concourse-worker

set -e -u -x

# check if we should use the old PEM style for generating the keys
# --------
# check: https://www.openssh.com/txt/release-7.8

PEM_OPTION='-m PEM'


# generate the keys
# --------

mkdir -p $WEB_DIR/keys $WORKER_DIR/keys

yes | ssh-keygen $PEM_OPTION -t rsa -f $WEB_DIR/keys/tsa_host_key -N ''
yes | ssh-keygen $PEM_OPTION -t rsa -f $WEB_DIR/keys/session_signing_key -N ''

yes | ssh-keygen $PEM_OPTION -t rsa -f $WORKER_DIR/keys/worker_key -N ''

cp $WORKER_DIR/keys/worker_key.pub $WEB_DIR/keys/authorized_worker_keys
cp $WEB_DIR/keys/tsa_host_key.pub $WORKER_DIR/keys
