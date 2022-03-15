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
| engine_name                 | STRING      | The name of the engine. |
| region                      | STRING      | The AWS Region in which the engine was created. |
| spec                        | STRING      | The specification of nodes comprising the engine. |
| scale                       | INT         | The number of nodes in the engine. |
| status                      | STRING      | The engine status. For more information, see [Viewing and understanding engine status](../../working-with-engines/understanding-engine-fundamentals.md#viewing-and-understanding-engine-status). |
| attached_to                 | STRING      | The name of the database to which the engine is attached. |
| type                        | STRING      | One of `ANALYTICS` or `GENERAL PURPOSE`. |
| auto_stop                   | INT         | The auto-stop interval in minutes, which is the amount of inactive time after which the engine will automatically stop. |
| warmup_policy               | STRING      | One of `MINIMAL`, `PRELOAD_INDEXES`, or `PRELOAD_ALL_DATA`. For more information about warmup methods, see [Warmup method](../../working-with-engines/understanding-engine-fundamentals.md#warmup-method). |
