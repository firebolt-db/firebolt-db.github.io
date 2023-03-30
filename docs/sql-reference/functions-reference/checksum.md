---
layout: default
title: CHECKSUM
description: Reference material for CHECKSUM
parent: SQL functions
---


# CHECKSUM

Calculates a hash value known as a checksum operation on a list of arguments. When `*` is specified as an argument - calculates checksum over all columns in the input. Performing a checksum operation is useful for warming up table data or to check if the same values exist in two different tables.

## Syntax
{: .no_toc}

```sql
CHECKSUM( <expression1> [, <expression2>] [, <expression3>] [, ...<expressionN>] )
CHECKSUM(*)
```

## Example
{: .no_toc}

For this example, we'll create a new table `albums` as shown below.&#x20;

```sql
CREATE DIMENSION TABLE albums (year INTEGER, artist TEXT, title TEXT);

INSERT INTO
	albums
VALUES
	(1982, 'Michael Jackson', 'Thriller'),
	(1973, 'Pink Floyd', 'The Dark Side of the Moon'),
	(1969, 'The Beatles', 'Abbey Road'),
	(1976, 'Eagles', 'Hotel California');
```

The example below calculates a checksum based on all columns in the table `albums`.

```sql
SELECT CHECKSUM(*) FROM albums;
```

**Returns**: `1630068993470241196`

The next example calculates a checksum based on columns `year` and `title` only.

```sql
SELECT CHECKSUM(year, title) FROM albums;
```

**Returns**: `4056287705143712538`
