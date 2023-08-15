---
layout: default
title: CONCAT
description: Reference material for CONCAT function
parent: SQL functions
---

# CONCAT

Concatenates the strings listed in the input without a separator.

## Syntax
{: .no_toc}

```sql
CONCAT( <expression>[, ...n] );
```
**&mdash;OR&mdash;**

```sql
<expression> || <expression2> || [ ...n]
```
## Parameters 
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<expression>[, ...n]` | The string(s) to be concatenated. | `TEXT` |

`NULL` inputs to the `CONCAT` function are treated as empty strings and ignored. When all inputs are `NULL`, the result will be an empty string.

When using `||`, any `NULL` input results in a `NULL` output.

## Return Type
`TEXT`

## Example
{: .no_toc}

The following example concatenates users' `nicknames` and `emails` from the players table: 

```sql
SELECT
	CONCAT(nickname, ': ', email) as user_info
FROM players
LIMIT 5;
```

**Returns**:

| user_info                              |
| :--------------------------------------|
| steven70: daniellegraham@example.net   | 
| burchdenise: keith84@example.org       | 
| stephanie86: zjenkins@example.org      |
| sabrina21: brianna65@example.org       |
| kennethpark: williamsdonna@example.com |



