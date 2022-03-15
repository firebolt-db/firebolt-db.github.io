---
layout: default
title: DROP TABLE
description: Reference and syntax for the DROP TABLE command.
parent: SQL commands
---

# DROP TABLE
Deletes a table.

## Syntax

```sql
DROP TABLE [IF EXISTS] <table_name>
```

| Parameter      | Description                          |
| :-------------- | :------------------------------------ |
| `<table_name>` | The name of the table to be deleted. For external tables, the definition is removed from Firebolt but not from the source. |
