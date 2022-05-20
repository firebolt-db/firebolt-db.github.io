---
layout: default
title: AVG (aggregation function)
description: Reference material for AVG
parent: SQL functions
---


# AVG

Calculates the average of an expression.

## Syntax
{: .no_toc}

```sql
AVG(<expr>)
```

| Parameter | Description                                                                                                                                                                        |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`  | The expression used to calculate the average. Valid values for the expression include column names or functions that return a column name for columns that contain numeric values. |

{: .note}
The `AVG()` aggregation function ignores rows with NULL. For example, an `AVG` from 3 rows containing `1`, `2`, and NULL returns `1.5` because the NULL row is not counted. To calculate an average that includes NULL, use `SUM(COLUMN)/COUNT(*)`.
