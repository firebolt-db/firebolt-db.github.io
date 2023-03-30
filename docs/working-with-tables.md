---
layout: default
title: Working with tables
description: Learn about external tables, fact tables, and dimension tables in Firebolt and how to use them.
nav_order: 6
has_toc: true
---
# Working with tables

Tables in Firebolt have a few unique characteristics that are designed to optimize performance. This topic covers table concepts.

## Fact and dimension tables

External tables exist solely as a connector to your data source. When you create a table in Firebolt to run queries over, you must specify whether it’s a `FACT` or a `DIMENSION` table. Firebolt handles these table types differently to optimize query performance in general and join operations in particular.

* **Fact tables** are always **sharded** across engine nodes. Each node stores part of the table. Use fact tables for your larger and most granular (transaction) tables.
* **Dimension tables** are **replicated** in each engine node. Use dimension tables for smaller data sets that are typically more descriptive of a dimension in the fact table, and are frequently joined with fact tables. When performing joins, the local shard of a fact table on each node is joined with the local copy of the dimension table.

If your table does not fit in either of the traditional fact or dimension definition, we recommended that you define very large tables as fact tables, and smaller tables as dimension tables.

### Primary indexes

Tables in the Firebolt data warehouse are stored in the Firebolt file format (F3) to optimize speed and efficiency. F3 uses the *primary index* that you specify in a table definition to sort, compress, and index data. Primary indexes are mandatory for fact tables and optional for dimension tables. For more information about configuring primary indexes, see [Using primary indexes](/using-indexes/using-primary-indexes.md).

## Example: creating fact and dimension tables

Below is a simple example of a script that creates one fact table and two dimension tables.

```sql
CREATE FACT TABLE transactions
(
    transaction_id    BIGINT,
    sale_date         TIMESTAMP,
    store_id          INTEGER,
    product_id        INTEGER,
    units_sold        INTEGER
)
PRIMARY INDEX store_id, product_id;

CREATE DIMENSION TABLE dim_store
(
    store_id      INTEGER,
    store_number  INTEGER,
    state         TEXT,
    country       TEXT
);

CREATE DIMENSION TABLE dim_product
(
    product_id        INTEGER,
    product_name      TEXT,
    product_category  TEXT,
    brand             TEXT
);
```

For more information, see [CREATE FACT\|DIMENSION TABLE](sql-reference/commands/create-fact-dimension-table.md).
