---
layout: default
title: Columns
description: Use this reference to learn about the metadata available for Firebolt columns using the information schema.
nav_order: 5
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for columns

You can use the `information_schema.columns` view to return information about all columns in any table in a database. The view is available in each database and contains one row for each column. You can use a `SELECT` query to return information about each column as shown in the example below.


```sql
SELECT
  *
FROM
  information_schema.columns;
```

## Columns in information_schema.columns

Each row has the following columns with information about each column.

| Column Name               | Data Type | Description|
|:--------------------------|:----------|:-----------|
| table_catalog             | TEXT    | Name of the catalog. Firebolt provides a single `default` catalog. |
| table_schema              | TEXT    | Name of the database containing the table. |
| table_name                | TEXT    | Name of the table containing the column. |
| column_name               | TEXT    | Name of the column. |
| is_nullable               | TEXT    | `YES` if the column may contain NULL, `NO` otherwise. |
| data_type                 | TEXT    | The data type of the column. |
| is_in_partition_expr      | TEXT    | `YES` if the column is included in the table's `PARTITION BY` clause, `NO` otherwise. |
| is_in_primary_index       | TEXT    | `YES` if the column is included in the tables's `PRIMARY INDEX` clause, `NO` otherwise. |
| character_maximum_length  | NULL      | Not applicable for Firebolt. |
| character_octet_length    | NULL      | Not applicable for Firebolt. |
| numeric_precision_radix   | NULL      | Not applicable for Firebolt. |
| interval_type             | NULL      | Not applicable for Firebolt. |
| interval_precision        | NULL      | Not applicable for Firebolt. |
| character_set_catalog     | NULL      | Not applicable for Firebolt. |
| character_set_schema      | NULL      | Not applicable for Firebolt. |
| character_set_name        | NULL      | Not applicable for Firebolt. |
| collation_catalog         | NULL      | Not applicable for Firebolt. |
| collation_schema          | NULL      | Not applicable for Firebolt. |
| collation_name            | NULL      | Not applicable for Firebolt. |
| domain_catalog            | NULL      | Not applicable for Firebolt. |
| domain_schema             | NULL      | Not applicable for Firebolt. |
| domain_name               | NULL      | Not applicable for Firebolt. |
| udt_catalog               | NULL      | Not applicable for Firebolt. |
| udt_schema                | NULL      | Not applicable for Firebolt. |
| udt_name                  | NULL      | Not applicable for Firebolt. |
| scope_catalog             | NULL      | Not applicable for Firebolt. |
| scope_schema              | NULL      | Not applicable for Firebolt. |
| scope_name                | NULL      | Not applicable for Firebolt. |
| maximum_cardinality       | NULL      | Not applicable for Firebolt. |
| dtd_identifier            | NULL      | Not applicable for Firebolt. |
| is_self_referencing       | NULL      | Not applicable for Firebolt. |
| is_identity               | NULL      | Not applicable for Firebolt. |
| identity_generation       | NULL      | Not applicable for Firebolt. |
| identity_start            | NULL      | Not applicable for Firebolt. |
| identity_increment        | NULL      | Not applicable for Firebolt. |
| identity_maximum          | NULL      | Not applicable for Firebolt. |
| identity_minimum          | NULL      | Not applicable for Firebolt. |
| identity_cycle            | NULL      | Not applicable for Firebolt. |
| is_generated              | NULL      | Not applicable for Firebolt. |
| generation_expression     | NULL      | Not applicable for Firebolt. |
| is_updatable              | NULL      | Not applicable for Firebolt. |
