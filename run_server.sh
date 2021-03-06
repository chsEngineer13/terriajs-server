#!/bin/bash
if [ -f "/etc/init.d/varnish" ]; then
    sudo /etc/init.d/varnish restart
fi
date > terriajs-server.log

if [ "`which nohup`" == "" ]; then
    # There's no nohup on Windows. We just run node without it, which is fine in a dev environment.
    (node $(dirname "$0")/lib/app.js "$@" 2>&1 < /dev/null) | tee -a terriajs-server.log &
else
    (nohup node $(dirname "$0")/lib/app.js "$@" 2>&1 < /dev/null) | tee -a terriajs-server.log &
fi

sleep 2
