---
layout: default
title: System settings
description: Lists Firebolt system settings that you can configure using SQL.
nav_order: 6
parent: General reference
---

# Firebolt system settings
{: .no_toc}

You can use a `SET` statement in a SQL script to configure aspects of Firebolt system behavior. Each statement is a query in its own right and must be terminated with a semi-colon (`;`). The `SET` statement cannot be included in other queries. This topic provides a list of available settings by function.

* Topic ToC
{: toc}

## Allow CSV single quotes

When set to true (`1`), allows strings in a CSV file to be enclosed in single quotes (`'`). This is the default. When set to false (`0`), CSV files with single quotes cause an error during ingestion.

### Syntax  
{: .no_toc}

```sql
SET format_csv_allow_single_quotes = [0|1]
```

### Example
{: .no_toc}

```sql
SET input_format_csv_allow_single_quotes = 0;
```

## Allow CSV double quotes

When set to true (`1`), allows strings in a CSV file to be enclosed in double quotes (`"`). This is the default. When set to false (`0`), CSV files with double quotes cause an error during ingestion.

### Syntax  
{: .no_toc}

```sql
format_csv_allow_double_quotes = [0|1]
```

### Example
{: .no_toc}

```sql
SET format_csv_allow_double_quotes = 0;
```

## Specify custom CSV escape character

Specifies a custom escape character to use in CSV files. When this setting is passed using the API or an SDK, enclose `<char>` in single quotes. Must be a single character.

### Syntax  
{: .no_toc}

```sql
input_format_csv_escape_character = <char>
```

### Example  
{: .no_toc}

```sql
SET input_format_csv_escape_character = \;
```

## Specify custom CSV delimiter

Specifies a custom character as a delimiter (field separator) in CSV files. If omitted, a comma (`,`) is assumed. Must be a single character.

### Syntax  
{: .no_toc}

```sql
format_csv_delimiter = <char>
```

### Example  
{: .no_toc}

```sql
SET format_csv_delimeter = |;
```

## Skip unknown fields during ingestion

When set to false (`0`), Firebolt fails ingestion and returns an error when a source file contains a column or columns that do not exist in the target table. This is the default. When set to true (`1`), Firebolt skips columns with no corresponding column. Ingestion continues without error and and the orphaned data is not ingested.

### Syntax  
{: .no_toc}

```sql
input_format_skip_unknown_fields = [0|1]
```

### Example  
{: .no_toc}

```sql
SET input_format_skip_unknown_fields = 1;
```

## Enable exact COUNT (DISTINCT)

When set to false (`0`), the [COUNT (DISTINCT)](../sql-reference/functions-reference/count.md) function returns approximate results, using an estimation algorithm with an average deviation under 2%. This is the default to optimize query performance. When set to true (`1`), the function returns an exact count, which can slow query performance.

### Syntax  
{: .no_toc}

```sql
firebolt_optimization_enable_exact_count_distinct = [0|1]
```

### Example  
{: .no_toc}

```sql
SET firebolt_optimization_enable_exact_count_distinct = 1;
```
