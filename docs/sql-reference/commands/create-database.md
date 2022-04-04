---
layout: default
title: CREATE DATABASE
description: Reference and syntax for the CREATE DATABASE command.
parent: SQL commands
---

# CREATE DATABASE
Creates a new database.

## Syntax

```sql
CREATE DATABASE [IF NOT EXISTS] <database_name>
[WITH <properties>]
```

Where `<properties>` are:

* `REGION = '<aws_region>`
* `ATTACHED_ENGINES = ( '<engine_name>' [, ... ] )`
* `DEFAULT_ENGINE = 'engine_name'`
* `DESCRIPTION = 'description'`


| Parameter                                      | Description                                                                                                                                                                                                                                                                                                                                                                             | Mandatory? Y/N |
| :---------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |: -------------- |
| `<database_name>`                              | An identifier that specifies the name of the database.<br>For example: `my_database`                                                                                                                                                                                                                                                                                  | Y              |
| `REGION = '<aws_region>'`                      | The AWS region in which the database is configured. Choose the same region as the Amazon S3 bucket that contains data you ingest. See [Available AWS Regions](../../general-reference/available-regions.md) If not specified, `us-west-2` (US West (Oregon)) is the default.                                                                                                                                                                                                                                                       | N              |
| `ATTACHED_ENGINES = ( <engine_name> [ ... ] )` | A list of engine names, for example: `ATTACHED_ENGINES = (my_engine_1 my_engine_2)`. The specified engines must be detached from any other databases first.                                                                                                                                                                                                     | N              |
| `DEFAULT_ENGINE = engine_name`                 | An identifier that specifies the name of the default engine. If not specified, the first engine in the attached engines list will be used as default. If a default engine is specified without specifying the list of attached engines or if the default engine is not in that list, the default engine will be both attached to the database and used as the default engine. | N              |
| `DESCRIPTION = 'description'`                  | The engine's description (up to 64 characters).                                                                                                                                                                                                                                                                                                                                         | N              |

## Example&ndash;create a database with (non-default) properties

```sql
CREATE DATABASE IF NOT EXISTS my_db
WITH REGION = 'us-east-1' DESCRIPTION = 'Being used for testing'
```
