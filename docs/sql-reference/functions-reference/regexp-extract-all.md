---
layout: default
title: REGEXP_EXTRACT_ALL
description: Reference material for REGEXP_EXTRACT_ALL function
parent: SQL functions
---

# REGEXP_EXTRACT_ALL
 
Returns an array that contains all matches of a `<pattern>` within the given `<expression>`. 
If the pattern does not match, returns an empty array. If you want return the first match of `<pattern>` within the `<expression>`, use [REGEXP_EXTRACT](./regexp-extract.md).


```sql
REGEXP_EXTRACT_ALL(<expression>, <pattern>[,'<flag>[...]',[<index>]])
```

| Parameter   | Description |Supported input types |
| :----------- | :----------------------------------------- | :---------------------|
| `<expression>`  | The string from which to extract a substring, based on a regular expression. | `TEXT` |
| `<pattern>` | A [re2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string. | `TEXT` | 
| `<flag>` | Optional. Flag that allows additional controls over the regular's expression matching behavior. If using multiple flags, you can include them in the same single-quote block without any separator character. | Firebolt supports the following RE2 flags to override default matching behavior. With `-` in front, you can disable the flag.<br>* `i` - Specifies case-insensitive matching.<br>* `m` - Specifies multi-line mode. In this mode, `^` and `$` characters in the regex match the beginning and end of the line.<br>* `s` - (Enabled per default) Specifies that the `.` metacharacter in regex matches the newline character in addition to any character in `.`<br>* `U` - Specifies non-greedy mode. In this mode, the meaning of the metacharacters `*` and `+` in regex `<pattern>` are swapped with `*?` and `+?`, respectively. See the examples using flags below for the difference in how results are returned. |
| `<index>`| Optional. Indicates which subgroup of each expression match should be returned. The default value is `0` which means the whole match is returned, independent of any number of given subgroups. | An `INTEGER` between `0` and `N` where `N` is the number subgroups in the `<pattern>`.|

## Return Types
`ARRAY<TEXT>`

## Example
{: .no_toc}

```sql
SELECT
	REGEXP_EXTRACT_ALL('Hello Year 2023, yeah!', '[A-Za-z]+');
```
**Returns**: `["Hello", "Year", "yeah"]`

Despite using subgroups in the regular expression, each full match will be returned as the optional `<index>` argument is not set (the default value `0` is used instead).

```sql
SELECT
	REGEXP_EXTRACT_ALL('Learning about #REGEX in #Firebolt 2023', '#([A-Z])[a-z]+', 'i');
```
**Returns**: `["#REGEX", "#Firebolt"]`

The regular expression contains two subgroups which allows us to set the `<index>` argument to something between `0` and `2`. Every other value will cause an exception to be thrown. Setting `<index>` to `0` would cause that all full matches `["#REGEX", "#Firebolt"]` are returned (same behavior as not setting this value, see the example above), while a `2` would return the second subgroup of each match `["EGEX", "irebolt"]`.

```sql
SELECT
	REGEXP_EXTRACT_ALL('Learning about #REGEX in #Firebolt 2023', '#([A-Z])([a-z]+)', 'i', 1);
```
**Returns**: `["R", "F"]`
