---
layout: default
title: ARRAY_UNIQ
description: Reference material for ARRAY_UNIQ function
parent: SQL functions
---

# ARRAY\_UNIQ

Returns the number of different elements in the array if one argument is passed. If multiple arguments are passed, returns the number of different tuples of elements at corresponding positions in multiple arrays.

## Syntax
{: .no_toc}

```sql
ARRAY_UNIQ(<array> [, ...n])
```
## Parameters 
{: .no_toc}

| Parameter        | Description                         | Supported input types 
| :---------------- | :----------------------------------- | :-------| 
| `<array> [, ...n]` | The array or arrays to be analyzed. | Any `ARRAY` type | 

## Return Type
`INTEGER`

## Example
{: .no_toc}

```sql
SELECT
	ARRAY_UNIQ([ 1, 2, 4, 5 ]) AS res;
```

**Returns**: `4`

## Example&ndash;using multiple arrays
{: .no_toc}

When using multiple arrays, `ARRAY_UNIQ` evaluates all the elements at a specific index as tuples for counting the unique values.&#x20;

For example, two arrays \[1,1,1,1] and \[1,1,1,2] would be evaluated as individual tuples (1,1), (1,1), (1,1), and (1,2). There are 2 unique tuples, so `ARRAY_UNIQ` would return a value of 2.

```sql
SELECT
	ARRAY_UNIQ ([ 1, 1, 1, 1 ], [ 1, 1, 1, 2 ]) AS levels;
```

**Returns**: `2`

In the example below, there are three different usernames across all of the elements of the given arrays. However, there are only two unique tuples, ('tonytaylor', 'ruthgill') and ('tonytaylor', 'ywilson').

```sql
SELECT
	ARRAY_UNIQ (
		[ 'tonytaylor',
		'tonytaylor',
		'tonytaylor',
		'tonytaylor' ],
		[ 'ruthgill',
		'ruthgill',
		'ywilson',
		'ywilson' ]
	) AS res;
```

**Returns**: `2`
