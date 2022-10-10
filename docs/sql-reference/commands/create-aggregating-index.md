---
layout: default
title: CREATE AGGREGATING INDEX
description: Reference and syntax for the CREATE AGGREGATING INDEX command.
parent: SQL commands
---

# CREATE AGGREGATING INDEX

Different syntax is used when creating an aggregating index on an empty table or a table populated with data. After an aggregating index is created, Firebolt automatically updates the index as new data is ingested. For more information, see [Using aggregating indexes](../../using-indexes/using-aggregating-indexes.md).

## Syntax&ndash;aggregating index on an empty table

```sql
CREATE AGGREGATING INDEX <agg_index_name> ON <fact_table_name> (
  <key_column>[,...<key_columnN>],
  <aggregation>[,...<key_columnN>]
);
```

{: .note}
The index is populated automatically as data is loaded into the table.

## Syntax&ndash;aggregating index on a populated table
{: .no_toc}

```sql
CREATE AGGREGATING INDEX [IF NOT EXISTS] <agg_index_name> ON <fact_table_name> (
  <key_column>[,...<key_columnN>],
  <aggregation>[,...<aggregationN>]
);
```

| Parameter           | Description                                                                                                             |
| :------------------- | :----------------------------------------------------------------------------------------------------------------------- |
| `<agg_index_name>`  | Specifies a unique name for the index                                                                                   |
| `<fact_table_name>` | Specifies the name of the fact table referenced by this index                                                           |
| `<key_column>`      | Specifies column name from the `<fact_table_name>` used for the index                                                   |
| `<aggregation>`     | Specifies one or more aggregation functions to be applied on a `<key_column>`, such as `SUM`, `COUNT`, `AVG`, and more. |

## Example&ndash;create an aggregating index
{: .no_toc}

In the following example, we create an aggregating index on the fact table `my_fact`, to be used in the following query:

```sql
SELECT
  product_name,
  count(DISTINCT source),
  sum(amount)
FROM
  my_fact
GROUP BY
  product_name;
```

The aggregating index is created with the statement below.

```sql
CREATE AGGREGATING INDEX my_fact_agg_idx ON my_fact (
  product_name,
  count(distinct source),
  sum(amount)
);
```

{: .note}
To benefit from the performance boost provided by the index, include in the index definition all columns and measurements that the query uses.
