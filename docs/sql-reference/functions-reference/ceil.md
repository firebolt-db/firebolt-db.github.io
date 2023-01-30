---
layout: default
title: CEIL, CEILING
description: Reference material for CEIL, CEILING functions
parent: SQL functions
---

# CEIL, CEILING

Returns the smallest integer value that is greater than or equal to `<val>`.

## Syntax
{: .no_toc}

```sql
CEIL(<val>);
CEILING(<val>);
```

| Parameter | Description                                                                                                                               | Supported input types                                                          |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------- |:-------------------------------------------------------------------------------|
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.                       | Any of the [numeric data types](../../general-reference/data-types.md#numeric) |

## Return Types

Same as the input datatype (`<val>`).

## Remarks
{: .no_toc}

This function can throw overflow error in case of `DECIMAL` as input.

**eg**:
```sql
SELECT
    CEIL('99.99'::DECIMAL(4,2));
```

**Returns**: OVERFLOW ERROR

**Explain**: ceil will produce the value 100,
but it can not fit into decimal with only 2 whole digits.


## Examples
{: .no_toc}

```sql
SELECT
    CEIL(2.5549900);
```

**Returns**: `3`

```sql
SELECT
    CEIL('213.1549'::decimal(20,4));
```

**Returns**: `214.0000`
