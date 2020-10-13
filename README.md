# data

This repo contains a number of SQLite DBs built with [Datasette](https://github.com/simonw/datasette). They are hosted on
Google Cloud. 

Each DB will will have an associated metadata.json file. 

## Setup 

## Create the virtual environment 

Using Anaconda with Python 3.8. Setup virtual environment, install some libraries and write to a requirements.txt file. 
This will be used later when automating any daily data pulls. 

```bash
conda create -n bobo-data python =3.8
source activate bobo-data
pip install csvs-to-sqlite geojson-to-sqlite
pip freeze > requirements.txt
```


## Adding data using Datasette

To add .csv file to an SQLite, I have used the [CSVS-to-sqlite](https://github.com/simonw/csvs-to-sqlite) tool. 

```bash
pip install csvs-to-sqlite
```
From command line, this will create the SQLite - see the docs for table replacement etc. 
```bash
csvs-to-sqlite myfile.csv mydatabase.db

##overwrite table
csvs-to-sqlite --replace-tables myfile.csv mydatabase.db
```
## Create some metadata
 
Metadata is important for understand data origins. The [Datasette Docs](https://docs.datasette.io/en/stable/metadata.html) have good documentation on adding metadata. 

To run locally to check the metadata

```bash
datasette mydatabase.db --metadata metadata.json

# kill process if forgot to close properly 
lsof -i :8001
kill -9 [PID]
```

*Try to have one metadata.json per folder in the repo*

## Publish to Google Cloud

See the doucmentation for getting [Google Cloud Command Line Installed](https://cloud.google.com/sdk/
).

Once you have a service setup, type below in to set config. 

```bash
gcloud config set run/region europe-west1
glcoud config set project data-hosting-291810
```

file can added to an SQLite DBas a table can be added/overwritten to a DB by; 

```bash
datasette publish cloudrun cso.db --service=cso

#push with associated metadata
datasette publish cloudrun cso.db --service=cso --metadata=cso_metadata.json
```

*Note I try to have one service per DB, may change this in future*


# COVID Ireland Data

Pull data from [Ireland's Covid Data Hub](https://covid19ireland-geohive.hub.arcgis.com/). 

```bash
curl https://opendata.arcgis.com/datasets/d9be85b30d7748b5b7c09450b8aede63_0.geojson \
    | geojson-to-sqlite covid-ireland.db dailycases - --pk OBJECTID
```

## Setup Secrets in github repo 

for google account 



# TODO

- [ ] Add covid to google cloud
- [ ] Work out if geometery can be dropped in json grab
- [ ] Automate the pull using github actions. 