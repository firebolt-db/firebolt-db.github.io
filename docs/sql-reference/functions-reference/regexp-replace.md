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



| Parameter   | Data Type | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| :----------- | :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<input>` | `TEXT` | The string to search for a matching pattern                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `<pattern>` | `TEXT` | An [RE2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string input.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `<replacement>` | `TEXT` | The string to replace the matching pattern found in the input. This argument can include the following special sequences: <br>* `\&` - To indicate that the substring matching the entire pattern should be inserted.<br>* `\n` - Where *n* is a digit from 1 to 9, to indicate that the substring matching the n'th capturing group (parenthesized subexpression) of the pattern should be inserted. If pattern doesn't have *n* capturing groups, the `\n` is ignored.<br>* `\\` - results in a single \</li><li> `\c` - Specifies for any other character, c results in the same sequence \c<br> Note, that for string literals the above escaping rules apply *after* string literals escaping rules for `\`. See examples below. |

### Return type
`TEXT`

## Example
{: .no_toc}

Replace first occurence of `!` with `!!!`

```sql
SELECT REGEXP_REPLACE('Hello, world!', '!', '!!!');
```
**Returns**: `'Hello, world!!!'`

Remove leading and trailing spaces

```sql
SELECT REGEXP_REPLACE_ALL('     Hello world ! ', '^[ ]+|[ ]+$', '');
```
**Returns**: `'Hello world !'`

Duplicate every character

```sql
SELECT REGEXP_REPLACE_ALL('Hello, World!', '.', '\\&\\&')
```

**Returns**: `'HHeelllloo,,  WWoorrlldd!!'`


Mask email address by leaving first character only (Note: this is for illustrative purposes only, the email matching pattern is too simplistic)

```sql
SELECT REGEXP_REPLACE(email, '(\\w)[\\w\\.]+@([\\w]+\\.)+([\\w]+)', '\\1***@\\2\\3') 
FROM UNNEST([
  'matt123@hotmail.com',
  'joe.doe@gmail.com',
  '12345@www.atg.wa.gov'
] email)
```

**Returns**:
```
'm***@hotmail.com'
'j***@gmail.com'
'1***@www.atg.wa.gov'
```

Convert dates into US format

```sql
SELECT REGEXP_REPLACE(event_date::TEXT, '(\\d{4})-(\\d{2})-(\\d{2})', '\\2/\\3/\\1')
FROM UNNEST([
  DATE '1970-08-07',
  DATE '2000-04-22',
  DATE '2002-07-25',
  DATE '2010-11-11'
] event_date)
```

**Returns**
```
08/07/1970
04/22/2000
07/25/2002
11/11/2010
```

