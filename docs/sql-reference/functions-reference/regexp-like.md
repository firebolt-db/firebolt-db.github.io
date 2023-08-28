---
layout: default
title: REGEXP_LIKE
description: Reference material for REGEXP_LIKE function
parent: SQL functions
---

# REGEXP_LIKE

This check whether a text pattern matches a regular expression string. Returns `0` if it doesn’t match, or `1` if it matches. This is a RE2 regular expression.

## Syntax
{: .no_toc}

```sql
REGEXP_LIKE(<expression>, '<pattern>'[,'<flag>[...]'])
```
## Parameters 
{: .no_toc}

| Parameter      | Description    |Supported input types         |
| :------------- | -------------- | :--------------------------- |
| `<expression>` | The text searched for a match using the RE2 pattern.  | `TEXT`  |
| `<pattern>`    | An RE2 regular expression pattern used to search for a match in the `<expression>`.    | [RE2 regular expression](https://github.com/google/re2/wiki/Syntax) |
| `<flag>`  | Optional. Flags allow additional controls over the regular's expression matching behavior. If using multiple flags, you can include them in the same single-quote block without any separator character. | Firebolt supports the following RE2 flags to override default matching behavior. With `-` in front you can disable the flag.<br>* `i` - Specifies case-insensitive matching.<br>* `m` - Specifies multi-line mode. In this mode, `^` and `$` characters in the regex match the beginning and end of line.<br>* `s` - (Enabled per default) Specifies that the `.` metacharacter in regex matches the newline character in addition to any character in `.`<br>* `U` - Specifies non-greedy mode. In this mode, the meaning of the metacharacters `*` and `+` in regex `<pattern>` are swapped with `*?` and `+?`, respectively. See the examples using flags below for the difference in how results are returned. |

## Return Type
`INTEGER` 

## Example
{: .no_toc}

```sql
SELECT
    REGEXP_LIKE('123','[a-z]');
```

**Returns**: `0`

```sql
SELECT
    REGEXP_LIKE('123','\\d+');
```

**Returns**: `1`

## Example using flags

The `i` flag causes the regular expression to be case-insensitive. Without this flag, this query would return `0` as no match is found.

```sql
SELECT
	REGEXP_LIKE('ABC', '[a-z]', 'i');
```

**Returns**: `1`
