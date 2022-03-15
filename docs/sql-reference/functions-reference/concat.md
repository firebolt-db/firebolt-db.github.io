---
layout: default
title: CONCAT
description: Reference material for CONCAT function
parent: SQL functions
---

## CONCAT

Concatenates the strings listed in the arguments without a separator.

##### Syntax
{: .no_toc}

```sql
CONCAT( <string>, <string2>[, ...n] );
```
**&mdash;OR&mdash;**

```sql
<string> || <string2> || [ ...n]
```

| Parameter                     | Description                     |
| :----------------------------- | :------------------------------- |
| `<string>, <string2>[, ...n]` | The strings to be concatenated. |

##### Example
{: .no_toc}

```sql
SELECT
	concat('Hello ', 'World!');
```

**Returns**: `Hello World!`
