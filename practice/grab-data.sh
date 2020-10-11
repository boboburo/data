#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo $DIR

curl "https://data.nasa.gov/resource/y77d-th95.json" | \
    sqlite-utils insert practice.db meteorites - | \
    echo here are the list of files
    ls -atlh practice/ 
