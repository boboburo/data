#!/bin/sh

curl https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.geojson \
    | geojson-to-sqlite covid-ireland.db dailycases_geo - --pk OBJECTID

sqlite3 covid-ireland.db <<'END_SQL'
.timeout 2000
DROP TABLE IF EXISTS dailycases;
CREATE TABLE dailycases AS SELECT OBJECTID, ORIGID,CountyName,PopulationCensus16,TimeStamp,
ConfirmedCovidCases,PopulationProportionCovidCases FROM dailycases_geo;
DROP TABLE IF EXISTS dailycases_geo;
END_SQL
