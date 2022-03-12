---
layout: default
title: Running queries
description: Use this reference to learn about the metadata available for running queries in Firebolt using the information schema.
nav_order: 6
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for running queries

You can use the `catalog.running_queries` view to return information about queries currently running in a database. The view is available in each database and contains one row for each running query in the database. You can use a `SELECT` query to return information about each running query as shown in the example below.

```sql
SELECT
  *
FROM
  catalog.running_queries
LIMIT
  100;
```

## Columns in catalog.running_queries

Each row has the following columns with information about each running query.

| Column Name                 | Data type | Description |
| :---------------------------| :---------| :---------- |
| ENGINE_ID                   | STRING    | The ID of the engine that was used to execute the query. |
| ENGINE_NAME                 | STRING    | The name of the engine that was used to execute the query. |
| ACCOUNT_ID                  | STRING    | The ID of the account in which the query was executed. |
| USER_ID                     | STRING    | The user ID that was used to execute the query. |
| START_TIME                  | TIMESTAMP | The query execution start time (UTC). |
| STATUS                      | STRING    | The status of the query. Always contains the value 'RUNNING'. |
| DURATION                    | DOUBLE    | The elapsed time in milliseconds between `<START_TIME>` and the time that the query over `catalog.running_queries` returns results. |
| QUERY_ID                    | STRING    | The unique identifier of the SQL query. |
| QUERY_TEXT                  | STRING    | Text of the SQL statement. |
| SCANNED_ROWS                | LONG      | The number of rows scanned to return query results. |
| SCANNED_BYTES               | LONG      | The number of bytes scanned from cache and storage. |
| INSERTED_ROWS               | LONG      | The number of rows written. |
| INSERTED_BYTES              | LONG      | The number of bytes written. |
