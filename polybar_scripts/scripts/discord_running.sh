#!/bin/bash

OUTPUT=$(pidof Discord)

if [ ${#OUTPUT} -ge 5 ]; then return 1
else return 0
fi
