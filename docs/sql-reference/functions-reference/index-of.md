---
layout: default
title: INDEX_OF
description: Reference material for INDEX_OF function
parent: SQL functions
---

# INDEX\_OF

Returns the index position of the first occurrence of the element in the array (or `0` if not found).

## Syntax
{: .no_toc}

```sql
INDEX_OF(<array>, <value>)
```

## Parameters
{: .no_toc}

| Parameter | Description                                       | Supported input types | 
| :--------- | :------------------------------------------------- | :----------|
| `<array>`   | The array to be analyzed                         | `ARRAY` | 
| `<value>`     | The element from the array that is to be matched | Any integer that corresponds to an element in the array | 

## Return Type
`INTEGER` 

## Example
{: .no_toc}
The following example returns the index position of the 5 in the `levels` array:

```sql
SELECT
	INDEX_OF([ 1, 3, 4, 5, 7 ], 5) AS levels;
```

**Returns**: `4`
