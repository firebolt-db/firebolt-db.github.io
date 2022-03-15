---
layout: default
title: DROP DATABASE
description: Reference and syntax for the DROP DATABASE command.
parent: SQL commands
---

# DROP DATABASE
Deletes a database.

## Syntax

Deletes the database and all of its tables and attached engines.

```sql
DROP DATABASE [IF EXISTS] <database_name>
```

| Parameter         | Description                            |
| :----------------- | :-------------------------------------- |
| `<database_name>` | The name of the database to be deleted |
