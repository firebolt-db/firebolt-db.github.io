---
layout: default
title: Engines
nav_order: 2
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for engines

You can use the `information_schema.engines` view to return information about each engine in an account. The view is available for each database and contains one row for each engine in the account. You can use a `SELECT` query to return information about each engine as shown in the example below, which uses a `WHERE` clause to return all engines attached to databases that begin with `deng`.

```sql
SELECT
  *
FROM
  information_schema.engines
WHERE
  attached_to ILIKE 'deng%'
```

## Columns in information_schema.engines

Each row has the following columns with information about each engine.

| Name                        | Data Type   | Description |
| :---------------------------| :-----------| :-----------|
| engine_name                 | STRING      | The name of the engine. |
| region                      | STRING      | The AWS Region in which the engine was created. |
| spec                        | STRING      | The specification of nodes comprising the engine. |
| scale                       | INT         | The number of nodes in the engine. |
| status                      | STRING      | The engine status. For more information, see [Viewing and understanding engine status](../../working-with-engines/understanding-engine-fundamentals.md#viewing-and-understanding-engine-status). |
| attached_to                 | STRING      | The name of the database to which the engine is attached. |
| version                 | STRING      | The engine version.|
