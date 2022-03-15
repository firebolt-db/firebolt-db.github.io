---
layout: default
title: CREATE VIEW
description: Reference and syntax for the CREATE VIEW command.
parent: SQL commands
---

# CREATE VIEW

Views allow you to use a query as if it were a table.

Views are useful to filter, focus and simplify a database for users. They provide a level of abstraction that can make subqueries easier to write, especially for commonly referenced subsets of data. A view in Firebolt executes its query each time the view is referenced. In other words, the view results are not stored for future usage, and therefore using views does not provide a performance advantage.

## Syntax

```sql
CREATE VIEW [IF NOT EXISTS] <name> [(<column_list>)]
AS SELECT <select_statement>
```

| Parameter                                       | Description                                                                                                                     |
| :----------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------- |
| `<name>`                                        | An ​identifier​​ that specifies the name of the view. This name should be unique within the database.                           |
| `​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​<column_list>` | An optional list of column names to be used for columns of the view. If not given, the column names are deduced from the query. |
| `<select_statement>`                            | The select statement for creating the view                                                                                      |

## Example

```sql
CREATE VIEW fob_shipments
AS SELECT   l_shipmode,
            l_shipdate,
            l_linestatus,
            l_orderkey,
FROM    lineitem
WHERE   l_shipdate > '1990-01-01'
AND     l_shipmode = 'FOB'
```
