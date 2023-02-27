---
layout: default
title: System Engine (Alpha)
nav_exclude: true
search_exclude: true
toc_exclude: true
description: System engine documentation
parent: Working with engines
---

# System Engine (Alpha)
{: .no_toc}

Firebolt's system engine enables running various metadata-related queries without having to start an engine. The system engine is always available for you in all databases to select and use. 

The system engine supports running the following queries:
* CREATE/ALTER/DROP DATABASE
* CREATE/ALTER/DROP/ATTACH ENGINE
* START/RESTART/STOP ENGINE  
* SHOW DATABASES/ENGINES
* CREATE/DROP/GRANT/REVOKE ROLE

Firebolt's system engine enables running information_schema queries to retrieve the specific database schema without having to start an engine.
The system engine supports running the following queries:
* SHOW TABLES/INDEXES/VIEWS/COLUMNS
* select * from information_schema.tables/indexes/views/columns
notes:
1. one can select any column of course and make more complex queries, as long as he doesn't use user-defined tables(regular tables).
2.  on system engine we don’t store any actual data(tablet), thus every data related field in the I_S table will be shown as 0. (number_of_rows, size, size_uncompressed, compression_ratio, number_of_segments)
3.	a.  a precondition for having the metadata available on system engine is to make the database to be Pensieve compatible which internally means weare doing migration of the metadata from metaservice to pensieve (please phrase it as you think)
	b. to make the database compatible one we need to set FF pensieve.write_schema_on_legacy=true and RESTART a GP engine.
 non migrated accounts will still be able to run I_S queries but will receive empty results.

{: .caution}
>**Alpha Release** 
>
>As we learn more from you, we may change the behavior and add new features. We will communicate any such changes. Your engagement and feedback are vital. 


## Using the system engine via the Firebolt manager 
1. In the Firebolt manager, choose the Databases icon in the navigation pane.
2. Click on the SQL Workspace icon for the desired database. In case you have no database in your account - create one first. 
3. From the engine selector in the SQL Workspace, choose System Engine, then run one of the supported queries.

## Using the system engine via SDKs
### Python SDK
Connect via the connector and specify engine_name = ‘system’ and database = ‘dummy’.

System Engine does not need a database defined, but for the Python SDK - the `database` parameter is required, so any string here will work (except an empty string). If you wish to connect to an existing database and run metadata queries with the system engine, just specify the name of your database.

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

At this time, the system engine only supports running several metadata-related queries. Additional queries will be supported in future versions.
