---
layout: default
title: Query history
description: Use this reference to learn about the metadata available for historical queries in Firebolt.
nav_order: 7
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for query history

You can use the `information_schema.query_history` view to return information about queries saved to query history. The view is available in each database and contains one row for each historical query in the database. You can use a `SELECT` query to return information about each query as shown in the example below.


```sql
SELECT
  *
FROM
  information_schema.query_history
LIMIT
  100;
```

## Columns in information_schema.query_history

Each row has the following columns with information about each query in query history.

| Column Name                 | Data type | Description |
| :---------------------------| :---------| :---------- |
| engine_id                   | TEXT      | The ID of the engine that was used to execute the query. |
| engine_name                 | TEXT      | The name of the engine that was used to execute the query. |
| account_id                  | TEXT      | The ID of the account in which the query was executed. |
| user_id                     | TEXT      | The user ID that was used to execute the query. |
| start_time                  | TIMESTAMP | The query execution start time (UTC). |
| end_time                    | TIMESTAMP | The query execution end time (UTC). |
| duration_usec               | BIGINT    | Duration of query execution (in microseconds). |
| status                      | TEXT      | Can be one of the following values:<br>`STARTED_EXECUTION`&ndash;Successful start of query execution.<br>`ENDED_SUCCESSFULLY`&ndash;Successful end of query execution. <br>`CANCELED_EXECUTION`&ndash;Query cancelled during execution. <br>`PARSE_ERROR`&ndash;Exception before the start of query execution.<br>`EXECUTION_ERROR`&ndash;Exception during query execution. |
| query_id                    | TEXT      | The unique identifier of the SQL query. |
| query_text                  | TEXT      | Text of the SQL statement. |
| query_text_normalized       | TEXT      | Text of the SQL statement but with sanitized values of literals. |
| query_text_normalized_hash  | TEXT      | Hash value of `query_text_normalized`. |
| error_message               | TEXT      | The error message that was returned. |
| scanned_rows                | BIGINT    | The total number of rows scanned. |
| scanned_bytes               | BIGINT    | The total number of bytes scanned (both from cache and storage). |
| scanned_bytes_cache         | BIGINT    | The total number of compressed bytes scanned from the engine's cache. |
| scanned_bytes_storage       | BIGINT    | The total number of compressed bytes scanned from S3 storage. |
| inserted_rows               | BIGINT    | The total number of rows written. |
| inserted_bytes              | BIGINT    | The total number of bytes written (both to cache and storage). |
| inserted_bytes_storage      | BIGINT    | The total number of compressed bytes written to S3 storage. |
| spilled_bytes_compressed    | BIGINT    | The total number of compressed bytes spilled. |
| spilled_bytes_uncompressed  | BIGINT    | The total number of uncompressed bytes spilled. |
| total_ram_consumed          | BIGINT    | The total number of engine bytes in RAM consumed during query execution. |
| returned_rows               | BIGINT    | The total number of rows returned from the query. |
| returned_bytes              | BIGINT    | The total number of bytes returned from the query. |
| cpu_usage_us                | BIGINT    | The query time spent on the CPU as reported by Linux kernel scheduler - The value may be greater than overall execution time of the query because query’s execution is parallelized and CPU times across all threads and nodes is summarized. |
| cpu_delay_us                | BIGINT    | The query time spent on the runqueue as reported by Linux kernel scheduler - The value may be greater than overall execution time of the query because query’s execution is parallelized and CPU times across all threads and nodes is summarized. |
| time_in_queue_ms            | BIGINT    | The number of milliseconds the query spent in queue. |

