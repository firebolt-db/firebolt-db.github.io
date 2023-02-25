---
layout: default
title: REGEXP_MATCHES
description: Reference material for REGEXP_MATCHES function
parent: SQL functions
---

# REGEXP\_MATCHES

Returns an array that contains either the match or all defined subgroups of the first match of the regular expression pattern. 
If the pattern does not match, returns an empty array.

```sql
REGEXP_MATCHES(<expression>, <pattern>[,'<flag>[...]'])
```

| Parameter   | Description |Supported input types |
| :----------- | :----------------------------------------- | :---------------------|
| `<expression>`  | The string from which to extract substrings, based on a regular expression. | `TEXT` |
| `<pattern>` | A [re2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string. | | 
| `<flag>` | Optional. Flags allow additional controls over characters used in the regular expression matching. If using multiple flags, you can include them in the same single-quote block without any separator character. | Firebolt supports the following re2 flags to override default matching behavior. With `-` in front you can disable the flag.<br>* `i` - Specifies case-insensitive matching.<br>* `m` - Specifies multi-line mode. In this mode, `^` and `$` characters in the regex match the beginning and end of line.<br>* `s` - (Enabled per default) Specifies that the `.` metacharacter in regex matches the newline character in addition to any character in `.`<br>* `U` - Specifies Ungreedy mode. In this mode, the meaning of the metacharacters `*` and `+` in regex `<pattern>` are swapped with `*?` and `+?`, respectively. See the examples using flags below for the difference in how results are returned. |

## Return Types
`TEXT`

## Example
{: .no_toc}

```sql
SELECT
	REGEXP_MATCHES('ABC 2023', '^[A-Z]+');
```
**Returns**: `["ABC"]`

```sql
SELECT
	REGEXP_MATCHES('Learning about #REGEX in #Firebolt 2023', '#([A-Za-z]+) (\\d+)');
```
**Returns**: `["Firebolt", "2023"]`

## Example&ndash;using flags

The `i` flag causes the regular expression to be case insensitive. Without this flag, this query would only match and return `ABC`.

```sql
SELECT
	REGEXP_MATCHES('ABCdef', '^([A-Z]+)', 'i');
```

**Returns**: `["ABCdef"]`

The `U` flag causes metacharacters like `+` to return as few characters together as possible. Without this flag, this query would return `["PPL","P"]`.

```sql
SELECT
	REGEXP_MATCHES('aPPLePie', '([A-Z]+)', 'U');
```

**Returns**: `["P","P","L","P"]`

The `s` flag causes that the `.` metacharacter in regex matches the newline character `\n` in addition to any character. This flag is enabled per default and without the disablement by `-s`, this query would return `["Hello\nWorld"]`.

```sql
SELECT
	REGEXP_MATCHES('Hello\nWorld', '.*', '-s');
```

**Returns**: `["Hello"]`