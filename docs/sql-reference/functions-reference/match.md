---
layout: default
title: MATCH
description: Reference material for MATCH function
parent: SQL functions
---
{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).
# MATCH

Checks whether the `<expression>` matches the regular expression `<pattern>`, which is a RE2 regular expression.  Returns `0` if it doesn’t match, or `1` if it matches.

## Syntax
{: .no_toc}

```sql
MATCH(<expression>, <pattern>)
```
## Parameters 
{: .no_toc}

| Parameter   | Description                                    | Supported input types | 
| :----------- | :---------------------------------------------| :------------| 
| `<expression>`  | The string used to search for a match | `TEXT`  |
| `<pattern>` | The regular expression pattern used to search `<expression>` for a match | `TEXT` | 

## Return Types 

* Returns `0` if there are no matches between `<expression>` and `<pattern>`
* Returns `1` if there are matches between `<expression>` and `<pattern>`


## Example
{: .no_toc}

The example below generates `0` as a result because it found no match. It is searching a string of numbers for alphabet characters. 

```sql
SELECT
	MATCH('123','\\[a-Z|A-Z]') AS level;
```

**Returns**: `0`

In this second example, the `MATCH` expression generates a result of `1` because it found a match. It is searching for numeric digits in the string "123".

```sql
SELECT
	MATCH('123','\\d+');
```

**Returns**: `1`
