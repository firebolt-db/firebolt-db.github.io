---
layout: default
title: CONTAINS
description: Reference material for the CONTAINS function
parent: SQL functions
---

# CONTAINS

Returns whether the array passed as the first argument contains the value passed as the second argument.

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
| `<value>`   | The element to be searched for within the array | The array elements' type | 

## Return Type
`BOOLEAN`
* Returns `true` if the element to be searched is present in the array
* Returns `false` if the element is not present in the array

## Example
{: .no_toc}

```sql
SELECT
	CONTAINS(['sabrina21', 'rileyjon', 'ywilson', 'danielle53'], 'danielle53');
```

**Returns**: `true` as "danielle53" is part of the array.

`CONTAINS` returns `false` when the value is not contained in the array:

```sql
SELECT
	CONTAINS(['sabrina21', 'rileyjon', 'ywilson'] , 'danielle53');
```

**Returns**: `false` as "danielle53" is not part of the array.
