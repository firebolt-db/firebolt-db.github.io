---
layout: default
title: SHOW ENGINES
description: Reference and syntax for the SHOW ENGINES command.
parent: SQL commands
---

# SHOW ENGINES

Returns a table with a row for each Firebolt engine defined in the current Firebolt account, with columns containing information about each engine as listed below.

## Syntax

```sql
SHOW ENGINES;
```

## Returns

The returned table has the following columns.

| Column name                 | Data Type   | Description |
| :---------------------------| :-----------| :-----------|
| engine_name                 | TEXT      | The name of the engine. |
| region                      | TEXT      | The AWS Region in which the engine was created. |
| spec                        | TEXT      | The specification of nodes comprising the engine. |
| scale                       | INTEGER         | The number of nodes in the engine. |
| status                      | TEXT      | The engine status. For more information, see [Viewing and understanding engine status](../../working-with-engines/understanding-engine-fundamentals.md#viewing-and-understanding-engine-status). |
| attached_to                 | TEXT      | The name of the database to which the engine is attached. |
| version                     | TEXT      | The engine version. |
