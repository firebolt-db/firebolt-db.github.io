---
layout: default
title: REGEXP_REPLACE
description: Reference material for REGEXP_REPLACE functions
parent: SQL functions
---

# REGEXP\_REPLACE

Matches a pattern in the input string and replaces the first matched portion (from the left) with the specified replacement. 

```sql
REGEXP_REPLACE(<input>, <pattern>, <replacement>)
```

# REGEXP\_REPLACE\_ALL

Matches a pattern in the input string and replaces all matched portions with the specified replacement. 

If any of the arguments to these functions is `NULL`, the return value is `NULL`.

```sql
REGEXP_REPLACE_ALL(<input>, <pattern>, <replacement>)
```



| Parameter   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<input>`  | The string to search for a matching pattern                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `<pattern>` | An [RE2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string input.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `<replacement>`    | The string to replace the matching pattern found in the input. This argument can include the following special sequences: <ul><li> `\&` - To indicate that the substring matching the entire pattern should be inserted.</li><li> `\n` - Where n is a digit from 1 to 9, to indicate that the substring matching the n'th capturing group (parenthesized subexpression) of the pattern should be inserted</li><li> `\\` - results in a single \</li><li> `\c` - Specifies for any other character, c results in the same sequence \c</li></ul><p/>Note, that for string literals the above escaping rules apply *after* string literals escaping rules for `\`. See examples below. |

### Return type
`TEXT`

## Example
{: .no_toc}

```sql
SELECT
	REGEXP_REPLACE('ABC', '^([A-Z]+)');
```
**Returns**: `["ABC"]`

```sql
SELECT
	REGEXP_REPLACE_ALL('ABC', '^([A-Z]+)');
```
**Returns**: `["ABC"]`

