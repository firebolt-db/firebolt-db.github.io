---
layout: default
title: Data types
description: Provides the SQL data types available in Firebolt.
nav_order: 1
parent: General reference
---

# Data types
{:.no_toc}

This topic lists the data types available in Firebolt.

* Topic ToC
{:toc}


## Numeric

### INTEGER
A whole number ranging from -2,147,483,648 to 2,147,483,647. `INTEGER` data types require 4 bytes of storage.
Synonyms: `INT`, `INT4`.

### NUMERIC
An exact numeric data type defined by its precision (total number of digits) and scale (number of digits to the right of the decimal point). For more information, see [NUMERIC data type](numeric-data-type.md). 
Synonyms: `DECIMAL`.

### BIGINT
A whole number ranging from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807. `BIGINT` data types require 8 bytes of storage.
Synonyms: `LONG`, `INT8`.

### REAL
A floating-point number that has six decimal-digit precision. Decimal (fixed point) types are not supported. `REAL` data types require 4 bytes of storage.
Synonyms: `FLOAT`, `FLOAT4`.

### DOUBLE PRECISION
A floating-point number that has 15 decimal-digit precision. Decimal (fixed point) types are not supported. `DOUBLE` data types require 8 bytes.
Synonyms: `DOUBLE`, `FLOAT8`, `FLOAT(p)` where 25 <= p <= 53.

## String

### TEXT
A string of an arbitrary length that can contain any number of bytes, including null bytes. Useful for arbitrary-length string columns. Firebolt supports UTF-8 escape sequences.
Synonyms: `STRING`, `VARCHAR`

## Date and timestamp

{: .warning}
  >You are looking at the documentation for Firebolt's redesigned date and timestamp types.
  >These types were introduced in DB version 3.19 under the names `PGDATE`, `TIMESTAMPNTZ` and `TIMESTAMPTZ`, and synonyms `DATE`, `TIMESTAMP` and `TIMESTAMPTZ` made available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns a result, you are using the redesigned date and timestamp types and can continue with this documentation.
  >If this query returns an error, you are using the legacy date and timestamp types and can find [legacy documentation here](legacy-date-timestamp.md), or instructions to reingest your data to use the new types [here](../release-notes/release-notes-archive.html#db-version-322).

Firebolt supports three date and timestamp data types:

| Name          | Size    | Minimum                          | Maximum                          | Resolution    |
| :------------ | :------ | :------------------------------- | :------------------------------- | :------------ |
| `DATE`        | 4 bytes | `0001-01-01`                     | `9999-12-31`                     | 1 day         |
| `TIMESTAMP`   | 8 bytes | `0001-01-01 00:00:00.000000`     | `9999-12-31 23:59:59.999999`     | 1 microsecond |
| `TIMESTAMPTZ` | 8 bytes | `0001-01-01 00:00:00.000000 UTC` | `9999-12-31 23:59:59.999999 UTC` | 1 microsecond |

Dates are counted according to the [proleptic Gregorian calendar](https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar).
Each year consists of 365 days, with leap days added to February in leap years.

### DATE

A year, month, and day calendar date independent of a time zone. For more information, see [DATE data type](date-data-type.md).

### TIMESTAMP

A year, month, day, hour, minute, second, and microsecond timestamp independent of a time zone. For more information, see [TIMESTAMP data type](timestampntz-data-type.md).

### TIMESTAMPTZ

A year, month, day, hour, minute, second, and microsecond timestamp associated with a time zone. For more information, see [TIMESTAMPTZ data type](timestamptz-data-type.md).

## Boolean

### BOOLEAN
Represents boolean value of `TRUE` or `FALSE`.
Synonyms: `BOOL`

## Composite

### ARRAY
Represents an array of values. All elements of the array must have same data type. Elements of the array can be of any supported data type including nested arrays (array with arrays).

Array columns must be defined with the data type of the array elements, and optionally whether or not those elements are nullable. The following syntax options are supported: 

* `ARRAY(<data-type> [NULL | NOT NULL])`
* `<data-type> ARRAY`
* `<data-type>[]`

For example, the following three queries will create tables with the same nullable `demo_array` column of `TEXT` elements: 

  ```sql
  CREATE DIMENSION TABLE demo1 (
  demo_array ARRAY(TEXT NULL) 
  );
  
  CREATE DIMENSION TABLE demo2 (
  demo_array TEXT[]
  );

  CREATE DIMENSION TABLE demo3 (
  demo_array TEXT ARRAY 
  );
  ```

  You can also specify that an array be NOT NULL, but you must then use the `ARRAY(<data-type> NOT NULL)` syntax.

#### Example
{: .no_toc}

The following `CREATE TABLE` statement shows arrays of different element types and different nullabilities.
```sql
CREATE DIMENSION TABLE demo (
  a_t ARRAY(TEXT NULL) NULL,
  a_i ARRAY(INT NULL) NOT NULL,
  a_d ARRAY(DATE NOT NULL) NULL,
  a_f ARRAY(FLOAT NOT NULL) NOT NULL,
  a_a ARRAY(ARRAY(INT NULL) NULL) NULL
);
```
And the following `INSERT INTO` statement demonstrates examples of values for these arrays:

```sql
INSERT INTO demo VALUES
  (
    ['Hello', NULL, 'world'],
    [1, 42, NULL],
    [DATE '2000-01-01'],
    [3.14, 2.71, 9.8],
    [ [1, 2], [NULL], NULL]
  ),
  (
    NULL,
    [],
    NULL,
    [],
    NULL
  )
```

## Binary

### BYTEA
Represents variable size binary data. A binary string is a sequence of bytes - unlike TEXT, there is no character set. The `BYTEA` data type is nullable.
For more information, see [BYTEA data type](bytea-data-type.md).
