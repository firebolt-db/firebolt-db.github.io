---
layout: default
title: Running queries
description: Use this reference to learn about the metadata available for running queries in Firebolt using the information schema.
nav_order: 6
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for running queries

You can use the `information_schema.running_queries` view to return information about queries currently running in a database. The view is available in each database and contains one row for each running query in the database. You can use a `SELECT` query to return information about each running query as shown in the example below.

```sql
SELECT
  *
FROM
   information_schema.running_queries
LIMIT
  100;
```

## Columns in information_schema.running_queries

Each row has the following columns with information about each running query.

| Column Name                 | Data type | Description |
| :---------------------------| :---------| :---------- |
| engine_id                   | STRING    | The ID of the engine that was used to execute the query. |
| engine_name                 | STRING    | The name of the engine that was used to execute the query. |
| account_id                  | STRING    | The ID of the account in which the query was executed. |
| user_id                     | STRING    | The user ID that was used to execute the query. |
| start_time                  | TIMESTAMP | The query execution start time (UTC). |
| status                      | STRING    | The status of the query. Always contains the value 'RUNNING'. |
| duration_usec               | BIGINT    | The elapsed time in microseconds between `<START_TIME>` and the time that the query over ` information_schema.running_queries` returns results. |
| query_id                    | STRING    | The unique identifier of the SQL query. |
| query_text                  | STRING    | Text of the SQL statement. |
| scanned_rows                | LONG      | The number of rows scanned to return query results. |
| scanned_bytes               | LONG      | The number of bytes scanned from cache and storage. |
| inserted_rows               | LONG      | The number of rows written. |
| inserted_bytes              | LONG      | The number of bytes written. |
