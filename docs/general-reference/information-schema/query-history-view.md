---
layout: default
title: Query history
description: Use this reference to learn about the metadata available for historical queries in Firebolt.
nav_order: 7
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for query history

You can use the `catalog.query_history` view to return information about queries saved to query history. The view is available in each database and contains one row for each historical query in the database. You can use a `SELECT` query to return information about each query as shown in the example below.


```sql
SELECT
  *
FROM
  catalog.query_history
LIMIT
  100;
```

## Columns in catalog.query_history

Each row has the following columns with information about each query in query history.

| Column Name                 | Data type | Description |
| :---------------------------| :---------| :---------- |
| ENGINE_ID                   | STRING    | The ID of the engine that was used to execute the query. |
| ENGINE_NAME                 | STRING    | The name of the engine that was used to execute the query. |
| ACCOUNT_ID                  | STRING    | The ID of the account in which the query was executed. |
| USER_ID                     | STRING    | The user ID that was used to execute the query. |
| START_TIME                  | TIMESTAMP | The query execution start time (UTC). |
| END_TIME                    | TIMESTAMP | The query execution end time (UTC). |
| DURATION                    | LONG      | Duration of query execution (in milliseconds). |
| STATUS                      | STRING    | Can be one of the following values:<br>`STARTED_EXECUTION`&ndash;Successful start of query execution.<br>`ENDED_SUCCESSFULLY`&ndash;Successful end of query execution. <br>`PARSE_ERROR`&ndash;Exception before the start of query execution.<br>`EXECUTION_ERROR`&ndash;Exception during query execution. |
| QUERY_ID                    | STRING    | The unique identifier of the SQL query. |
| QUERY_TEXT                  | STRING    | Text of the SQL statement. |
| ERROR_MESSAGE               | STRING    | The error message that was returned. |
| SCANNED_ROWS                | LONG      | The total number of rows scanned. |
| SCANNED_BYTES               | LONG      | The total number of bytes scanned (both from cache and storage). |
| SCANNED_BYTES_CACHE         | LONG      | The total number of compressed bytes scanned from the engine's cache (the SSD instance store on engine nodes). |
| SCANNED_BYTES_STORAGE       | LONG      | The total number of compressed bytes scanned from F3 storage. |
| INSERTED_ROWS               | LONG      | The total number of rows written. |
| INSERTED_BYTES              | LONG      | The total number of bytes written (both to cache and storage). |
| INSERTED_BYTES_CACHE        | LONG      | The total number of compressed bytes written to the engine's cache (the SSD instance store on engine nodes). |
| INSERTED_BYTES_STORAGE      | LONG      | The total number of compressed bytes written to F3 storage. |
| SPILLED_BYTES_COMPRESSED    | LONG      | The total number of compressed bytes spilled. |
| SPILLED_BYTES_UNCOMPRESSED  | LONG      | The total number of uncompressed bytes spilled. |
| TOTAL_RAM_CONSUMED          | LONG      | The total number of engine bytes in RAM consumed during query execution. |
| RETURNED_ROWS               | LONG      | The total number of rows returned from the query. |
| RETURNED_BYTES              | LONG      | The total number of bytes returned from the query. |
