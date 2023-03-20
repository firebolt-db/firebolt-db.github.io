---
layout: default
title: VACUUM (Beta)
description: Reference and syntax for the VACUUM command.
parent: SQL commands
---

# VACUUM (Beta)
Performs garbage collection to optimize a table.

`VACUUM` reclaims storage occupied by deleted tuples. In normal SQL operation, tuples that are deleted or made obsolete by an update are not physically removed from their table; they remain present until a `VACUUM` is done. Therefore, it's necessary to do `VACUUM` periodically, especially on frequently updated tables.

## Syntax

```sql
VACUUM <table_name>
```

## Parameters
{: .no_toc}

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<table_name>` | The name of the table to be optimized | FACT or DIMENSION table |

## Example
{: .no_toc}

Optimize table named `games`.

```sql
VACUUM games;
```

### Known limitations

Below are some known limitations of the `VACUUM` command in the alpha release. 

* **Space and performance considerations**<br>
The `VACUUM` command consumes considerable memory, CPU resources and disk space. Before running the `VACUUM` command, ensure you have enough free disk space. Each node will process the `VACUUM` job in parallel, and the parallelism level is defined by the number of vCPUs on that node. The amount of free disk space can be estimated by multiplying the number of vCPUs by 40GiB, at most. Less free disk space may work as well, but there will be some risk of getting an “out of free space” error in some circumstances.

* **Locks**<br>
The table being `VACUUM`ed will be locked exclusively on the engine where the command is run. Any query that uses the table during the `VACUUM` job will fail immediately with an error message. The table in question will be locked until the command finishes or is cancelled.

* The `VACUUM` command can be run ONLY on a general purpose engine. We recommend limiting use of the engine on which the `VACUUM` command is executed for any other tasks, such as ingestion or analytics, due to performance considerations and locks. 

