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

## Parameters 
{: .no_toc}

| Parameter   | Description                                   | Supported input types | 
| :----------- | :---------------------------------------------------- | :-----------| 
| `<expression>`    | A column name for specific results for the `CHECKSUM` function to be applied to | Any `<column>` name | 

## Return Types 
`INTEGER`

## Example
{: .no_toc}

For this example, we'll create a new table `tournament_information` as shown below.

```sql
CREATE DIMENSION TABLE tournament_information (name TEXT, prizedollars DOUBLE PRECISION, tournamentid INTEGER);

INSERT INTO
	tournament_information
VALUES
	('The Snow Park Grand Prix', 20903, 1),
	('The Acceleration Championsip', 19274, 2),
	('The Acceleration Trials', 13877, 3)
```

The example below calculates a checksum based on all columns in the table `tournament_information`.

```sql
SELECT CHECKSUM(*) FROM tournament_information;
```

**Returns**: `1,889,915,309,908,437,919`

The next example calculates a checksum based on columns `prizedollars` and `tournamentid` only.

```sql
SELECT CHECKSUM(prizedollars, tournamentid) FROM tournament_information;
```

**Returns**: `3,058,600,455,882,068,351`
