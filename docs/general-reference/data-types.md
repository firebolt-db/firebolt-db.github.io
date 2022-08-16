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
Synonym for `INTEGER`.

### INTEGER
Synonym for `INT`.

### DECIMAL
Signed fixed-point numbers that keep precision during add, subtract and multiply operations. For division least significant digits are discarded (not rounded).

Numeric/Decimal can be up to 76 digits, with an optional precision and scale:

- Precision: Total number of digits allowed (default = 38, max = 76)

- Scale: Number of digits allowed to the right of the decimal point (default = 0)

#### Parameters
{:.no_toc} 
P - precision. Valid range: [ 1 : 76 ]. Determines how many decimal digits number can have (including fraction).

S - scale. Valid range: [ 0 : P ]. Determines how many decimal digits fraction can have.
Depending on P parameter value Decimal(P, S) is a synonym for:

P from [ 1 : 9 ] - for Decimal32(S)

P from [ 10 : 18 ] - for Decimal64(S)

P from [ 19 : 38 ] - for Decimal128(S)

P from [ 39 : 76 ] - for Decimal256(S)

#### Decimal Value Ranges 
Decimal32(S) - ( -1 * 10^(9 - S), 1 * 10^(9 - S) )
Decimal64(S) - ( -1 * 10^(18 - S), 1 * 10^(18 - S) )
Decimal128(S) - ( -1 * 10^(38 - S), 1 * 10^(38 - S) )
Decimal256(S) - ( -1 * 10^(76 - S), 1 * 10^(76 - S) )
For example, Decimal32(4) can contain numbers from -99999.9999 to 99999.9999 with 0.0001 step.

#### Overflow Checks 
During calculations on Decimal, integer overflows might happen. Excessive digits in a fraction are discarded (not rounded). Excessive digits in integer part will lead to an exception.


### BIGINT
A whole number ranging from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807. `BIGINT` data types require 8 bytes of storage.
Synonym for `LONG`.

### LONG
Synonym for `BIGINT`.

### FLOAT
A floating-point number that has six decimal-digit precision. Decimal (fixed point) types are not supported. `FLOAT` data types require 4 bytes of storage.

### DOUBLE
A floating-point number that has 15 decimal-digit precision. Decimal (fixed point) types are not supported. `DOUBLE` data types require 8 bytes. Synonym for `DOUBLE PRECISION`.

### DOUBLE PRECISION
Synonym for `DOUBLE`.

## String

### VARCHAR
A string of an arbitrary length that can contain any number of bytes, including null bytes. Useful for arbitrary-length string columns. Firebolt supports UTF-8 escape sequences. Synonym for `TEXT` and `STRING`.

### TEXT
Synonym for `VARCHAR` and `STRING`.

### STRING
Synonym for `VARCHAR` and `TEXT`.

## Date and time

### DATE
A year, month and day in the format *YYYY-MM-DD*. This value is stored as a 4-byte unsigned Unix timestamp. The minimum `DATE` value is `1970-01-01`. The maximum `DATE` value is `2105-12-31`. It does not specify a time zone.

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

A year, month, day, hour, minute and second in the format *YYYY-MM-DD hh:mm:ss*. This value is stored as an unsigned Unix timestamp with 4 bytes.

Same range as `DATE` type.

Minimal value: 1970-01-01 00:00:00.

To change the default time zone in Firebolt:
`SET DEFAULT_TIMEZONE = "Pacific Standard Time"`

This is a synonym for `DATETIME`

### DATETIME

Synonym for `TIMESTAMP`

## Boolean

### BOOLEAN
Accepts `true`, `false`, `1` and `0`. Stores the values as `1` or `0` respectively.

## Semi-structured

### ARRAY
Represents dense or sparse arrays. An array can contain all data types including nested arrays (array with arrays).

A column whose type is `ARRAY` can't be nullable, but the elements of an `ARRAY` are nullable.

For example, the following is an illegal type definition:

`array_with_null ARRAY(INT) NULL`

This, on the other hand, is a valid definition:

`nullElements ARRAY(INT NULL)`
