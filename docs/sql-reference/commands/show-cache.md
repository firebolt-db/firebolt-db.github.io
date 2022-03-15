---
layout: default
title: SHOW CACHE
description: Reference and syntax for the SHOW CACHE command.
parent: SQL commands
---
# SHOW CACHE

Returns the current SSD usage (`ssd_usage`) for the current engine. `SHOW CACHE` returns values at the engine level, not by each node.

## Syntax

```sql
SHOW CACHE;
```

The results of `SHOW CACHE` are formatted as follows:

`<ssd_used>/<ssd_available> GB (<percent_utilization>%)`

These components are defined as follows:

| Component               | Description                                                                                                                |
| :----------------------- | :-------------------------------------------------------------------------------------------------------------------------- |
| `<ssd_used>`            | The amount of storage currently used on your engine. This data includes storage that Firebolt reserves for internal usage. |
| `<ssd_available>`    | The amount of available storage on your engine.                                                                            |
| `<percent_utilization>` | The percent of used storage as compared to available storage.                                                              |

Example returned output is shown below.

```
| ssd_usage             |
+-----------------------+
| 3.82/73.28 GB (5.22%) |
```
