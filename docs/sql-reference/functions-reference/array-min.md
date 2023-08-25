---
layout: default
title: ARRAY_MIN
description: Reference material for ARRAY_MIN function
parent: SQL functions
---

# ARRAY\_MIN

Returns the minimum element in an array.

## Syntax
{: .no_toc}

```sql
ARRAY_MIN(<array>)
```

## Parameters 
{: .no_toc}

| Parameter | Description                                  | Supported input types | 
| :--------- | :-------------------------------------------- | :----------|
| `<array>`   | The array or array-type column to be checked | `ARRAY` | 


## Return Type
`NUMERIC` 

## Example
{: .no_toc}

The following examples calculates the minimum number in the `levels` array: 
```sql
SELECT
	ARRAY_MIN([ 1, 2, 3, 4 ]) AS levels;
```

**Returns**: `1`
