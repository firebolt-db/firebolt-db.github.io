---
layout: default
title: LIKE
description: Reference material for LIKE function
parent: SQL functions
---

# LIKE

Allows matching of strings based on comparison to a pattern. `LIKE` is normally used as part of a `WHERE` clause. `LIKE` is case-sensitive; use [ILIKE](ilike.md) for case-insensitive pattern matching.

## Syntax
{: .no_toc}

```sql
<expression> LIKE '<pattern>'
```

| Parameter | Description |Supported input types |
| :-------- | :---------- | :---------------------|
| `<expression>` | Any expression that evaluates to `TEXT`. | `TEXT` |
| `<pattern>` | Specifies the pattern to match (case-sensitive). | Any string. SQL wildcards are supported: <br> <br>* Use an underscore (`_`) to match any single character<br>* Use a percent sign (`%`) to match any number of any characters, including no characters. |
                                                                                                                                                      
**Example**

Find nicknames from the `players` table that partially match the string "joe" and any following characters as follows:

```sql
SELECT
	playerid, nickname, email
FROM
	players
WHERE
	nickname LIKE 'joe%';
```

**Returns**:

```
+----------+----------+-------------------------+
| playerid | nickname | email                   |
+----------+----------+-------------------------+
| 160      | joedavis | cgarcia@example.org     |
| 519 	   | joe79    | jennifer10@example.net  |
| 3692 	   | joeli    | cperez@example.net      |
| 3891	   | joel11   | joanncain@example.net   |
| 4233 	   | joellong | millerholly@example.net |
| 4627 	   | joebowen | amandalewis@example.net |
+----------+----------+-------------------------+
```

Note that the following would return no results, as `LIKE` matches case-sensitively, unlike `ILIKE`:

```sql
SELECT
	playerid, nickname, email
FROM
	players
WHERE
	nickname LIKE 'Joe%';
```
