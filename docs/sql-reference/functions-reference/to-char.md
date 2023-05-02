---
layout: default
title: TO_CHAR (legacy)
description: Reference material for TO_CHAR (legacy) function
nav_exclude: true
parent: SQL functions
---

# TO_CHAR (legacy)

{: .warning}
  >You are looking at legacy documentation for Firebolt's deprecated date and timestamp type functions.
  >New types were introduced in DB version 3.19 under the names `PGDATE` and `TIMESTAMPNTZ`, and made generally available in DB version 3.22.
  >
  >If you worked with Firebolt before DB version 3.22, you might still be using the legacy date and timestamp types.
  >Determine which types you are using by executing the query `SELECT EXTRACT(CENTURY FROM DATE '2023-03-16');`.
  >If this query returns an error, you are still using the legacy date and timestamp types and can continue with this documentation, or find instructions to use the new types [here](../../release-notes/release-notes.md#date-and-timestamp-names-available-for-new-data-types).
  >If this query returns a result, you are already using the redesigned date and timestamp types and can use the [TO_CHAR](./to-char-new.md) function instead.

Converts a `TIMESTAMP` data type to a formatted string.

## Syntax

```sql
TO_CHAR(<expression>[, '<format>'])
```

|   Parameter   |                       Description                          |
| :-------------| :---------------------------------------------------------|                           
|  `<expression>`   | An expression that resolves to a value with a `TIMESTAMP` data type, which will be converted to text. |
|  `<format>`   | One or more optional format element(s) for datetime values. |                       

For descriptions of the accepted `<format>` options, see below.

| Format option |                  Description                   |
|:--------------|:-----------------------------------------------|
| HH24          | Hour of day (0-23).                            |
| MI            | Minute (0-59).                                 |
| YYYY          | 4-digit year.                                  |
| Q             | Quarter of year (1-4; January - March = 1).    |
| SS            | Second (0-59).                                 |
| Day           | Name of day.                                   |
| Month         | Name of month.                                 |
| DDD           | Day of year (1-366).                           |
| DD            | Day of month (1-31).                           |
| D             | Day of week (1-7).                             |
| IYYY          | 4-digit year based on the ISO standard.        |
| IY            | Last 2 digits of ISO year.                     |
| YY            | Last 2 digits of year.                         |
| ID            | Day of week (1-7) based on the ISO standard.   |
| IW            | Week of year (1-53) based on the ISO standard. |

## Examples

The examples below use a table, `time_test`, with the columns and values below.

```
CREATE FACT TABLE time_test (
    id TEXT,
    order_time DATETIME
    )
    PRIMARY INDEX id;

INSERT INTO time_test VALUES
    ('1', '2017-06-15 09:34:21'),
    ('2', '2014-01-15 12:14:46'),
    ('3', '1999-09-15 11:33:21');
```

The example below shows output for `<format>` expressions for `HH24`, `MI`, `YYYY`, `Q`, and `SS`.

```
SELECT
    id,
    order_time,
    TO_CHAR(order_time, 'HH24') as HH24,
    TO_CHAR(order_time, 'MI') as MI,
    TO_CHAR(order_time, 'YYYY') as YYYY,
    TO_CHAR(order_time, 'Q') as Q,
    TO_CHAR(order_time, 'SS') as SS
FROM
    time_test
ORDER BY
    id;
```

**Returns**

```
+----+---------------------+------+----+------+---+----+
| id |     order_time      | HH24 | MI | YYYY | Q | SS |
+----+---------------------+------+----+------+---+----+
|  1 | 2017-06-15 09:34:21 |   09 | 34 | 2017 | 2 | 21 |
|  2 | 2014-01-15 12:14:46 |   12 | 14 | 2014 | 1 | 46 |
|  3 | 1999-09-15 11:33:21 |   11 | 33 | 1999 | 3 | 21 |
+----+---------------------+------+----+------+---+----+
```


The example below shows output for `<format>` expressions for `Day`, `Month`, `DDD`, `DD`, and `D`.

```
SELECT
    id,
    order_time,
    TO_CHAR(order_time, 'Day') as Day,
    TO_CHAR(order_time, 'Month') as Month,
    TO_CHAR(order_time, 'DDD') as DDD,
    TO_CHAR(order_time, 'DD') as DD,
    TO_CHAR(order_time, 'D') as D
FROM
    time_test
ORDER BY
    id;
```

**Returns**

```
+----+---------------------+-----------+-----------+-----+----+---+
| id |     order_time      |    Day    |   Month   | DDD | DD | D |
+----+---------------------+-----------+-----------+-----+----+---+
|  1 | 2017-06-15 09:34:21 | Thursday  | June      | 166 | 15 | 5 |
|  2 | 2014-01-15 12:14:46 | Wednesday | January   | 015 | 15 | 4 |
|  3 | 1999-09-15 11:33:21 | Wednesday | September | 258 | 15 | 4 |
+----+---------------------+-----------+-----------+-----+----+---+
```

The example below shows output for `<format>` expressions for `IYYY`, `IY`, `YY`, `ID`, and `IW`.

```
SELECT
    id,
    order_time,
    TO_CHAR(order_time, 'IYYY') as IYYY,
    TO_CHAR(order_time, 'IY') as IY,
    TO_CHAR(order_time, 'YY') as YY,
    TO_CHAR(order_time, 'ID') as ID,
    TO_CHAR(order_time, 'IW') as IW
FROM
    time_test
ORDER BY
    id;
```
**Returns**

```
+----+---------------------+------+----+----+----+----+
| id |     order_time      | IYYY | IY | YY | ID | IW |
+----+---------------------+------+----+----+----+----+
|  1 | 2017-06-15 09:34:21 | 2017 | 17 | 17 |  4 | 24 |
|  2 | 2014-01-15 12:14:46 | 2014 | 14 | 14 |  3 | 03 |
|  3 | 1999-09-15 11:33:21 | 1999 | 99 | 99 |  3 | 37 |
+----+---------------------+------+----+----+----+----+
```