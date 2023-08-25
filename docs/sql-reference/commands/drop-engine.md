---
layout: default
title: DROP ENGINE
description: Reference and syntax for the DROP ENGINE command.
parent:  SQL commands
---

# DROP ENGINE
Deletes an engine.

## Syntax

```sql
DROP ENGINE [IF EXISTS] <engine_name>
```
## Parameters 
{: .no_toc}   

| Parameter       | Description                           |
| :--------------- | :------------------------------------- |
| `<engine_name>` | The name of the engine to be deleted. |

## Example
The following example drops my_engine:

```sql
DROP ENGINE [IF EXISTS] my_engine
```