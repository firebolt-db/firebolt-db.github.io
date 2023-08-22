---
layout: default
title: LENGTH
description: Reference material for LENGTH function
parent: SQL functions
---

# LENGTH

Calculates the length of the input string.

## Syntax
{: .no_toc}

```sql
LENGTH(<expression>)
```
## Parameters 
{: .no_toc}

| Parameter      | Description                                  |Supported input types |
| :--------------| :--------------------------------------------|:----------------------|
| `<expression>` | The string or binary data for which to return the length.   | `TEXT`, `BYTEA`       |

## Return Type
`INTEGER` 

## Example
{: .no_toc}

Use the `LENGTH` to find the length of any string, such as: 

```sql
SELECT LENGTH('The Accelerator Cup')
```
Spaces are included in the calculation of the total length of the string. 

**Returns**: `19`

