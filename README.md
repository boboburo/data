# data

This repo contains a number of SQLite DBs built with [Datasette](https://github.com/simonw/datasette). They are hosted on
Google Cloud. 

Each DB will will have an associated metadata.json file. 


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

file can added to an SQLite DBas a table can be added/overwritten to a DB by; 

```bash
datasette publish cloudrun cso.db --service=cso

#push with associated metadata
datasette publish cloudrun cso.db --service=cso --metadata=cso_metadata.json
```
Push with metadata

```bash

```


*Note I try to have one service per DB, may change this in future*
