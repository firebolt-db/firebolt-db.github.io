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
REGEXP_LIKE(<string>, '<pattern>')
```

| Parameter   | Description                                               |
| :----------- | :--------------------------------------------------------- |
| `<string>`  | The string searched for a match using the RE2 pattern.    |
| `<pattern>` | The pattern used to search for a match in the `<string>`. |

## Example
{: .no_toc}

```sql
SELECT REGEXP_LIKE('123','\\[a-z]') AS res;
```

**Returns**: `0`

```sql
SELECT REGEXP_LIKE('123','\\d+') AS res;
```

**Returns**: `1`
