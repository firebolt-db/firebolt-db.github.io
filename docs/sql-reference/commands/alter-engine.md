---
layout: default
title: ALTER ENGINE
description: Reference and syntax for the ALTER ENGINE command.
parent: SQL commands
---

# ALTER ENGINE

Updates the configuration of the specified engine `<engine_name>`.

## Syntax

```sql
ALTER ENGINE <engine_name> SET
    [SCALE = <scale>]
    [SPEC = <spec>]
    [AUTO_STOP = <minutes]
    [RENAME TO <new_name>]
    [WARMUP = <warmup_method>]
```

| Parameter                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | 
| :----------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | 
| `<engine_name>`                                             | Name of the engine to be altered.                                                                                                                                                                                                                                                                                                                                                                                                                                                     | 
| `SCALE = <scale>` | Scale determines the number of nodes that the engine uses, and can be an integer ranging from 1 to 128.<br> | 
| `SPEC = <spec>`   | The engine spec defines the engine’s compute capabilities. Each engine spec has CPU, RAM, and cache characteristics. The engine spec determines the cost per hour (billed per second) for each engine node (the total engine cost per hour is also a function of scale). You can choose engine specs for characteristics that are best suited for your Firebolt workload. For details, see [Available engine specs](../../general-reference/available-engine-specs.md).<br>| 
| `AUTO_STOP = <minutes>`                                     | The number of minutes after which the engine automatically stops, where 0 indicates that `AUTO_STOP` is disabled.                                                                                                                                                                                                                                                                                                                                                                     | 
| `RENAME TO <new_name>`                                      | Indicates the new name for the engine.<br> <br>For example: `RENAME TO new_engine_name`                                                                                                                                                                                                                                                                                                                                                                         | 
| `WARMUP =<warmup_method>`                                   | The warmup method that should be used. The following options are supported:<br><br> `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only.<br><br>`PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup).                                                                                                                                  | 

## Example&ndash;change engine scale

```sql
ALTER ENGINE my_engine SET SCALE = 1
```
