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
AVG(<value>)
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<value>`  | The expression used to calculate the average | Any numeric type | 

Valid values for the expression include column names or functions that return a column name (or columns) that contain numeric values.

The `AVG()` aggregation function ignores rows with `NULL` values. For example, an `AVG` from 3 rows containing `1`, `2`, and `NULL` returns `1.5` because the `NULL` row is not counted. To calculate an average that includes `NULL`, use `SUM(COLUMN)/COUNT(*)`.

## Return Types
* `NUMERIC` if the input is type `INTEGER`, `BIGINT` or `NUMERIC`
* `DOUBLE PRECISION` if the input is type `REAL` or `DOUBLE PRECISION`

## Example

The example below uses the following table `LevelPoints`. This table includes the maximum points a player can score at each level of the game:

| levels   | maxpoints |
| :--------| :---------|
| 1        | 50        |
| 2        | 100       |
| 3        | 150       |
| 4        | 200       |
| 5        | 250       |

Use the query below to find the average of the `maxpoints` value. 

```sql
SELECT 
    AVG(maxpoints) AS AverageMaxPoints 
FROM levels;
```

**Returns**:

| AverageMaxPoints | 
| :----------------| 
| 150              |
