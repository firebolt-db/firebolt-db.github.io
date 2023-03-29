---
layout: default
title: Databases
description: Use this reference to learn about the metadata available for Firebolt databases using the information schema.
nav_order: 1
parent: Information schema and usage views
grand_parent: General reference
---

# Information schema for databases

You can use the `information_schema.databases` view to return information about databases. You can use a `SELECT` query to return information about each database as shown in the example below.

```sql
SELECT
  *
FROM
  information_schema.databases;
```

## Columns in information_schema.databases

Each row has the following columns with information about the database.

| Name                          | Data Type | Description |
| :-----------------------------| :-------- | :---------- |
| catalog_name                  | TEXT      | Name of the catalog. Firebolt provides a single ‘default’ catalog. |
| database_name                 | TEXT      | Name of the database. |
| default_character_set_catalog | NULL      | Not applicable for Firebolt. |
| default_character_set_schema  | NULL      | Not applicable for Firebolt. |
| default_character_set_name    | NULL      | Not applicable for Firebolt. |
| sql_path                      | NULL      | Not applicable for Firebolt. |
