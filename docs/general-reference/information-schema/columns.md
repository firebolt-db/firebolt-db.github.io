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

| **Column Name**            | **Data Type** | **Description**                                                                |
| table_catalog             | `TEXT`        | Name of the catalog. Firebolt provides a single ‘default’ catalog              |
| table_schema              | `TEXT`        | Name of the database containing the table                                      |
| table_name                | `TEXT`        | Name of the table                                                              |
| column_name               | `TEXT`        | Name of the column                                                             |
| is_nullable               | `TEXT`        | ‘YES’ if the column may contain NULL, ‘NO’ otherwise                           |
| data_type                 | `TEXT`        | The data type of the column                                                    |
| is_in_partition_expr    | `TEXT`        | ‘YES’ if the column is part of the partition by expression and ‘NO’ otherwise. |
| is_in_primary_index     | `TEXT`        | ‘YES’ if the column is part of the primary index and ‘NO’ otherwise.           |
| character_maximum_length | `INT`         | Not applicable for Firebolt                                                    |
| character_octet_length   | `INT`         | Not applicable for Firebolt                                                    |
| numeric_precision_radix  | `INT`         | Not applicable for Firebolt                                                    |
| interval_type             | `TEXT`        | Not applicable for Firebolt                                                    |
| interval_precision        | `INT`         | Not applicable for Firebolt                                                    |
| character_set_catalog    | `TEXT`        | Not applicable for Firebolt                                                    |
| character_set_schema     | `TEXT`        | Not applicable for Firebolt                                                    |
| character_set_name       | `TEXT`        | Not applicable for Firebolt                                                    |
| collation_catalog         | `TEXT`        | Not applicable for Firebolt                                                    |
| collation_schema          | `TEXT`        | Not applicable for Firebolt                                                    |
| collation_name            | `TEXT`        | Not applicable for Firebolt                                                    |
| domain_catalog            | `TEXT`        | Not applicable for Firebolt                                                    |
| domain_schema             | `TEXT`        | Not applicable for Firebolt                                                    |
| domain_name               | `TEXT`        | Not applicable for Firebolt                                                    |
| udt_catalog               | `TEXT`        | Not applicable for Firebolt                                                    |
| udt_schema                | `TEXT`        | Not applicable for Firebolt                                                    |
| udt_name                  | `TEXT`        | Not applicable for Firebolt                                                    |
| scope_catalog             | `TEXT`        | Not applicable for Firebolt                                                    |
| scope_schema              | `TEXT`        | Not applicable for Firebolt                                                    |
| scope_name                | `TEXT`        | Not applicable for Firebolt                                                    |
| maximum_cardinality       | `INT`         | Not applicable for Firebolt                                                    |
| dtd_identifier            | `TEXT`        | Not applicable for Firebolt                                                    |
| is_self_referencing      | `TEXT`        | Not applicable for Firebolt                                                    |
| is_identity               | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_generation       | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_start            | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_increment        | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_maximum          | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_minimum          | `TEXT`        | Not applicable for Firebolt                                                    |
| identity_cycle            | `TEXT`        | Not applicable for Firebolt                                                    |
| is_generated              | `TEXT`        | Not applicable for Firebolt                                                    |
| generation_expression     | `TEXT`        | Not applicable for Firebolt                                                    |
| is_updatable              | `TEXT`        | Not applicable for Firebolt                                                    |
