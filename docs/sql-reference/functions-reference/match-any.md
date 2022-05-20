---
layout: default
title: MATCH_ANY
description: Reference material for MATCH_ANY function
parent: SQL functions
---

# MATCH\_ANY

The same as [MATCH](./match.md), but it searches for a match with one or more more regular expression patterns. It returns `0` if none of the regular expressions match and `1` if any of the patterns matches.

Synonym for `MULTI_MATCH_ANY`

## Syntax
{: .no_toc}

```sql
MATCH_ANY(<string>, <pattern_array>)
```

| Parameter         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| :----------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>`        | The string to search for a match.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `<pattern_array>` | A series of one or more regular expression patterns to search for a match in the `<string>`.<br>`<pattern_array>`</code> must be enclosed in brackets. Each pattern must be enclosed in single quotes and separated with commas.<br>For example, the `<pattern_array>` below consists of two regular expression patterns:<br>`[ '\\d+', '\\[a-Z|A-Z]' ]` |

## Example
{: .no_toc}

The query below searches for any matches within the string `123` with the patterns `['\d+','\[a-Z|A-Z]']`.  Since at least one is found, it returns: `1`

```sql
SELECT
	MATCH_ANY('123', [ '\\d+', '\\[a-Z|A-Z]' ]) AS res;
```

**Returns**: `1`
