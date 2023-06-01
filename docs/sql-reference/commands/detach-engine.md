---
layout: default
title: DETACH ENGINE (deprecated)
description: Reference and syntax for the deprecated DETACH ENGINE command.
nav_exclude: true
parent: SQL commands
---

# DETACH ENGINE (deprecated)

Deprecated. Avoid using this statement and use `DROP ENGINE` instead. Allows you to detach an engine from a database.

## Syntax

```sql
DETACH ENGINE <engine_name> FROM <database_name>
```

| Parameter         | Description                                                     | Mandatory? Y/N |
| :----------------- | :--------------------------------------------------------------- | :-------------- |
| `<engine_name>`   | The name of the engine to detach.                               | Y              |
| `<database_name>` | The name of the database to detach engine `<engine_name>` from. | Y              |
