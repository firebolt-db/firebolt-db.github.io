---
layout: default
title: STOP ENGINE
description: Reference and syntax for the STOP ENGINE command.
parent:  SQL commands
---

# STOP ENGINE

Stops a running engine.

## Syntax

```sql
STOP ENGINE <engine_name>
```
## Parameters 
{: .no_toc}   

| Parameter       | Description                          |
| :--------------- | :------------------------------------ |
| `<engine_name>` | The name of the engine to be stopped. |

## Example
The following example stops my_engine:

```sql
STOP ENGINE my_engine
```