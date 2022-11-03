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

### INT
A whole number ranging from -2,147,483,648 to 2,147,483,647. `INT` data types require 4 bytes of storage.
Synonyms: `INTEGER`, `INT4`.

### DECIMAL
An exact numeric data type defined by its precision (total number of digits) and scale (number of digits to the right of the decimal point). For more information, see [DECIMAL data type](decimal-data-type.md).

### BIGINT
A whole number ranging from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807. `BIGINT` data types require 8 bytes of storage.
Synonyms: `LONG`, `INT8`.

### FLOAT
A floating-point number that has six decimal-digit precision. Decimal (fixed point) types are not supported. `FLOAT` data types require 4 bytes of storage.
Synonyms: `REAL`, `FLOAT4`, `FLOAT(p)` where 1 <= p <= 24.

### DOUBLE
A floating-point number that has 15 decimal-digit precision. Decimal (fixed point) types are not supported. `DOUBLE` data types require 8 bytes.
Synonyms: `DOUBLE PRECISION`, `FLOAT8`, `FLOAT(p)` where 25 <= p <= 53.

## String

### TEXT
A string of an arbitrary length that can contain any number of bytes, including null bytes. Useful for arbitrary-length string columns. Firebolt supports UTF-8 escape sequences.
Synonyms: `STRING`, `VARCHAR`

## Date and time

### DATE
A year, month and day in the format *YYYY-MM-DD*. The minimum `DATE` value is `1970-01-01`. The maximum `DATE` value is `2105-12-31`. It does not specify a time zone.

Arithmetic operations can be executed on `DATE` values. The examples below show the addition and subtraction of integers.

`CAST(‘2019-07-31' AS DATE) + 4`

Returns: `2019-08-04`

`CAST(‘2019-07-31' AS DATE) - 4`
Returns: `2019-07-27`

#### Working with dates outside the allowed range
{:.no_toc}
Arithmetic, conditional, and comparative operations are not supported for date values outside the supported range. These operations return inaccurate results because they are based on the minimum and maximum dates in the range rather than the actual dates provided or expected to be returned.  

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
### TIMESTAMP

A year, month, day, hour, minute and second in the format *YYYY-MM-DD hh:mm:ss*.

The minimum `TIMESTAMP` value is `1970-01-01 00:00:00`. The maximum `TIMESTAMP` value is `2105-12-31 23:59.59`

Synonyms: `DATETIME`

## Boolean

### BOOLEAN
Represents boolean value of `TRUE` or `FALSE`.
Synonyms: `BOOL`

## Composite

### ARRAY
Represents an array of values. All elements of the array must have same data type. Elements of the array can be of any supported data type including nested arrays (array with arrays).

A column whose type is `ARRAY` can't be nullable, but the elements of an `ARRAY` can be nullable.

For example, the following is an illegal type definition:

`array_with_null ARRAY(INT) NULL`

This, on the other hand, is a valid definition:

`nullElements ARRAY(INT NULL)`
