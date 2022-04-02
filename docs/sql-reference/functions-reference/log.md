---
layout: default
title: LOG
description: Reference material for LOG function
parent: SQL functions
---

# LOG

Returns the natural logarithm of a numeric expression based on the desired base.

## Syntax
{: .no_toc}

```sql
LOG([<base>,] <num>);
```

| Parameter   | Description                                                                                                         |
| :----------- | :------------------------------------------------------------------------------------------------------------------- |
| `<base>`    | Optional. The base for the logarithm. The default base is 10.                                                       |
| `<numeric>` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## Example
{: .no_toc}

This example below returns the logarithm of 64.0 with base 2.&#x20;

```sql
SELECT
    LOG(2, 64.0);
```

**Returns**: `6`

This example below returns the logarithm of 64.0 with the default base 10.

```sql
SELECT
    LOG(64.0);
```

**Returns**: `1.8061799739838869`
