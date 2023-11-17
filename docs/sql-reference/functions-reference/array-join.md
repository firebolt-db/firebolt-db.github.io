---
layout: default
title: ARRAY_JOIN
description: Alias for ARRAY_TO_STRING.
parent: SQL functions
---

# ARRAY\_JOIN

Concatenates an array of `TEXT` elements using an optional delimiter. If no delimiter is provided, an empty string is used instead.

**Synonym:** `ARRAY_TO_STRING`

## Syntax
{: .no_toc}

```sql
ARRAY_JOIN(<array>[, <delimiter>])
```

## Parameters 
{: .no_toc} 

| Parameter     | Description                            | Supported input types | 
| :------------- | :------------------------------------ |:---------|
| `<array>`       | An array to be concatenated | `ARRAY TEXT` |
| `<delimiter>` | The delimiter used for concatenating the array elements | `TEXT` | 

## Return Type
`TEXT`

## Example
{: .no_toc}

In the example below, the three elements are concatenated with no delimiter.

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ]) AS levels;
```

**Returns**: `123`

In this example below, the levels are concatenated separated by a comma. 

```sql
SELECT
	ARRAY_JOIN([ '1', '2', '3' ], ',') AS levels;
```

**Returns**: `1,2,3`
