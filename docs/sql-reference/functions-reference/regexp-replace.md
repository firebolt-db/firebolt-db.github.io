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

```sql
REGEXP_REPLACE_ALL(<input>, <pattern>, <replacement>)
```



| Parameter   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<input>`  | The string to search for a matching pattern                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `<pattern>` | An [RE2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string input.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `<replacement>`    | The string to replace the matching pattern found in the input. This argument can include the following special sequences: <br>* `\&` - Specifies the input substring matching the entire pattern should be replaced.<br>* `\n` - Where n is a digit from 1 to 9, specifies the input pattern matching the nth subexpression of the pattern should be replaced<br>* `\\` - results in a single \<br>* `\c` - Specifies for any other character, c results in the same sequence \c<br>Note, that for string literals the above escaping rules apply *after* string literals escaping rules for `\`. See examples below. |

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

