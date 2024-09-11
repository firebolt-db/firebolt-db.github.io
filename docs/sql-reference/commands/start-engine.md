---
layout: default
title: START ENGINE
description: Reference and syntax for the START ENGINE command.
parent:  SQL commands
---

{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).


# START ENGINE

Starts a stopped engine.

## Syntax

```sql
START ENGINE <engine_name>
```
## Parameters 
{: .no_toc}   

| Parameter       | Description                          |
| :--------------- | :------------------------------------ |
| `<engine_name>` | The name of the engine to be started. |

## Example
The following example starts my_engine:

```sql
START ENGINE my_engine
```