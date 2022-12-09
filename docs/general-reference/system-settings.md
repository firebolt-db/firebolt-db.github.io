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
