---
layout: default
title: Tables
description: Use this reference to learn about the metadata available for Firebolt tables using the information schema.
nav_order: 3
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for tables

You can use the `information_schema.tables` view to return information about each table in a database. The view is available for each database and contains one row for each table in the database. You can use a `SELECT` query to return information about each table as shown in the example below.

```sql
SELECT
  *
FROM
  information_schema.tables;
```

## Columns in information_schema.tables

Each row has the following columns with information about each table.

| Name                        | Data Type   | Description |
| :---------------------------| :-----------| :-----------|
| table_catalog               | TEXT      | Name of the catalog. Firebolt offers a single ‘default’ catalog. |
| table_schema                | TEXT      | The name of the database. |
| table_name                  | TEXT      | The name of the table. |
| table_type                  | TEXT      | One of `FACT TABLE`, `DIMENSION TABLE`, `EXTERNAL TABLE`, or `VIEW`. |
| primary_index               | TEXT      | An ordered array of the column names comprising the primary index definition, if applicable. |
| number_of_rows              | BIGINT      | The number of rows in the table. |
| size                        | DOUBLE PRECISION | The compressed size of the table. |
| size_uncompressed           | DOUBLE PRECISION | The uncompressed size of the table. |
| compression_ratio           | DOUBLE PRECISION | The compression ratio (`<size_uncompressed>`/`<size>`). |
| number_of_tablets           | INTEGER        | The number of tablets comprising the table. |
| self_referencing_column_name| NULL        | Not applicable for Firebolt. |
| reference_generation        | NULL        | Not applicable for Firebolt. |
| user_defined_type_catalog   | NULL        | Not applicable for Firebolt. |
| user_defined_type_schema    | NULL        | Not applicable for Firebolt. |
| user_defined_type_name      | NULL        | Not applicable for Firebolt. |
| is_insertable_into          | NULL        | Not applicable for Firebolt. |
| is_typed                    | NULL        | Not applicable for Firebolt. |
| commit_action               | NULL        | Not applicable for Firebolt. |
