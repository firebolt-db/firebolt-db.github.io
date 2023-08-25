---
layout: default
title: CREATE ENGINE
description: Reference and syntax for the CREATE ENGINE command.
parent:  SQL commands
---

# CREATE ENGINE
Creates an engine (compute cluster).

## Syntax

```sql
CREATE ENGINE [IF NOT EXISTS] <engine_name>
[WITH 
    [ENGINE_TYPE = <type>]
    [SCALE = <scale>]
    [SPEC = <spec>]
    [AUTO_STOP = <minutes]
    [WARMUP = <warmup_method>]]
```
## Parameters
{: .no_toc}  

| Property                                                             | Description                                                                                                                                                                                                                                                                                                                                          |
| :-------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ENGINE_TYPE = <type>`                                               | The engine type can have one of the following values: <br>`GENERAL_PURPOSE` - can do everything analytics engines do, but can also write data to Firebolt tables. General purpose engines are designed for database creation, data ingestion, and extract, load, and transform (ELT) operations. A database can have only one general purpose engine running at a time.<br>`DATA_ANALYTICS` - are read-only and cannot be used to add, delete or change data in Firebolt tables. You can run as many analytics engines as you need at the same time.<br><br>If not specified - `GENERAL_PURPOSE` is used as default. |
| `SCALE =<scale>`          | Scale determines the number of nodes that the engine uses and can be an integer ranging from 1 to 128. Firebolt monitors the health of nodes on a continuous basis and automatically repairs nodes that report an unhealthy status.<br><br> If not specified, 2 is used as default. |
| `SPEC = '<spec>'`                                                    | The engine spec defines engine’s compute capabilities. Each engine spec has CPU, RAM, and cache characteristics. The engine spec determines the cost per hour \(billed per second\) for each engine node (the total engine cost per hour is also a function of scale). You can choose engine specs for characteristics that are best suited for your Firebolt workload. For details, see [Available engine specs](../../../Reference/available-engine-specs.md).<br><br>If not specified, `'S8'` is used as default. |
| `AUTO_STOP = <minutes>`                                              | Indicates the amount of time (in minutes) after which the engine automatically stops. The default value is 20.<br><br>Setting the `minutes` to 0 indicates that `AUTO_STOP` is disabled. |
| `WARMUP =`<br>`<warmup_method>` | The warmup method that should be used. The following options are supported: `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only (default). `PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup). |

## Example
The following example creates an engine with a scale of `8`: 

```sql
CREATE ENGINE my_engine
WITH SCALE = 8
```
