---
layout: default
title: CONTAINS
description: Reference material for CONTAINS function
parent: SQL functions
---

# CONTAINS

Returns `1` if a specified argument is present in the array, or `0` otherwise.

## Syntax
{: .no_toc}

```sql
CONTAINS(<array>, <value>)
```
## Parameters 
{: .no_toc}

| Parameter | Description                                      | Supported input types | 
| :--------- | :------------------------------------------------ | :--------|
| `<array>`   | The array to be checked for the given element.   | `ARRAY` | 
| `<value>`   | The element to be searched for within the array | Any integer that corresponds to an element in the array | 

## Return Types
* Returns `1` if the element to be searched in present in the array
* Returns `0` if the element is not present in the array

## Example
{: .no_toc}

```sql
SELECT
	CONTAINS([ 'sabrina21', 'rileyjon', 'ywilson', 'danielle53'], 'danielle53') AS players;
```

**Returns**: `1`
`1` is returned as "danielle53" is part of the `players` array.

`CONTAINS` returns a `0` result when single character or substring matches only part of a longer string.

```sql
SELECT
	CONTAINS([ 'sabrina21', 'rileyjon', 'ywilson'] , 'danielle53') AS players;
```

**Returns**: `0` 

`0` is returned as "danielle53" is not part of the `players` array.
