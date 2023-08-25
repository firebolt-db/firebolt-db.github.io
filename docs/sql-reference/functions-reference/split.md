---
layout: default
title: SPLIT
description: Reference material for SPLIT function
parent: SQL functions
---

# SPLIT

This function splits a given string by a given separator and returns the result in an array of strings.

## Syntax
{: .no_toc}

```sql
SPLIT( <delimiter>, <string> )
```
## Parameters 
{: .no_toc}

| Parameter     | Description                           |
| :------------- | :------------------------------------- |
| `<delimiter>` | The separator to split the string by. |
| `<string>`    | The string to split.                  |

## Return Types
`ARRAY TEXT`

## Example
{: .no_toc}

The following example splits the nicknames of players into separate items in an array: 
```sql
SELECT
	SPLIT('|','stephen70|esimpson|ruthgill|') AS nicknames;
```

**Returns**: `["stephen70","esimpson","ruthgill"]`
