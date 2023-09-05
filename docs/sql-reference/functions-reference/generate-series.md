---
layout: default
title: GENERATE_SERIES (Beta)
description: Reference material for GENERATE_SERIES function
parent: SQL functions
---

# GENERATE_SERIES (Beta)
Generates a series of values from `start` to `stop`, with a step size of `step`. `step` defaults to 1.

{: .note}  
`GENERATE_SERIES` is not supported for all the queries.

## Syntax
{: .no_toc}

```sql
GENERATE_SERIES ( <start>, <stop> [, <step> ] )
```

<Syntax>

## Parameters
{: .no_toc}

| Parameter | Description | Supported input types |
| :--------- |:------------|:-|
| `<start>`  | The first value in the interval. | `BIGINT` |
| `<stop>` | The last value in the interval. |  `BIGINT ` |
| `<step>` | Optional literal integer value to set step. If not included, the default step is 1. | `BIGINT ` |


## Return Types
{: .no_toc}
`BIGINT`


## Example
{: .no_toc}


```sql
SELECT n, DATE_ADD('DAY', n, '2023-02-02') result FROM generate_series(1, 10, 2) s(n)
```

**Returns**:

| n | result |
| :--- | :--- |
| 1 | 2023-02-03 00:00:00 |
| 3 | 2023-02-05 00:00:00 |
| 5 | 2023-02-07 00:00:00 |
| 7 | 2023-02-09 00:00:00 |
| 9 | 2023-02-11 00:00:00 |

