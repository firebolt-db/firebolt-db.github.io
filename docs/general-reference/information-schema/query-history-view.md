---
layout: default
title: Query history
nav_order: 5
parent: Information schema and usage views
grand_parent: General reference
---

# Query history

The `query_history` view can be used to explore Firebolt's query history in your account.\
The view is available in all databases and can be queried, for example, as follows:

```sql
SELECT
  *
FROM
  catalog.query_history
LIMIT
  100;
```

The `query_history` view contains the following columns:

| **Column Name** |**Description**|
| ENGINE\_NAME                 | The name of the engine that was used to execute the query|
| ENGINE\_ID                   | The id of the engine that was used to execute the query|
| USER\_ID                     | The user ID that was used to execute the query|
| ACCOUNT\_ID                  | The ID of the account in which the query was executed|
| START\_TIME                  | The query execution start time (UTC)|
| END\_TIME                    | The query execution end time (UTC)|
| DURATION                     | Duration of query execution (in milliseconds)|
| STATUS                       | Can be one of the following values:<br> <br> `‘STARTED_EXECUTION'` — Successful start of query execution. <br><br> `'ENDED_SUCCESSFULLY'` — Successful end of query execution. <br><br> `‘PARSE_ERROR'` — Exception before the start of query execution. <br><br> `'EXECUTION_ERROR'` — Exception during the query execution. |
| QUERY\_ID                    | The unique identifier of the SQL query|
| QUERY\_TEXT                  | Text of the SQL statement|
| ERROR\_MESSAGE               | The error message that was returned|
| SCANNED\_ROWS                | The total number of rows scanned |
| SCANNED\_BYTES               | The total number of bytes scanned (both from cache and storage)|
| SCANNED\_BYTES\_CACHE        | The total number of compressed bytes scanned from the engine's cache (the SSD instance store on engine nodes)|
| SCANNED\_BYTES\_STORAGE      | The total number of compressed bytes scanned from F3 storage|
| INSERTED\_ROWS               | The total number of rows written|
| INSERTED\_BYTES              | The total number of bytes written (both to cache and storage)|
| INSERTED\_BYTES\_CACHE       | The total number of compressed bytes written to the engine's cache (the SSD instance store on engine nodes)|
| INSERTED\_BYTES\_STORAGE     | The total number of compressed bytes written to F3 storage|
| SPILLED\_BYTES\_COMPRESSED   | The total number of compressed bytes spilled|
| SPILLED\_BYTES\_UNCOMPRESSED | The total number of uncompressed bytes spilled|
| TOTAL\_RAM\_CONSUMED         | The total number of engine bytes in RAM consumed during query execution|
| RETURNED\_ROWS               | The total number of rows returned from the query|
| RETURNED\_BYTES              | The total number of bytes returned from the query|
