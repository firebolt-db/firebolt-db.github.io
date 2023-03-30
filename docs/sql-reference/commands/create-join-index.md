---
layout: default
title: CREATE JOIN INDEX
description: Reference and syntax for the CREATE JOIN INDEX command.
parent: SQL commands
---

# CREATE JOIN INDEX

Join indexes can accelerate queries that use `JOIN` operations on dimension tables. Under certain circumstances, a join index can significantly reduce the compute requirements to perform a join at query runtime. For more information, see [Using join indexes](../../using-indexes/using-join-indexes.md).

{: .note}
Following release of DB version 3.19.0, you no longer need to manually create join indexes. 

## Syntax

```sql
CREATE JOIN INDEX [IF NOT EXISTS] <unique_join_index_name> ON <dim_table_name>
  (
    <dim_join_key_col>,
    <dim_col1>[,...<dim_colN>]
  );
```

| Parameter                  | Description                                                                                                        |
| :-------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| `<unique_join_index_name>` | A unique name for the join index.                                                                                  |
| `<dimension_table_name>`   | The name of the dimension table on which the index is configured.                                                  |
| `<dim_join_key_col>` | The dimension table join key column. This is the column name used in the join’s `ON` clause. This column in the dimension table should have no duplicate values and should be defined using the [UNIQUE](create-fact-dimension-table.md#column-constraints--default-expression) column attribute.                                                             |
| `<dimension_column>`       | The column name which is being loaded into memory from the dimension table. More than one column can be specified. |

## Example&ndash;create join index with specific columns

The example below creates a join index on the dimension table `my_dim`, created using the following DDL. Note that the column `my_dim_id` is defined with the `UNIQUE` attribute and contains no duplicate values.

```sql
CREATE DIMENSION TABLE my_cstmr_dim (
  cstmr_id BIGINT UNIQUE,
  name TEXT,
  email TEXT,
  hs_nm INTEGER,
  street TEXT,
  city TEXT,
  st_pvnc TEXT,
  country TEXT,
  phone1 TEXT,
  phone2 TEXT,
  status TEXT)
PRIMARY INDEX my_cstmr_id;
```

Queries often run that join different fact tables with this dimension table. Those queries `SELECT` the `name` and `email` of customers in the returned results. Another set of queries often select `city` and `status` in returned results with a join. The following join index helps to accelerate these queries.

```sql
CREATE JOIN INDEX cstmr_email_name_jidx ON my_cstmr_dim (
  cstmr_id,
  name,
  email,
  city,
  status
);
```