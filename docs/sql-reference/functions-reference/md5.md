---
layout: default
title: MD5
description: Reference material for MD5 function
parent: SQL functions
---

# MD5

Calculates the MD5 hash of string, returning the result as a string in hexadecimal.

## Syntax
{: .no_toc}

```sql
MD5(<expression>)
```
## Parameters 
{: .no_toc}

| Parameter   | Description |Supported input types |
| :----------- | :----------------------------------------- | :---------------------|
| `<expression>` | The string to hash. | `TEXT` |

## Return Types

* Returns `TEXT` with string input
* Returns `NULL` if input is `NULL`

## Example
{: .no_toc}

The following example returns the username `esimpson` in hexadecimal: 

```sql
SELECT
	MD5('esimpson') AS username;
```

**Returns**: `c14fa496dfd5ebbb08aaca16a7c2781b`
