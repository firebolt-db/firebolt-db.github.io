---
layout: default
title: DROP VIEW
description: Reference and syntax for the DROP VIEW command.
parent:  SQL commands
---

# DROP VIEW

Deletes a view.

## Syntax
{: .no_toc}

```sql
DROP VIEW [IF EXISTS] <view_name> [CASCADE]
```
## Parameters
{: .no_toc}

| Parameter     | Description                         |
| :------------- | :----------------------------------- |
| `<view_name>` | The name of the view to be deleted. |
| `CASCADE`       | When specified, causes all dependent database objects such as views and aggregating indexes to be dropped also. |
