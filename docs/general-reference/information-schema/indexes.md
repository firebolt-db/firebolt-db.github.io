---
layout: default
title: Indexes
nav_order: 6
description: Use this reference to learn about the metadata available for Firebolt indexes using the information schema.
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for indexes
You can use the `information_schema.indexes` view to return information about each index in a database. The view is available for each database and contains one row for each index in the database. You can use a `SELECT` query to return information about each index.

The following query returns all aggregating indexes defined within the current database

```sql
SELECT
  *
FROM
  information_schema.indexes
WHERE
  index_type='aggregating`;
```

## Columns in information_schema.indexes

Each row has the following columns with information about the database.

| Name                          | Data Type | Description |
| :-----------------------------| :-------- | :---------- |
| table_catalog                 | STRING    | Name of the catalog. Firebolt provides a single ‘default’ catalog. |
| table_schema                  | STRING    | Name of the database. |
| table_name                    | STRING    | The name of the table for which the index is defined. |
| index_name                    | STRING    | The name defined for the index. |
| index_type                    | STRING    | One of `primary`, `aggregating`, or `join`. |
| index_definition              | STRING    | The portion of the index statement that defines the columns and aggregations (if applicable) for the index. |
| index_compressed_size         | BIGINT    | The compressed size of the index. |
| index_uncompressed_size       | BIGINT    | The uncompressed size of the index. |
