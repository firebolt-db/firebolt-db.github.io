---
layout: default
title: DROP VIEW
description: Reference and syntax for the DROP VIEW command.
parent: SQL commands
---

# DROP VIEW

Deletes a view.

## Syntax

```sql
DROP VIEW [IF EXISTS] <view_name> [CASCADE]
```

| Parameter     | Description                         |
| :------------- | :----------------------------------- |
| `<view_name>` | The name of the view to be deleted. |
| `CASCADE`       | When specified, causes all dependent database objects such as views, aggregating indexes, and join indexes, to be dropped also. |
