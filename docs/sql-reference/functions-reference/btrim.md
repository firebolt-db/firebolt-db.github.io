---
layout: default
title: BTRIM
description: Reference material for BTRIM function.
parent: SQL functions
---

# BTRIM

Removes all occurrences of optionally specified characters, `<trimchars_expr>`, from both sides of a source string `<srcstr_expr>`. If no `<trimchars_expr>` are specified, removes all occurrences of common whitespace (ASCII Decimal 32) characters from both sides of the specified source string.

## Syntax
{: .no_toc}

```sql
BTRIM(<srcstr_expr>[, <trimchars_expr>])
```

| Parameter        | Description                |
| :--------------- | :------------------------- |
| `<srcstr_expr>`  | An expression that returns the string to be trimmed. The string can be any of the [string data types](../../general-reference/data-types.md#string).|
| `<trimchars_expr>` | Optional. An expression that returns characters to trim from both sides of the `<srcstr_expr>` string. If omitted, whitespace (ASCII Decimal 32) is assumed. |

## Examples
{: .no_toc}

Default whitespace trim.

```sql
SELECT
  BTRIM('  Hello, world!     ') AS trmdstrng;
```

**Returns**:

```
+------------+
|trmdstrng   |
+------------+
|Hello,world!|
+------------+
```

Single character trim, with whitespace not specified and left as a remainder.

```sql
SELECT
  BTRIM('xxHello, world!  xxx', 'x') AS trmdstrng;
```

**Returns**:

```
+---------------+
|trmdstrng      |
+---------------+
|Hello,world!   |
+---------------+
```

Multiple character trim, with all specified characters removed, regardless of ordering.

```sql
SELECT
  BTRIM('xyxyHello, world!yyxx', 'xy') AS trmdstrng;
```

**Returns**:

```
+------------+
|trmdstrng   |
+------------+
|Hello,world!|
+------------+
```