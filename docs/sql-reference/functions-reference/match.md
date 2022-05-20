---
layout: default
title: MATCH
description: Reference material for MATCH function
parent: SQL functions
---

# MATCH

Checks whether the string matches the regular expression `<pattern`>, which is a RE2 regular expression.  Returns `0` if it doesn’t match, or `1` if it matches.

## Syntax
{: .no_toc}

```sql
MATCH(<string>, '<pattern>')
```

| Parameter   | Description                                                           |
| :----------- | :--------------------------------------------------------------------- |
| `<string>`  | The string used to search for a match.                                |
| `<pattern>` | The regular expression pattern used to search `<string>` for a match. |

## Example
{: .no_toc}

The example below generates `0` as a result because it found no match. It is searching a string of numbers for alphabet characters.\*\* \*\*

```sql
SELECT
	MATCH('123','\\[a-Z|A-Z]') AS res;
```

**Returns**: `0`

In this second example, the `MATCH` expression generates a result of `1` because it found a match. It is searching for numeric digits in the string "123".

```sql
SELECT
	MATCH('123','\\d+');
```

**Returns**: `1`
