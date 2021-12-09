---
layout: default
title: Running queries
nav_order: 4
parent: Information schema and usage views
grand_parent: General reference
---

# Running queries

The `running_queries` view can be used to explore Firebolt's running queries in your account.\
The view is available in all databases and can be queried, for example, as follows:

```sql
SELECT
	*
FROM
	catalog.running_queries
LIMIT
	100;
```

The `running_queries` view contains the following columns:

| **Column Name** | **Description**                                               |
| ENGINE\_NAME    | The name of the engine that was used to execute the query     |
| ENGINE\_ID      | The id of the engine that was used to execute the query       |
| USER\_ID        | The user ID that was used to execute the query                |
| ACCOUNT\_ID     | The ID of the account in which the query was executed         |
| START\_TIME     | The query execution start time (UTC)                          |
| DURATION        | Duration of query execution (in milliseconds)                 |
| STATUS          | The status of the query. Always contains the value 'RUNNING'. |
| QUERY\_ID       | The unique identifier of the SQL query                        |
| QUERY\_TEXT     | Text of the SQL statement                                     |
| SCANNED\_ROWS   | The total amount of rows scanned                              |
| SCANNED\_BYTES  | The total amount of bytes scanned (both in cache and storage) |
| INSERTED\_ROWS  | The total amount of rows written                              |
| INSERTED\_BYTES | The total amount of bytes written                             |
