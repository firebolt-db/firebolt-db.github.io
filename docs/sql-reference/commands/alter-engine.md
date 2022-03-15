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
    [SCALE TO <scale> [ABORT = TRUE|FALSE ]]
    [SPEC = <spec> [ABORT = TRUE|FALSE]]
    [AUTO_STOP = <minutes]
    [RENAME TO <new_name>]
    [WARMUP = <warmup_method>]
```

| Parameter                                                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | Mandatory? Y/N |
| :----------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<engine_name>`                                             | Name of the engine to be altered.                                                                                                                                                                                                                                                                                                                                                                                                                                                     | Y              |
| `SCALE = <scale>` | Valid scale numbers include any `INT` between 1 to 128.<br> <br> `ABORT` is an optional parameter to indicate how running queries are handled. The default is `FALSE`, which indicates that currently running queries will not be canceled. The old engine only terminates when running queries are complete, and the new engine with the new scale is ready.<br> <br> When `TRUE`, indicates that when the new engine is ready, the old engine is terminated and running queries in it are canceled. | N              |
| `SPEC = <spec>`   | Indicates the EC2 instance type, for example, 'm5.xlarge'<br><br>`ABORT` is an optional parameter (default=false) <br><br>`ABORT=FALSE` means that currently running queries aren’t aborted. The old engine only terminates once the new engine scale is ready, and the running queries are complete.<br> <br>`ABORT=TRUE` means that once the new engine is ready, the old engine is terminated, and running queries in it are aborted.          | N              |
| `AUTO_STOP = <minutes>`                                     | The number of minutes after which the engine automatically stops, where 0 indicates that `AUTO_STOP` is disabled.                                                                                                                                                                                                                                                                                                                                                                     | N              |
| `RENAME TO <new_name>`                                      | Indicates the new name for the engine.<br> <br>For example: `RENAME TO new_engine_name`                                                                                                                                                                                                                                                                                                                                                                         | N              |
| `WARMUP =<warmup_method>`                                   | The warmup method that should be used, the following options are supported:<br><br> `MINIMAL` On-demand loading (both indexes and tables' data).<br><br>`PRELOAD_INDEXES` Load indexes only (default).<br><br>`PRELOAD_ALL_DATA` Full data auto-load (both indexes and table data - full warmup).                                                                                                                                  | N              |

## Example&ndash;change engine scale

```sql
ALTER ENGINE my_engine SET SCALE TO 1
```
