---
layout: default
title: ARRAY_JOIN
description: Reference material for ARRAY_JOIN function
parent: SQL functions
---

# ARRAY\_JOIN

Concatenates an array of `TEXT` elements using an optional delimiter. If no delimiter is provided, an empty string is used instead.

## Syntax
{: .no_toc}

```sql
ARRAY_JOIN(<array>[, <delimiter>])
```

## Parameters 
{: .no_toc} 

| Parameter     | Description                            | Supported input types | 
| :------------- | :------------------------------------ |:---------|
| `<array>`       | An array to be joined | `ARRAY TEXT` |
| `<delimiter>` | The delimiter used for joining the array elements | `TEXT` | 

## Return Type
`TEXT`

## Example
{: .no_toc}

In the example below, the three elements are joined with no delimiter.

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ]) AS levels;
```

**Returns**: `123`

In this example below, the levels are joined separated by a comma. 

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ], ',') AS levels;
```

**Returns**: `1,2,3`
