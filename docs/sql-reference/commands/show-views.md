---
layout: default
title: SHOW VIEWS
description: Reference and syntax for the SHOW VIEWS command.
parent: SQL commands
---

# SHOW VIEWS

Lists the views defined in the current database and the `CREATE VIEW` statement (`schema`) that defines each view.

## Syntax

```sql
SHOW VIEWS;
```

## Example

```sql
SHOW VIEWS;
```

**Returns**:

| view_name | schema                                                                                                       |
|:----------|:-------------------------------------------------------------------------------------------------------------|
| v14       | CREATE VIEW "v14" AS SELECT a.* FROM  (SELECT 1 AS "x") AS "a" INNER JOIN  (SELECT 1 AS "x") AS "b" USING(x) |
| v15       | CREATE VIEW IF NOT EXISTS "v15" AS SELECT * FROM "bf_test_t" WHERE ( "n" = 0 )                               |
| v16       | CREATE VIEW "v16" AS WITH x7 AS (SELECT * FROM "oz_x6" ) SELECT * FROM "x7"                                  |
