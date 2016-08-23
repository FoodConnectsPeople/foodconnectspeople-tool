# foodconnectspeople-tool
This is a project for the development of tools related to *www.foodconnectspeople.com*.

## Getting started

### Create the DB
Change the template config file (`$PRJROOT/jolie/config.ini.sample`) with your information:

```
[db]
HOST=localhost
DRIVER=postgresql
PORT=5432
DBNAME=foodconnectspeople
USERNAME=<your user>
PASSWORD=<your password>
```

Rename it *config.ini*.

Run `jolie create_database.ol` to create a DB schema in PostgreSQL. Make sure
you have the access as described in the *config.ini* file.

### Insert data
1. Start the DB service:
```
cd data_sources/jolie
jolie db_service.ol
```

2. Launch an insert query on the DB:
`jolie data_sources/scripts/insert_ingredients.ol`

3. Test the data is there:
`jolie data_sources/jolie/tests/get_ingredients.ol`

4. In alternative launch the leonardo web server, and launch the Get ingredients
from a browser:
```
cd jolie/leonardo
jolie leonardo.ol
```
Go to localhost:8000 and push the button. You should be able to see the content
of the populated table.
