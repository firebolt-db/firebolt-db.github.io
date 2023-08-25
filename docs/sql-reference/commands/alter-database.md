---
layout: default
title: ALTER DATABASE
description: Reference and syntax for the ALTER DATABASE command.
parent:  SQL commands
---

# ALTER DATABASE

Updates the configuration of the specified database.

## Syntax

```sql
ALTER DATABASE <database_name> WITH
    [ATTACHED_ENGINES = ( <engine_name> [, ... ] )]
    [DEFAULT_ENGINE = <engine_name>]
    [DESCRIPTION = <description>]
```

## Parameters 
{: .no_toc} 

| Parameter | Description |
| :--- | :--- |
| `<database_name>`                  | The name of the database to be altered. |
| `ATTACHED_ENGINES = <engine_name>` | The name(s) of Firebolt engine(s) attached to the database. |
| `DEFAULT_ENGINE = <engine_name>`   | The name of the default engine. |
| `<description>`      | The description of the database. |

## Example
The following example alters a current database with a new default engine, `my_new_default_engine`: 

```ALTER DATABASE my_database WITH DEFAULT_ENGINE = my_new_default_engine;```
