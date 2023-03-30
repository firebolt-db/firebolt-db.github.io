---
layout: default
title: SHOW INDEXES
description: Reference and syntax for the SHOW INDEXES command.
parent: SQL commands
---

# SHOW INDEXES

Returns a table with a row for each Firebolt index defined in the current database, with columns containing information about each index as listed below.

## Syntax

```sql
SHOW INDEXES;
```

## Returns

The returned table has the following columns.

| Column name                 | Data Type   | Description |
| :---------------------------| :-----------| :-----------|
| index_name                  | TEXT      | The name of the index. |
| table_name                  | TEXT      | The name of the table associated with the index. |
| type                        | TEXT      | One of `primary`, `aggregating`, or `join`. |
| expression                  | ARRAY (TEXT)| An ordered array of the expression in SQL that defined the index. |
| size_compressed             | DOUBLE PRECISION | The size of the index in bytes. |
| size_uncompressed           | DOUBLE PRECISION  | The uncompressed size of the index in bytes. |
| compression_ratio           | DOUBLE PRECISION  | The compression ratio (`<size_uncompressed>`/`<size_compressed>`).
| number_of_segments          | INTEGER      | The number of segments comprising the table. |
