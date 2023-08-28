---
layout: default
title: CREATE DATABASE
description: Reference and syntax for the CREATE DATABASE command.
parent:  SQL commands
---

# CREATE DATABASE
Creates a new database.

## Syntax
{: .no_toc} 

```sql
CREATE DATABASE [IF NOT EXISTS] <database_name>
[ WITH 
[ ATTACHED_ENGINES = ( <engine_name>'[, ... ] )]
[ DEFAULT_ENGINE = <engine_name> ]
[ DESCRIPTION = <description> ]
]
```

## Parameters 
{: .no_toc} 


| Parameter                                      | Description                     |
| :---------------------------------------------- | :---------------------------- |
| `<database_name>`                              | The name of the database. | 
| `ATTACHED_ENGINES = ( <engine_name> [ ... ] )` | A list of engine names, for example:<br>`ATTACHED_ENGINES = (my_engine_1 my_engine_2)`. The specified engines must be detached from any other databases first. |
| `DEFAULT_ENGINE = engine_name`                 | The name of the default engine. If not specified, the first engine in the attached engines list will be used as default. If a default engine is specified without specifying the list of attached engines or if the default engine is not in that list, the default engine will be both attached to the database and used as the default engine. |
| `DESCRIPTION = 'description'`                  | The engine's description (up to 64 characters). |

## Example
The following example creates a database with non-default properties: 

```sql
CREATE DATABASE IF NOT EXISTS my_db
WITH DESCRIPTION = 'Being used for testing'
```
