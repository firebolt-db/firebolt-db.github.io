---
layout: default
title: ALTER DATABASE
description: Reference and syntax for the ALTER DATABASE command.
parent: SQL commands
---

# ALTER DATABASE

Updates the configuration of the specified database `<database_name>`.

## Syntax

```sql
ALTER DATABASE <database_name> WITH
    [ATTACHED_ENGINES = ( '<engine_name>' [, ... ] )]
    [DEFAULT_ENGINE = 'engine_name']
    [DESCRIPTION = 'description']
```

| Parameter | Description |
| :--- | :--- |
| `<database_name>`                  | Name of the  database to be altered. |
| `ATTACHED_ENGINES = <engine_name>` | Name(s) of  Firebolt engine(s) attached to the database. |
| `DEFAULT_ENGINE = <engine_name>`   | Name of the default engine. |
| `DESCRIPTION = <description>`      | Description of the database. |

## Example

```sql
ALTER DATABASE my_database WITH DEFAULT_ENGINE = 'my_new_default_engine';
```
