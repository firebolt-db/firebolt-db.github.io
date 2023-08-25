---
layout: default
title: START ENGINE
description: Reference and syntax for the START ENGINE command.
parent:  SQL commands
---

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