---
layout: default
title: System settings
description: Lists Firebolt system settings that you can configure using SQL.
nav_order: 6
parent: General reference
---

# Firebolt system settings
{: .no_toc}

Contact Firebolt Support through the Help menu support form if you are interested in enabling the following setting for your Firebolt instance. 


## Enable exact COUNT (DISTINCT)

When set to false (`0`), the [COUNT (DISTINCT)](../sql-reference/functions-reference/count.md) function returns approximate results, using an estimation algorithm with an average deviation under 2%. This is the default to optimize query performance. When set to true (`1`), the function returns an exact count, which can slow query performance.

{: .note}
This function can be used in [Aggregating Indexes](..using-indexes/using-aggregating-indexes.html#using-aggregating-indexes).  When asking Support to permanenently change the setting, it will be necessary to drop and recreate any aggregating Iidexes that use the the COUNT(DISTINCT) aggregation after the change is made.  That will allow the aggregation values to be calculated with the new setting.

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
