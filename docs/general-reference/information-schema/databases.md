---
layout: default
title: Databases
nav_order: 1
parent: Information schema and usage views
grand_parent: General reference
---

# Databases

This information schema view contains a row per database in your Firebolt account.

The view is available in all databases and can be queried as follows:

```sql
SELECT
  *
FROM
  information_schema.databases;
```

## View columns

| -------------------------------- | ------------- | ----------------------------------------------------------------- |
| **Name**                         | **Data Type** | **Description**                                                   |
| catalog_name                    | `TEXT`        | Name of the catalog. Firebolt provides a single ‘default’ catalog |
| schema_name                     | `TEXT`        | Name of the database                                              |
| default_character_set_catalog | `TEXT`        | Not applicable for Firebolt                                       |
| default_character_set_schema  | `TEXT`        | Not applicable for Firebolt                                       |
| default_character_set_name    | `TEXT`        | Not applicable for Firebolt                                       |
| sql_path                        | `TEXT`        | Not applicable for Firebolt                                       |
