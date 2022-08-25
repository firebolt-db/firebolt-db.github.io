---
layout: default
title: CREATE FACT or DIMENSION TABLE
description: Reference and syntax for the CREATE FACT TABLE and CREATE DIMENSION TABLE commands.
parent: SQL commands
---

# CREATE FACT or DIMENSION TABLE
{: .no_toc}

Creates a new fact or Dimension table in the current database.

Firebolt supports create table as select (CTAS). For more information, see [CREATE TABLE AS SELECT(CTAS)](create-fact-dimension-table-as-select.md).

* Topic ToC
{:toc}


## Syntax&ndash;fact table

```sql
CREATE FACT TABLE [IF NOT EXISTS] <table_name>
(
    <column_name> <column_type> [constraints]
    [, <column_name2> <column_type2> [constraints]
    [, ...n]]
)
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
[PARTITION BY <column_name>[, <column_name>[, ...n]]]
```

## Syntax&ndash;dimension table

```sql
CREATE DIMENSION TABLE [IF NOT EXISTS] <table_name>
(
    <column_name> <column_type> [constraints]
    [, <column_name2> <column_type2> [constraints]
    [, ...n]]
)
[PRIMARY INDEX <column_name>[, <column_name>[, ...n]]]
[PARTITION BY <column_name>[, <column_name>[, ...n]]]
```

| Parameter                                       | Description                                                                                            |
| :----------------------------------------------- | :------------------------------------------------------------------------------------------------------ |
| `<table_name>`                                  | An identifier that specifies the name of the table. This name should be unique within the database. |
| `<column_name>` | An identifier that specifies the name of the column. This name should be unique within the table.      |
| `<column_type>`                                 | Specifies the data type for the column.                                                                |

All identifiers are case insensitive unless double-quotes are used. For more information, please see our [identifier requirements page](../../general-reference/identifier-requirements.md).

* [Column constraints & default expression](#column-constraints--default-expression)
* [PRIMARY INDEX specifier](#primary-index)
* [PARTITION BY specifier](#partition-by)

## Column constraints & default expression

Firebolt supports the column constraints shown below.

```sql
<column_name> <column_type> [UNIQUE] [NULL | NOT NULL] [DEFAULT <expr>]
```


| Constraint           | Description                                                                                                                                                                                                                | Default value |
| :-------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------- |
| `DEFAULT <expr>`     | Determines the default value that is used instead of NULL value is inserted.                                                                                                                                               |               |
| `NULL` \| `NOT NULL` | Determines if the column may or may not contain NULLs.                                                                                                                                                                     | `NOT NULL`    |
| `UNIQUE`             | This is an optimization hint to tell Firebolt that this column will be queried for unique values, such as through a `COUNT(DISTINCT)` function. This will not raise an error if a non-unique value is added to the column. |               |

{: .note}
Note that nullable columns can not be used in Firebolt indexes (Primary, Aggregating or Join indexes).

### Example&ndash;Creating a table with nulls and not nulls

This example illustrates different use cases for column definitions and INSERT statements.

* **Explicit NULL insert**&ndash;a direct insertion of a `NULL` value into a particular column.
* **Implicit NULL insert**&ndash;an `INSERT` statement with missing values for a particular column.

The example uses a fact table in which to insert different values. The example below creates the fact table `t1`.

```sql
CREATE FACT TABLE t1
(
    col1 INT  NULL ,
    col2 INT  NOT NULL UNIQUE,
    col3 INT  NULL DEFAULT 1,
    col4 INT  NOT NULL DEFAULT 1,
    col5 TEXT
)
PRIMARY INDEX col2;
```

Once we've created the table, we can manipulate the values with different INSERT statements. Following are detailed descriptions of different examples of these:

| INSERT statement | Results and explanation  |
| :--------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `INSERT INTO t1 VALUES (1,1,1,1,1)`                                                                                               | 1 is inserted into each column                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `INSERT INTO t1 VALUES (NULL,1,1,1,1)`                                                                                            | col1 is `NULL`, and this is an explicit NULL insert, so NULL is inserted successfully.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `INSERT INTO t1 (col2,col3,col4,col5) VALUES (1,1,1,1)`                                                                           | This is an example of explicit and implicit INSERT statements. col1 is `NULL`, which is an implicit insert, as a default expression was not specified. In this case, col1 is treated as `NULL DEFAULT NULL,`so Firebolt inserts NULL.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `INSERT INTO t1 VALUES (1,NULL,1,1,1)`<br> <br>`INSERT INTO t1 (col1,col3,col4,col5) VALUES (1,1,1,1)` | The behavior here depends on the column type. For both cases, a “null mismatch” event occurs.<br><br> In the original table creation, col2 receives a `NOT NULL` value. Since a default expression is not specified, both of these INSERT statements try to insert `NOT NULL DEFAULT NULL` into col2. This means that there is an implicit attempt to insert `NULL` in both cases.<br><br> In this particular case, the data type for col4 is `INT`. Because `NOT NULL` is configured on col4 as well, it cannot accept `NULL` values. If the data type for col4 was `TEXT`, for example, the result would have been an insert of `''`. |
| `INSERT INTO t1 VALUES (1,1,NULL,1,1)`                                                                                            | col3 is`NULL DEFAULT 1,`and this is an explicit insert. `NULL` is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `INSERT INTO t1 (col1,col2,col4,col5) VALUES (1,1,1,1)`                                                                           | col3 is `NULL DEFAULT 1`. This is an implicit insert, and a default expression is specified, so 1 is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `INSERT INTO t1 VALUES (1,1,1,NULL,1)`                                                                                            | col4 is `NOT NULL DEFAULT 1`, and this is an explicit insert. Therefore, a “null mismatch” event occurs. In this particular case, since the data type for col4 is INT, the result is an error. If the data type for col4 was TEXT, for example, the result would have been an insert of `''`.                                                                                                                                                                                                                                                                                                                                                                                                    |
| `INSERT INTO t1 (col1,col2,col3,col5) VALUES (1,1,1,1)`                                                                           | col4 is `NOT NULL DEFAULT 1`, and this is an implicit insert. Therefore, the default expression is used, and 1 is inserted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| `INSERT INTO t1 VALUES (1,1,1,1,NULL)`<br><br>`INSERT INTO t1 (col1,col2,col3,col4) VALUES (1,1,1,1)` | The nullability and default expression for col5 were not specified. In this case, Firebolt treats col5 as `NOT NULL DEFAULT NULL`.</p><p>For the explicit insert, Firebolt attempts to insert NULL into a NOT NULL int column, and a “null mismatch” event results.<br><br>For the implicit insert, Firebolt resorts to the default, and again, attempts to insert NULL. Similar to the explicit NULL case - an empty value `''` is inserted.                                                                                                                                                                                                                        |

### PRIMARY INDEX

The `PRIMARY INDEX` is a sparse index containing sorted data based on the indexed field. This index clusters and sorts data as it is ingested, without affecting data scan performance. A `PRIMARY INDEX` is required for `FACT` tables and optional for `DIMENSION` tables. For more information, see [Using primary indexes](../../using-indexes/using-primary-indexes.md).

#### Syntax&ndash;primary index
{: .no_toc}

```sql
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
```

The following table describes the primary index parameters:

| Parameter.      | Description                                                                                                                                  | Mandatory? |
| :--------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- | :---------- |
| `<column_name>` | Specifies the name of the column in the Firebolt table which composes the index. At least one column must be used for configuring the index. | Y          |

### PARTITION BY

The `PARTITION BY` clause specifies a column or columns by which the table will be split into physical parts. Those columns are considered to be the partition key of the table. Columns must be non-nullable. When the partition key is set with multiple columns, all columns are used as the partition boundaries.

```sql
PARTITION BY <column_name>[, <column_name>[, ...n]]
```

For more information, see [Working with partitions](../../working-with-partitions.md).
