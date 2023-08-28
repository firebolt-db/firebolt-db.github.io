---
layout: default
title: MATCH_ANY
description: Reference material for MATCH_ANY function
parent: SQL functions
---

# MATCH\_ANY

The same as [MATCH](./match.md), but it searches for a match with one or more more regular expression patterns. Returns `0` if none of the regular expressions match and `1` if any of the patterns match.

Synonym: `MULTI_MATCH_ANY`

## Syntax
{: .no_toc}

```sql
MATCH_ANY(<expression>, <pattern>)
```
## Parameters 
{: .no_toc}

| Parameter         | Description     | Supported input types | 
| :----------------- | :------------------------------- | :----------| 
| `<expression>`        | The string to search for a match. | `TEXT` |
| `<pattern>` | A series of one or more regular expression patterns to search for a match in the `<expression>`. | `TEXT` | 

## Return Types 

* Returns `0` if there are no matches between `<expression>` and any of the regular expressions in `<pattern>`
* Returns `1` if there are matches between `<expression>` and any of the regular expressions in  `<pattern>`

## Remarks
{: .no_toc}

`<pattern>` must be enclosed in brackets. Each pattern must be enclosed in single quotes and separated with commas. For example, the `<pattern>` series below consists of two regular expression patterns: `[ '\\d+', '\\[a-Z|A-Z]' ]`

## Example
{: .no_toc}

The query below searches for any matches within the string `123` with the patterns `['\d+','\[a-Z|A-Z]']`.  Since at least one is found, it returns: `1`

```sql
SELECT
	MATCH_ANY('123', [ '\\d+', '\\[a-Z|A-Z]' ]) AS level;
```

**Returns**: `1`
