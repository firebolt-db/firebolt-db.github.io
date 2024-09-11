---
layout: default
title: STOP ENGINE
description: Reference and syntax for the STOP ENGINE command.
parent:  SQL commands
---

{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/).

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