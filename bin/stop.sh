#!/bin/bash

THE_PID=$(ps auxww | grep node | grep index.js | grep -v grep | awk '{print $2}')
kill ${THE_PID}
