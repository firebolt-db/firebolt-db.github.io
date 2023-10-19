---
layout: default
title: ARRAY_ENUMERATE
description: Reference material for ARRAY_ENUMERATE function
parent: SQL functions
---

# ARRAY\_ENUMERATE

This function takes an array of arbitrary type as input, and produces an integer array of the same length containing increasing numbers.
The returned array starts with value one. Every successive element is incremented by one, it holds that `array[i] = array[i - 1] + 1`.

`NULLs` contained in the parameter array are treated like any other value, and result in a non-null element in the returned array.

If the parameter array is `NULL`, then the function also returns `NULL`.


## Syntax
{: .no_toc}

```sql
ARRAY_ENUMERATE(<array>)
```

## Parameters
{: .no_toc}

| Parameter | Description       | Supported input types | 
| :--------- | :------------------------ | :---------| 
| `<array>`  | The array to be enumerated. The length of the returned array is the same as the length of the parameter array. | Any array type. | 

## Return Type
{: .no_toc}

`ARRAY(INT)`

## Example 
{: .no_toc}

The following example returns an array with values one to four:
```sql
SELECT ARRAY_ENUMERATE([7, 9, 3, 4]) AS one_to_four;
```

**Returns**: `[1, 2, 3, 4]`

The array passed to the function can contain arbitrary types:
```sql
SELECT ARRAY_ENUMERATE(['hello', 'world']) AS one_to_two;
```

**Returns**: `[1, 2]`

`NULL` values are still reflected in the returned result:

```sql
SELECT ARRAY_ENUMERATE([7, NULL, 3, NULL]) AS one_to_four;
```

**Returns**: `[1, 2, 3, 4]`

The function also works with nested arrays, but only the length of the outer array is taken into account:

```sql
SELECT ARRAY_ENUMERATE([[ 7, NULL ], NULL, [ 1, 2 ]]) AS one_to_three;
```

**Returns**: `[1, 2, 3]`

If the array passed to the function is `NULL`, so is the result:

```sql
SELECT ARRAY_ENUMERATE(NULL) AS null_result;
```

**Returns**: `NULL`
