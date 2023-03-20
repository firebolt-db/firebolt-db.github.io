---
layout: default
title: CEIL, CEILING
description: Reference material for CEIL, CEILING functions
parent: SQL functions
---

# CEIL, CEILING

Returns the smallest integer value that is greater than or equal to `<value>`.

## Syntax
{: .no_toc}

```sql
CEIL(<value>); 
```
OR 
```sql
CEILING(<value>);
```

| Parameter | Description                                                                                                                               | Supported input types                                                          |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------- |:-------------------------------------------------------------------------------|
| `<value>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.                       | Any of the [numeric data types](../../general-reference/data-types.md#numeric) |

## Return Types

Same as the input datatype (`<value>`).

## Remarks
{: .no_toc}

When the input is of type `NUMERIC`, this function throws an overflow error if the result does not fit into the return type.

For example:
```sql
SELECT
    CEIL('99.99'::NUMERIC(4,2));
```

returns: `OVERFLOW ERROR`, because `CEIL` will produce the value 100, but it can not fit into the `NUMERIC` type with only 2 whole digits.


## Examples
{: .no_toc}

```sql
SELECT
    CEIL(2.5549900);
```

**Returns**: `3`

```sql
SELECT
    CEIL('213.1549'::NUMERIC(20,4));
```

**Returns**: `214.0000`
