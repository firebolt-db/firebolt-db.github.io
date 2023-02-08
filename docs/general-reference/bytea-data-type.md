---
layout: default
title: BYTEA data type
description: Describes the Firebolt implementation of the `BYTEA` data type
nav_exclude: true
search_exclude: false
---

# BYTEA data type
{:.no_toc}

This topic describes the Firebolt implementation of the `BYTEA` data type.

Not all functions support the `BYTEA` data type currently. For more information, see [BYTEA functions](../sql-reference/functions-reference/index.md#bytea-functions). 

* Topic ToC
{:toc}

## Overview

The `BYTEA` data type is a variable length binary string data type, commonly used to store binary data, like images, other multimedia files, or raw bytes of information. A binary string is a sequence of bytes - unlike `TEXT`, there is no character set. The `BYTEA` data type is nullable.

### Casting

The `BYTEA` type can be cast to and from the `TEXT` data type. A cast from `BYTEA` to `TEXT` will interpret the binary string to a hexadecimal representation with `\x` as a prefix. For example `SELECT 'a'::BYTEA::TEXT` returns `\x61`.

Cast from `TEXT` to `BYTEA` supports two formats, **hex** and **escaped**:

**Hex**<br>
Using hex format, the `TEXT` type data must start with `\x`. Characters `\n`, `\t`, `\r` and ' ' are ignored if they are not in sequence of two characters representing one byte. Each character must be in one of the following ranges: `a-f`, `A-F`, `0-9`.<br>Characters must be in pairs. For example, `\x    aa  ` is a valid hex format, but `\xa a` is invalid.


**Escape**<br>
Using escape format, an escaped backslash becomes just a single backslash: `\\` -> `\`. One backslash must be followed by 3 numbers representing octal value (base 8) in range of `000-377`. For example, `a \375`

In addition to casting, the [ENCODE](../sql-reference/functions-reference/encode.md) and [DECODE](../sql-reference/functions-reference/decode.md) functions can be used to represent `TEXT` as `BYTEA` and vice versa, but will behave slightly differently. For example, `SELECT ENCODE('1'::BYTEA, 'HEX');` returns `31`, while `SELECT CAST('1'::BYTEA as TEXT);` returns `\x31`, both of type `TEXT`.

### Comparison operator

The `BYTEA` comparison operator will work as lexicographical comparison but with bytes. Two empty `BYTEA` type expressions are equal. If two `BYTEA` type expressions have equivalent bytes and are of the same length, then they are equal. In a greater than (>) or less than (<) comparison, two `BYTEA` type expressions are compared byte by byte, and the first mismatching byte defines which is greater or less than the other.

**Examples:**

`SELECT '\xa3'::BYTEA > '\xa2'::BYTEA;` returns `TRUE`.

`SELECT '\xa3'::BYTEA = '\xa300'::BYTEA;` returns `FALSE`.

`SELECT '\xa3'::BYTEA < '\xa300'::BYTEA;` returns `TRUE`.

### Literal string interpretation

Literal strings will be interpreted according to the setting [`standard_conforming_strings`,](../general-reference/system-settings.md#enable-parsing-for-literal-strings) which controls whether strings are parsed with or without escaping.
Similar to [CAST](../sql-reference/functions-reference/cast.md)  from `TEXT` to `BYTEA`, the two text formats hex and escape are supported.

**Examples:**

```sql
SET standard_conforming_strings=0;
SELECT '\x3132'::BYTEA; -> '\x313332'
SELECT '\x31   32  '::BYTEA; -> '\x3120202033322020'
SELECT 'a b\230a'::BYTEA; -> '\x61206232333061'

set standard_conforming_strings=1;
SELECT '\x3132'::BYTEA; -> '\x3132'
SELECT '\x31   32  '::BYTEA; -> '\x3132'
SELECT 'a b\230a'::BYTEA; -> '\x6120629861'
```

### Output format

The output format for `BYTEA` is the hexadecimal representation of the bytes in lower case prefixed by `\x` (Note: in JSON `\` is escaped).

**Example:**

```sql
SELECT 'a'::BYTEA;
```

**Returns:**
```json
{
    "data":
    [
        ["\\x61"]
    ]
}
```

### Importing `BYTEA` from external source

The input format is splited between file formats:

**orc, parquet:** 
specific field type without annotation (utf-8 for example): BYTE_ARRAY (binary) - will import the bytes exactly as they are in the source.
all the other types will be imported to the corresponding datatype (byte array with utf-8 annotation will be imported to text datatype)
and then will be cast as if they will be used by SQL function cast (example `cast('abcd' as bytea)`)

**csv, tsv, json:**
read the input exactly as it is then runs the SQL function cast (example `cast('abcd' as bytea)`)

note: json files must be utf-8 encoded however csv/tsv files are not, in that case there are two options: 
one is that the data starts with `\x` in that case it will throw error.
second is that it is not starting with `\x` then it will just copy those bytes to the `BYTEA` column.

**CSV File Example:**

*file*
```csv
'row1'
'a�a'
'\xaabf'
```
*sql*
```sql
CREATE EXTERNAL TABLE e
(
    s1 bytea
) URL = 's3://...'
  OBJECT_PATTERN = '...'
  TYPE = (CSV);

select * from e;
```
**Returns:**
```table
| s1         |
| ---------- |
| \x726f7731 |   
| \x61ff61   |   
| \xaabf     |   
```
