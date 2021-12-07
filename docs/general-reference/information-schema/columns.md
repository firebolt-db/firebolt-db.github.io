---
layout: default
title: Columns
nav_order: 3
parent: Information schema and usage views
grand_parent: General reference
---

# Columns

This information schema view contains a row per table column in the current database.

The view is available in all databases and can be queried as follows:

```sql
SELECT
    *
FROM
    information_schema.columns;
```

## View columns

|                            |               |                                                                                |
| -------------------------- | ------------- | ------------------------------------------------------------------------------ |
| **Column Name**            | **Data Type** | **Description**                                                                |
| table\_catalog             | `TEXT`        | Name of the catalog. Firebolt provides a single ‘default’ catalog              |
| table\_schema              | `TEXT`        | Name of the database containing the table                                      |
| table\_name                | `TEXT`        | Name of the table                                                              |
| column\_name               | `TEXT`        | Name of the column                                                             |
| is\_nullable               | `TEXT`        | ‘YES’ if the column may contain NULL, ‘NO’ otherwise                           |
| data\_type                 | `TEXT`        | The data type of the column                                                    |
| is\_in\_partition\_expr    | `TEXT`        | ‘YES’ if the column is part of the partition by expression and ‘NO’ otherwise. |
| is\_in\_primary\_index     | `TEXT`        | ‘YES’ if the column is part of the primary index and ‘NO’ otherwise.           |
| character\_maximum\_length | `INT`         | Not applicable for Firebolt                                                    |
| character\_octet\_length   | `INT`         | Not applicable for Firebolt                                                    |
| numeric\_precision\_radix  | `INT`         | Not applicable for Firebolt                                                    |
| interval\_type             | `TEXT`        | Not applicable for Firebolt                                                    |
| interval\_precision        | `INT`         | Not applicable for Firebolt                                                    |
| character\_set\_catalog    | `TEXT`        | Not applicable for Firebolt                                                    |
| character\_set\_schema     | `TEXT`        | Not applicable for Firebolt                                                    |
| character\_set\_name       | `TEXT`        | Not applicable for Firebolt                                                    |
| collation\_catalog         | `TEXT`        | Not applicable for Firebolt                                                    |
| collation\_schema          | `TEXT`        | Not applicable for Firebolt                                                    |
| collation\_name            | `TEXT`        | Not applicable for Firebolt                                                    |
| domain\_catalog            | `TEXT`        | Not applicable for Firebolt                                                    |
| domain\_schema             | `TEXT`        | Not applicable for Firebolt                                                    |
| domain\_name               | `TEXT`        | Not applicable for Firebolt                                                    |
| udt\_catalog               | `TEXT`        | Not applicable for Firebolt                                                    |
| udt\_schema                | `TEXT`        | Not applicable for Firebolt                                                    |
| udt\_name                  | `TEXT`        | Not applicable for Firebolt                                                    |
| scope\_catalog             | `TEXT`        | Not applicable for Firebolt                                                    |
| scope\_schema              | `TEXT`        | Not applicable for Firebolt                                                    |
| scope\_name                | `TEXT`        | Not applicable for Firebolt                                                    |
| maximum\_cardinality       | `INT`         | Not applicable for Firebolt                                                    |
| dtd\_identifier            | `TEXT`        | Not applicable for Firebolt                                                    |
| is\_self\_referencing      | `TEXT`        | Not applicable for Firebolt                                                    |
| is\_identity               | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_generation       | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_start            | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_increment        | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_maximum          | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_minimum          | `TEXT`        | Not applicable for Firebolt                                                    |
| identity\_cycle            | `TEXT`        | Not applicable for Firebolt                                                    |
| is\_generated              | `TEXT`        | Not applicable for Firebolt                                                    |
| generation\_expression     | `TEXT`        | Not applicable for Firebolt                                                    |
| is\_updatable              | `TEXT`        | Not applicable for Firebolt                                                    |
