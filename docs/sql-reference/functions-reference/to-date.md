---
layout: default
title: TO_DATE
description: Reference material for TO_DATE function
parent: SQL functions
---

# TO\_DATE

Converts a string to `DATE` type.

## Syntax
{: .no_toc}

```sql
​​TO_DATE(<string>)​​
```

| Parameter  | Description                                                                |
| :---------- | :-------------------------------------------------------------------------- |
| `<string>` | The string to convert to a date. The string format should be: ‘YYYY-MM-DD’ |

## Example
{: .no_toc}

```sql
SELECT
	TO_DATE('2020-05-31') AS res;
```

**Returns**: `2020-05-31`
