---
layout: default
title: EXTRACT
description: Reference material for EXTRACT function
parent: SQL functions
---

## EXTRACT

Retrieves subfields such as year or hour from date/time values.

##### Syntax
{: .no_toc}

```sql
​​EXTRACT(<field> FROM <source>)​​
```

| Parameter  | Description                                                                                                      |
| :---------- | :---------------------------------------------------------------------------------------------------------------- |
| `<field>`  | Supported fields: `DAY`, `DOW, MONTH`, `WEEK`, `WEEKISO`, `QUARTER`, `YEAR`, `HOUR`, `MINUTE`, `SECOND`, `EPOCH` |
| `<source>` | A value expression of type timestamp.                                                                            |

##### Example
{: .no_toc}

This example below extracts the year from the timestamp. The string date first need to be transformed to `TIMESTAMP` type using the `CAST `function.

```sql
SELECT
	EXTRACT(
		YEAR
		FROM
			CAST('2020-01-01 10:00:00' AS TIMESTAMP)
	);
```

**Returns**: `2020`

## FROM\_UNIXTIME

Convert Unix time (`LONG` in epoch seconds) to `DATETIME` (YYYY-MM-DD HH:mm:ss).

##### Syntax
{: .no_toc}

```sql
​​FROM_UNIXTIME(<unix_time>)​​
```

| Parameter     | Description                                  |
| :------------- | :-------------------------------------------- |
| `<unix_time>` | The UNIX epoch time that is to be converted. |

##### Example
{: .no_toc}

```sql
SELECT
    FROM_UNIXTIME(1493971667);
```

**Returns**: `2017-05-05 08:07:47`
