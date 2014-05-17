#!/bin/bash

THE_PID=$(ps auxww | grep node | grep -v grep | awk '{print $2}')
kill ${THE_PID}
