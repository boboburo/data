#!/bin/sh

#curl "https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.geojson" | \
#geojson-to-sqlite covid-ireland.db dailycases_geo - --pk OBJECTID 

curl "https://opendata-geohive.hub.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.csv?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D" | \
sqlite-utils insert --csv covid-ireland.db dailycases_new - --pk OBJECTID 

sqlite3 covid-ireland.db <<'END_SQL'
.timeout 2000
DROP TABLE IF EXISTS dailycases;
CREATE TABLE dailycases AS SELECT OBJECTID, ORIGID,CountyName,PopulationCensus16,TimeStamp,
ConfirmedCovidCases,PopulationProportionCovidCases FROM dailycases_new;
DROP TABLE IF EXISTS dailycases_geo;
END_SQL

