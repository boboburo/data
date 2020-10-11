curl https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.geojson \
    | geojson-to-sqlite covid-ireland.db dailycases - --pk OBJECTID
