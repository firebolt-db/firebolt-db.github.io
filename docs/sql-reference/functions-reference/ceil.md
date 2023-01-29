---
layout: default
title: CEIL, CEILING
description: Reference material for CEIL, CEILING functions
parent: SQL functions
---

# CEIL, CEILING

Returns the smallest integral value that is not less than `<val>`.

## Syntax
{: .no_toc}

```sql
CEIL(<val>);
CEILING(<val>);
```

| Parameter | Description                                                                                                                               | Supported input types                       |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------- |:--------------------------------------------|
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.                       | `FLOAT`, `DOUBLE`, `DECIMAL`, `INT`, `LONG` |

## Return Types

Same as the input datatype (`<val>`).

## Remarks
{: .no_toc}

This function can throw overflow error in case of `DECIMAL` as input.

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
