---
layout: default
title: System Engine (Beta)
description: System engine documentation
parent: Working with engines
---

# System Engine (Beta)
{: .no_toc}

Firebolt's system engine enables running various metadata-related queries without having to start an engine. The system engine is always available for you in all databases to select and use.  

The system engine supports running the following commands:
* CREATE/ALTER/DROP DATABASE
* CREATE/ALTER/DROP/ATTACH ENGINE
* START/STOP ENGINE
* SHOW DATABASES
* SHOW ENGINES

In addition, you can query the following information schema tables from the system engine:
* information_schema.engines
* information_schema.databases

## Using the system engine via the Firebolt manager 
1. In the Firebolt manager, choose the Databases icon in the navigation pane.
2. Click on the SQL Workspace icon for the desired database. In case you have no database in your account - create one first. 
3. From the engine selector in the SQL Workspace, choose System Engine, then run one of the supported queries.

## Using the system engine via SDKs
### Python SDK
Connect via the connector and specify engine_name = ‘system’ and database = ‘dummy’.

System engine does not need a database defined, but for the Python SDK - the `database` parameter is required, so any string here will work (except an empty string). If you wish to connect to an existing database and run metadata queries with the system engine, just specify the name of your database.

**Example**
```json
from firebolt.db import connect
from firebolt.client import DEFAULT_API_URL
from firebolt.client.auth import UsernamePassword
 
username = "<your_username>"
password = "<your_password>"
 
with connect(
   database="<any_db_here>", # this is a required parameter
   auth=UsernamePassword(username, password),
   api_endpoint=DEFAULT_API_URL,
   engine_name="system",
) as connection:
 
   cursor = connection.cursor()
 
   cursor.execute("SHOW DATABASES")

   print(cursor.fetchall())
```

### Other SDKs
Any other Firebolt connector can also be used similarly, as long as the engine name is specified as ‘system’ and the database is set to any name (string).

## Known limitations and future release plans

**Supported queries for system engine**

At this time, the system engine only supports running the metadata-related queries listed above. Additional queries will be supported in future versions.

System engine is currently only available for accounts that have a single region enabled.