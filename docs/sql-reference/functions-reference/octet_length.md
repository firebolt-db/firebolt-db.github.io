---
layout: default
title: OCTET_LENGTH
description: Reference material for OCTET_LENGTH function
parent: SQL functions
---

# LENGTH

Calculates the length of the input string in bytes.

## Syntax
{: .no_toc}

```sql
OCTET_LENGTH(<expression>)
```
## Parameters 
{: .no_toc}

| Parameter      | Description                                  |Supported input types |
| :--------------| :--------------------------------------------|:----------------------|
| `<expression>` | The string or binary data for which to return the length.   | `TEXT`, `BYTEA`       |

## Return Type
`BIGINT` 

## Example
{: .no_toc}

Use the `OCTET_LENGTH` to find the length of any string in bytes, such as: 

```sql
SELECT OCTET_LENGTH('🔥')
```

**Returns**: `4`

Because the UTF8 encoding of '🔥' has the byte sequence `0xF0 0x9F 0x94 0xA5`.


