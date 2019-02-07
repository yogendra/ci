#!/usr/bin/env bash
SCRIPT_DIR=$(cd `dirname $0`; pwd)

CB_ROOT=$SCRIPT_DIR
CB_CONF_DIR=$CB_ROOT/config
CB_CONFIG=$CB_CONF_DIR/cli.ini
CB_WORK_DIR=$CB_ROOT/work
CB_LOGS_DIR=$CB_ROOT/logs
CB_GCP_CREDS=${GCP_CREDS:=$CB_CONF_DIR/google.json}


CERTBOT_OPTS="--config-dir $CB_CONF_DIR --work-dir $CB_WORK_DIR --logs-dir $CB_LOGS_DIR --config=$CB_CONFIG"

[[ ! -d $SCRIPT_WS ]] && mkdir -p $SCRIPT_WS
[[ ! -d $CB_CONF_DIR ]] && mkdir -p $CB_CONF_DIR
[[ ! -d $CB_WORK_DIR ]] && mkdir -p $CB_WORK_DIR
[[ ! -d $CB_LOGS_DIR ]] && mkdir -p $CB_LOGS_DIR
touch $CB_CONFIG


certbot $CERTBOT_OPTS 
