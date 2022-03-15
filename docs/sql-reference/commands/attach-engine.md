---
layout: default
title: ATTACH ENGINE
description: Reference and syntax for the ATTACH ENGINE command.
parent: SQL commands
---

# ATTACH ENGINE

The `ATTACH ENGINE` statement enables you to attach an engine to a database.

## Syntax

```sql
ATTACH ENGINE <engine_name> TO <database_name>
```

| Parameter         | Description                                                   | Mandatory? Y/N |
| :----------------- | :------------------------------------------------------------- | :-------------- |
| `<engine_name>`   | The name of the engine to attach.                             | Y              |
| `<database_name>` | The name of the database to attach engine `<engine_name>` to. | Y              |
