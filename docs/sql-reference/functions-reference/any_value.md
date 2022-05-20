---
layout: default
title: ANY_VALUE
description: Reference material for ANY_VALUE
parent: SQL functions
---

# ANY_VALUE

Returns a single arbitrary value from the specified column. This function ignores `NULL`s, so the only time it will return `NULL` is when all inputs are `NULL`s.

## Syntax
{: .no_toc}


```SQL
ANY_VALUE(<col>)
```

| Argument | Description                                  | Data Type |
| :-------- | :-------------------------------------------- | :--------- |
| `<col>`  | The column from which the value is returned. | Any       |

##### Return Type
{: .no_toc}

Same as input argument

## Example
{: .no_toc}

Consider a table, `example_table`, with a single column `first_name` as shown below.

```
+------------+
| first_name |
+------------+
| Sammy      |
| NULL       |
| Carol      |
| Lei        |
| Mickey     |
+------------+
```

The first time the query below runs, `Carol` might be returned. The second time the query runs, `Carol` or any other value, such as `Lei` or `Sammy`, might be returned, but `NULL` will never be returned.

```sql
SELECT
	ANY_VALUE(first_name)
FROM
	example_table;
```
