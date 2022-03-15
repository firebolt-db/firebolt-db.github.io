---
layout: default
title: CREATE ENGINE
description: Reference and syntax for the CREATE ENGINE command.
parent: SQL commands
---

# CREATE ENGINE
Creates an engine (compute cluster).

## Syntax

```sql
CREATE ENGINE [IF NOT EXISTS] <engine_name>
[WITH <properties>]
```

Where `<properties>` are:

* `REGION = '<aws_region>'`
* `ENGINE_TYPE = <type>`
* `SPEC = '<spec>'`
* `SCALE = <scale>`
* `AUTO_STOP = <minutes>`
* `WARMUP = [ MINIMAL | PRELOAD_INDEXES | PRELOAD_ALL_DATA ]`

| Parameter                                                            | Description                                                                                                                                                                                                                                                                                                                                          | Mandatory? Y/N |
| :-------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<engine_name>`                                                      | An identifier that specifies the name of the engine.<br><br> For example: `my_engine`                                                                                                                                                                                                                                                   | Y              |
| `REGION = '<aws_region>'`                                            | The AWS region in which the engine runs.<br><br> If not specified, `'us-west-2'` is used as default.                                                                                                                                                                                                                                    | N              |
| `ENGINE_TYPE = <type>`                                               | The engine type. The `<type>` can have one of the following values: 1. `GENERAL_PURPOSE` <br><br> 2.  `DATA_ANALYTICS`<br><br> If not specified - `GENERAL_PURPOSE` is used as default.<br><br> Usage example: <br><br>`CREATE ENGINE ... ENGINE_TYPE = GENERAL_PURPOSE`   | N              |
| `SPEC = '<spec>'`                                                    | The AWS EC2 instance type, for example, `'m5d.xlarge'`.<br><br>If not specified, `'i3.4xlarge'` is used as default.                                                                                                                                                                                           | N              |
| `SCALE =`<br>`<scale>`          | Specifies the scale of the engine.<br><br>The scale can be any `INT` between 1 to 128.<br><br> If not specified, 2 is used as default.                                                                                                                                                      | N              |
| `AUTO_STOP = <minutes>`                                              | Indicates the amount of time (in minutes) after which the engine automatically stops. The default value is 20.<br><br>Setting the `minutes` to 0 indicates that `AUTO_STOP` is disabled.                                                                                                                                    | N              |
| `WARMUP =`<br>`<warmup_method>` | The warmup method that should be used, the following options are supported: `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only (default). `PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup). | N              |

## Example&ndash;create an engine with (non-default) properties

```sql
CREATE ENGINE my_engine
WITH SPEC = 'c5d.4xlarge' SCALE = 8
```
