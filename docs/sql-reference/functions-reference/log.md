---
layout: default
title: LOG
description: Reference material for LOG function
parent: SQL functions
---

# LOG

Returns the common (base 10) logarithm of a numerical expression, or the logarithm to an arbitrary base if specified as the first argument.

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

This example below returns the logarithm of 64.0 to base 2.

```sql
SELECT
    LOG(2, 64.0);
```

**Returns**: `6`

This example below returns the logarithm of 100.0 to the default base 10.

```sql
SELECT
    LOG(100.0);
```

**Returns**: `2`
