---
layout: default
title: REGEXP_LIKE
description: Reference material for REGEXP_LIKE function
parent: SQL functions
---

# REGEXP\_LIKE

This check whether a string pattern matches a regular expression string. Returns `0` if it doesn’t match, or `1` if it matches.  This is a RE2 regular expression.

## Syntax
{: .no_toc}

```sql
REGEXP_LIKE(<string>, '<pattern>'[,'<flag>[...]'])
```

| Parameter   | Description                                               |
| :----------- | :--------------------------------------------------------- |
| `<string>`  | The string searched for a match using the RE2 pattern.    |
| `<pattern>` | An [re2 regular expression](https://github.com/google/re2/wiki/Syntax) used to search for a match in the `<string>`. |
| `<flag>` | Optional. Flags allow additional controls over characters used in the regular expression matching. If using multiple flags, you can include them in the same single-quote block without any separator character.<br>Firebolt supports the re2 flags listed in [REGEXP_MATCHES](#regexp-matches) to override default matching behavior. |

## Example
{: .no_toc}

```sql
SELECT
    REGEXP_LIKE('123','[a-z]') AS res;
```

**Returns**: `0`

```sql
SELECT
    REGEXP_LIKE('123','\\d+') AS res;
```

**Returns**: `1`

## Example&ndash;using flags

The `i` flag causes the regular expression to be case insensitive. Without this flag, this query would not match and return `0`.

```sql
SELECT
	REGEXP_MATCHES('ABC', '[a-z]', 'i');
```

**Returns**: `1`
