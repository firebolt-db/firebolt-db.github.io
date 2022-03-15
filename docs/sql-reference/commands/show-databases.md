---
layout: default
title: SHOW DATABASES
description: Reference and syntax for the SHOW DATABASES command.
parent: SQL commands
---

# SHOW DATABASES

Returns a table with a row for each database defined in the current Firebolt account, with columns containing information as listed below.

## Syntax

```sql
SHOW DATABASES;
```

## Returns

The returned table has the following columns.

| Column name      | Data Type   | Description |
| :----------------| :-----------| :-----------|
| database_name    | STRING      | The name of the database. |
| region           | STRING      | The AWS Region in which the database was created. |
| attached_engines | STRING      | A comma separated list of engine names that are attached to the database. |
| created_on       | TIMESTAMP   | The date and time that the database was created (UTC). |
| created_by       | STRING      | The user name of the Firebolt user who created the database. |
| errors           | STRING      | Any error messages associated with the database. |
