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

## Enable parsing for literal strings

When set to true (`1`), strings are parsed without escaping, treating backslashes literally. By default this is disabled, and the `\` character is recognized as an escape character. 

### Syntax  
{: .no_toc}

```sql
SET standard_conforming_strings = [0|1]
```

### Example
{: .no_toc}

```sql
SET standard_conforming_strings = 0;
SELECT '\x3132'; -> 132 

set standard_conforming_strings=1;
SELECT '\x3132'; -> \x3132
```


## Enable exact COUNT (DISTINCT)

When not enabled, the [COUNT (DISTINCT)](../sql-reference/functions-reference/count.md) function returns approximate results, using an estimation algorithm with an average deviation under 2%. This is the default to optimize query performance. When enabled, the function returns an exact count, which can slow query performance.

This setting cannot be set with a SET command. Contact Firebolt Support through the Help menu support form if you are interested in enabling this setting for your Firebolt instance. 