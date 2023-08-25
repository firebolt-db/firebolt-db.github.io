---
layout: default
title: REPEAT
description: Reference material for REPEAT function
parent: SQL functions
---

# REPEAT

Repeats the provided string a requested number of times.

## Syntax
{: .no_toc}

```sql
REPEAT(<expression>, <value>)
```

## Parameters 
{: .no_toc}

| Parameter            | Description                  | Supported input types | 
| :-------------------- | :---------------------------|:----------------------|
| `<expression>`           | The string to be repeated | `TEXT`           |
| `<value>` | The number of needed repetitions | Any `INTEGER` greater than 0 |

## Return Type
`TEXT`

## Example
{: .no_toc}

The following example returns the author of a game 5 times repeated. 

```sql
SELECT
	REPEAT('UFG Inc.' , 5);
```

**Returns**: `UFG Inc. UFG Inc. UFG Inc. UFG Inc. UFG Inc.`
