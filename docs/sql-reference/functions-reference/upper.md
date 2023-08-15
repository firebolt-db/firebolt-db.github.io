---
layout: default
title: UPPER
description: Reference material for UPPER function
parent: SQL functions
---

# UPPER

Converts the input string to uppercase characters.

## Syntax
{: .no_toc}

```sql
UPPER(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>` | The string to be converted to uppercase characters. | `TEXT` |

## Return Type
`TEXT` 

## Example
{: .no_toc}

The following example converts a game player's username from lowercase to uppercase characters:

```sql
SELECT
	UPPER('esimpson') as username
```

**Returns**: `ESIMPSON`
