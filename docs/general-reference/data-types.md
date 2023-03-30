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

## Date and time

Firebolt supports five date- and time-related data types:

| Name                 | Size    | Minimum                          | Maximum                          | Resolution    |
| :------------------- | :------ | :------------------------------- | :------------------------------- | :------------ |
| `PGDATE`             | 4 bytes | `0001-01-01`                     | `9999-12-31`                     | 1 day         |
| `TIMESTAMPNTZ`       | 8 bytes | `0001-01-01 00:00:00.000000`     | `9999-12-31 23:59:59.999999`     | 1 microsecond |
| `TIMESTAMPTZ`        | 8 bytes | `0001-01-01 00:00:00.000000 UTC` | `9999-12-31 23:59:59.999999 UTC` | 1 microsecond |
| `DATE` (legacy)      | 2 bytes | `1970-01-01`                     | `2105-12-31`                     | 1 day         |
| `TIMESTAMP` (legacy) | 4 bytes | `1970-01-01 00:00:00`            | `2105-12-31 23:59.59`            | 1 second      |

Dates are counted according to the [proleptic Gregorian calendar](https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar).
Each year consists of 365 days, with leap days added to February in leap years.

### PGDATE

A year, month, and day calendar date independent of a time zone. For more information, see [PGDATE data type](date-data-type.md).

### TIMESTAMPNTZ

A year, month, day, hour, minute, second, and microsecond timestamp independent of a time zone. For more information, see [TIMESTAMPNTZ data type](timestampntz-data-type.md).

### TIMESTAMPTZ

A year, month, day, hour, minute, second, and microsecond timestamp associated with a time zone. For more information, see [TIMESTAMPTZ data type](timestamptz-data-type.md).

### DATE (legacy)

A year, month and day in the format *YYYY-MM-DD*. `DATE` is independent of a time zone. 

{: .caution}
`DATE` (legacy) is planned for deprecation. Using the `PGDATE` type is recommended.

Arithmetic operations can be executed on `DATE` values. The examples below show the addition and subtraction of integers.

`CAST(‘2019-07-31' AS DATE) + 4`

Returns: `2019-08-04`

`CAST(‘2019-07-31' AS DATE) - 4`

Returns: `2019-07-27`

#### Working with dates outside the allowed range
{:.no_toc}
Arithmetic, conditional, and comparative operations are not supported for date values outside the supported range. These operations return inaccurate results because they are based on the minimum and maximum dates in the range rather than the actual dates provided or expected to be returned. `PGDATE` data type has a much wider range, and we recommend using this type instead. 

The arithmetic operations in the examples below return inaccurate results as shown because the dates returned are outside the supported range.  

`CAST ('1970-02-02' AS DATE) - 365`  
Returns `1970-01-31`  

`CAST ('2105-02-012' AS DATE) + 365`  
Returns `2105-12-31`  

If you work with dates outside the supported range, we recommend that you use a string datatype such as `TEXT`. For example, the following query returns all rows with the date `1921-12-31`.

```sql
SELECT
  *
FROM
  tab1text
WHERE
  date_as_text = '1921-12-31';
```

The example below selects all rows where the `date_as_text` column specifies a date after `1921-12-31`.

```sql
SELECT
  *
FROM
  tab1text
WHERE
  date_as_text > '1921-12-31';
```

The example below generates a count of how many rows in `date_as_text` are from each month of the year. It uses `SUBSTR` to extract the month value from the date string, and then it groups the count by month.

```sql
SELECT
  COUNT(), SUBSTR(date_as_text,6,2)
FROM
  tab1text
GROUP BY
  SUBSTR(date_as_text,6,2);
```
### TIMESTAMP (legacy)

A year, month, day, hour, minute and second in the format *YYYY-MM-DD hh:mm:ss*.

{: .caution}
`TIMESTAMP` (legacy) is planned for deprecation. Using the `TIMESTAMPNTZ` type is recommended.

The minimum `TIMESTAMP` value is `1970-01-01 00:00:00`. The maximum `TIMESTAMP` value is `2105-12-31 23:59.59`

Synonyms: `DATETIME`

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
