---
layout: default
title: LOWER
description: Reference material for LOWER function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).
# LOWER

Converts the input string to lowercase characters.

## Syntax
{: .no_toc}

```sql
LOWER(<expression>)
```
## Parameters 
{: .no_toc}

| Parameter  | Description                 |Supported input types | 
| :---------- | :--------------------------- | :-----------------|
| `<expression>` | The string to be converted to lowercase characters. | `TEXT` |

## Return Type
`TEXT` 

## Example
{: .no_toc}

The following example converts a game player's username from uppercase to lowercase characters:

```sql
SELECT
	LOWER('ESIMPSON') as username
```

**Returns**: `esimpson`
