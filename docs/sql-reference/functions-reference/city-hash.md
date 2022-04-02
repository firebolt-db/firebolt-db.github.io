---
layout: default
title: CITY_HASH
description: Reference material for CITY_HASH function
parent: SQL functions
---

# CITY_HASH

Takes one or more input parameters of any data type and returns a 64-bit non-cryptographic hash value. `CITY_HASH` uses the CityHash algorithm for string data types, implementation-specific algorithms for other data types, and the CityHash combinator to produce the resulting hash value.

## Syntax
{: .no_toc}

```sql
CITY_HASH(<exp>, [, expr2 [,...]])
```

| Parameter | Description                                                      |
| :--------- | :---------------------------------------------------------------- |
| `<exp>`   | An expression that returns any data type that Firebolt supports. |

## Example
{: .no_toc}

```sql
SELECT CITY_HASH('15', 'apple', '02-25-1918')
```

**Returns:** `2383463095444788470`
