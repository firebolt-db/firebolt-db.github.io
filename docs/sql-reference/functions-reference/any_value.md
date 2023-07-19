---
layout: default
title: ANY_VALUE
description: Reference material for ANY_VALUE
parent: SQL functions
---

# ANY_VALUE

Returns a single arbitrary value from the specified column. 

**Synonym:** `ANY`

## Syntax
{: .no_toc}

```SQL
ANY_VALUE(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                                  |Supported input types |
| :-------- | :-------------------------------------------- | :--------- |
| `<expression>`  | The column from which the value is returned. | Any       |

This function ignores `NULL` inputs, so the only time `NULL` will return is when all inputs are `NULL`.

### Return Type
{: .no_toc}

Same as input type

## Example
{: .no_toc}

Consider a table, `players`, with a single column `nickname` as shown below. This table displays the nicknames for users playing a specific video game. 


| nickname     |
|:-------------|
| kennethpark  |
| NULL         |
| sabrina21    |
| ruthgill     |
| steven70     |


The first time the query below runs, the nickname `kennethpark` might be returned. The second time the query runs, `sabrina21` or any other value, such as `ruthgill` or `steven70`, might be returned, but `NULL` will never be returned.

```sql
SELECT
	ANY_VALUE(nickname)
FROM
	players;
```
