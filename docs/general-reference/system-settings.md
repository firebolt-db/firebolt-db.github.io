---
layout: default
title: System settings
description: Lists Firebolt system settings that you can configure using SQL.
nav_order: 6
parent: General reference
---

# Firebolt system settings
{: .no_toc}

You can use a SET statement in a SQL script to configure aspects of Firebolt system behavior. Each statement is a query in its own right and must be terminated with a semi-colon (;). The SET statement cannot be included in other queries. This topic provides a list of available settings by function.

## Set time zone

Use this setting to specify the session time zone. Time zone names are from the [tz database](http://www.iana.org/time-zones) (see the [list of tz database time zones](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones)). The default value of the `time_zone` setting is UTC. For times in the future, the latest known rule for the given time zone is applied. Firebolt does not support time zone abbreviations, as they cannot account for daylight savings time transitions, and some time zone abbreviations meant different UTC offsets at different times.


### Syntax  
{: .no_toc}

```sql
SET time_zone = '<time_zone>'
```

### Example
{: .no_toc}

```sql
SET time_zone = 'UTC';
SELECT TIMESTAMPTZ '1996-09-03 11:19:33.123456 Europe/Berlin';  --> 1996-09-03 09:19:33.123456+00
SELECT TIMESTAMPTZ '2023-1-29 6:3:42.7-3:30';  --> 2023-01-29 09:33:42.7+00

SET time_zone = 'Israel';
SELECT TIMESTAMPTZ '2023-1-29 12:21:49';  --> 2023-01-29 12:21:49+02
SELECT TIMESTAMPTZ '2023-1-29Z';  --> 2023-01-29 02:00:00+02
```

## Enable parsing for literal strings

When set to `true`, strings are parsed without escaping, treating backslashes literally. By default this is disabled, and the `\` character is recognized as an escape character. 

### Syntax  
{: .no_toc}

```sql
SET standard_conforming_strings = [false|true]
```

### Example
{: .no_toc}

```sql
SET standard_conforming_strings = false;
SELECT '\x3132'; -> 132 

SET standard_conforming_strings = true;
SELECT '\x3132'; -> \x3132
```


## Enable exact COUNT (DISTINCT)

When set to false (`0`), the [COUNT (DISTINCT)](../sql-reference/functions-reference/count.md) function returns approximate results, using an estimation algorithm with an average deviation under 2%. This is the default to optimize query performance. When set to true (`1`), the function returns an exact count, which can slow query performance.

{: .note}
This function can be used in [Aggregating Indexes](..using-indexes/using-aggregating-indexes.html#using-aggregating-indexes).  When asking Support to permanently change the setting, it will be necessary to drop and recreate any aggregating indexes that use the the COUNT(DISTINCT) aggregation after the change is made.  That will allow the aggregation values to be calculated with the new setting.

### Syntax  
{: .no_toc}

```sql
firebolt_optimization_enable_exact_count_distinct = [false|true]
```

### Example  
{: .no_toc}

```sql
SET firebolt_optimization_enable_exact_count_distinct = true;
```
