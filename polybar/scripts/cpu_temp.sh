#!/bin/bash
TMP=$(sensors | grep -oP 'Tdie.*?\+\K[0-9.]+')
echo $TMP\C°
