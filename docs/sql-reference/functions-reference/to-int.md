---
layout: default
title: TO_INT
description: Reference material for TO_INT function
parent: SQL functions
---

# TO\_INT

Converts a string to an integer.

## Syntax
{: .no_toc}

```sql
TO_INT(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>`  | The string to covert to an integer. | `TEXT` |

## Return Type
`INTEGER` 

## Example
{: .no_toc}

The following example converts the input string to the integer `10`: 

```sql
SELECT
	TO_INT('10');
```

**Returns**: `10`
