---
layout: default
title: BTRIM
description: Reference material for BTRIM function.
parent: SQL functions
---

# BTRIM

Removes all occurrences of optionally specified characters, `<trim>`, from both sides of a source string `<expression>`. If no `<trim>` parameter is specified, all occurrences of common whitespace (ASCII Decimal 32) characters from both sides of the specified source string are removed.

## Syntax
{: .no_toc}

```sql
BTRIM(<expression>[, <trim>])
```

| Parameter        | Description                | Supported input types | 
| :--------------- | :------------------------- | :----------|
| `<expression>`  | The string to be trimmed. | `TEXT` | 
| `<trim>` | Optional. An expression that returns characters to trim from both sides of the `<expression>` string. If omitted, whitespace (ASCII Decimal 32) is assumed. | `TEXT` | 

## Return Type
`TEXT`

## Examples
{: .no_toc}

The following example returns a trimmed string with the default amount of whitespace applied: 

```sql
SELECT
  BTRIM('  The Acceleration Cup     ');
```
**Returns**:

The Acceleration Cup

This example returns the string without any `x`: 
```sql
SELECT
  BTRIM('xxThe Acceleration Cupxxx', 'x') 
```

**Returns**:

The Acceleration Cup

This example completes a multiple character trim, with all specified characters removed, regardless of ordering:

```sql
SELECT
  BTRIM('xyxyThe Acceleration Cupyyxx', 'xy');
```

**Returns**:

The Acceleration Cup