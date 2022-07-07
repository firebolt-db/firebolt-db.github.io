---
layout: default
title: RTRIM
description: Reference material for RTRIM function
parent: SQL functions
---

# RTRIM

Removes all occurrences of optionally specified characters, `<trimchars_expr>`, from the right side of a source string `<srcstr_expr>`. If no `<trimchars_expr>` are specified, removes all occurrences of common whitespace (ASCII Decimal 32) characters from the right side of the specified source string.

## Syntax
{: .no_toc}

```sql
RTRIM(<srcstr_expr>[, <trimchars_expr>])
```

| Parameter        | Description                |
| :--------------- | :------------------------- |
| `<srcstr_expr>`  | An expression that returns the string to be trimmed. The string can be any of the [string data types](../../general-reference/data-types.md#string).|
| `<trimchars_expr>` | Optional. An expression that returns characters to trim from the right side of the `<srcstr_expr>` string. If omitted, whitespace (ASCII Decimal 32) is assumed. |

## Examples
{: .no_toc}

Default whitespace trim.

```sql
SELECT
  RTRIM('  Hello, world!     ') AS trmdstrng;
```

**Returns**:

```
+---------------+
|trmdstrng      |
+---------------+
|   Hello,world!|
+---------------+
```

Single character trim, with whitespace not specified and left as a remainder.

```sql
SELECT
  RTRIM('Hello, world!  xxx', 'x') AS trmdstrng;
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
  RTRIM('  Hello, world!yyxxy', 'xy') AS trmdstrng;
```

**Returns**:

```
+--------------+
|trmdstrng     |
+--------------+
|  Hello,world!|
+--------------+
```
