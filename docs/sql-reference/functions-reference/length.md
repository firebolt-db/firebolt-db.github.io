---
layout: default
title: LENGTH (array function)
description: Reference material for LENGTH function
parent: SQL functions
---

# LENGTH

Returns the length of (number of elements in) the given array.

## Syntax
{: .no_toc}

```sql
LENGTH(<array>)
```

## Parameters
{: .no_toc}

| Parameter | Description                                       | Supported input types | 
| :--------- | :------------------------------------------------- | :----------|
| `<array>`   | The array to be checked for length. | `ARRAY` |

## Return Type
`INTEGER` 

## Example
{: .no_toc}

```sql
SELECT
	LENGTH([ 1, 2, 3, 4 ]) AS levels;
```

**Returns**: `4`
