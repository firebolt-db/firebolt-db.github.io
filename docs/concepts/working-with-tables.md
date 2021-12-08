---
layout: default
title: Working with tables
nav_order: 1
parent: Concepts
has_toc: true
---
# Working with tables

Tables in Firebolt have a few unique characteristics that are designed to optimize performance. This page will help you understand these concepts and how to work with Firebolt tables.

## FACT and DIMENSION tables

When you create a table in Firebolt, you must also specify whether it’s a `FACT` or a `DIMENSION` table. The two different types of tables are handled differently in order to optimize the performance of queries in general and joins in particular.

* **FACT** tables are always **sharded** across the nodes of the cluster
* **DIMENSION** tables are **replicated** across the nodes of the cluster
* When performing joins, the local shard of a fact table on each node is joined with the local copy of the dimension table

FACT tables should be used for your traditional fact tables - usually your larger and most granular (transaction) tables. DIMENSION tables should be used for the smaller tables that are typically more descriptive in nature and are joined with the FACT tables. If your table does not fit in either of the traditional fact/dimension definition, then it is recommended to define very large tables as FACT, and smaller tables as DIMENSION.

## PRIMARY INDEX

Firebolt tables are persisted in S3 in a proprietary file format called TripleF, aimed to optimize speed and efficiency. One of the unique characteristics of the TripleF format is that it is sorted, compressed, and indexed. What defines the sort order of the files is the PRIMARY INDEX defined on the table, which can include one or many fields.

Primary indexes are mandatory for fact tables and optional for dimension tables.

### How to choose a primary index

Because the primary index determines the physical sort order of the file, it significantly affects performance. For optimal performance, the primary index of **fact tables** should contain the fields that are most typically filtered or grouped by. This enables most queries to scan physically adjacent data and thus improve query performance. The primary index does not have to be identical to the field/s by which data is partitioned at the source. In **dimension tables**, the primary key should include the field/s that are used to join the dimension table to the fact table.

**Note**


A **primary index** should not be confused with a **primary key** in traditional database design. Unlike a primary key, the primary index is not unique.


## Example: creating fact and dimension tables

Below is a simple example of creating a fact table and two dimension tables.

```sql
CREATE FACT TABLE transactions
(
    transaction_id    BIGINT,
    sale_date         DATETIME,
    store_id          INT,
    product_id        INT,
    units_sold        INT
)
PRIMARY INDEX store_id, product_id;

CREATE DIMENSION TABLE dim_store
(
    store_id      INT,
    store_nunber  INT,
    state         TEXT,
    country       TEXT
);

CREATE DIMENSION TABLE dim_product
(
    product_id        INT,
    product_name      TEXT,
    product_category  TEXT,
    brand             TEXT
);
```

Click here for the full [CREATE TABLE](../sql-reference/commands/ddl-commands.md##create) reference.
