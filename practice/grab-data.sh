curl "https://data.nasa.gov/resource/y77d-th95.json" | \
    sqlite-utils insert practice.db meteorites - | \
    echo here are the list of files
    ls -atlh practice/ 
