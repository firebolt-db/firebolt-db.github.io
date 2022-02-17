---
layout: default
title: Tables
description: Use this reference to learn about the metadata available for Firebolt tables using the information schema.
nav_order: 2
parent: Information schema and usage views
grand_parent: General reference
---

# Tables

This information schema view contains a row per table in the current database.

The view is available in all databases and can be queried as follows:

```sql
SELECT
  *
FROM
  information_schema.tables;
```

## View columns

| **Column Name**                 | **Data Type** | **Description**                                                 |
| table_catalog                  | `TEXT`        | Name of the catalog. Firebolt offers a single ‘default’ catalog |
| table_schema                   | `TEXT`        | The name of the database                                        |
| table_name                     | `TEXT`        | Name of the table                                               |
| primary_index                  | `ARRAY(TEXT)` | The primary index columns                                       |
| self_referencing_column_name | `TEXT`        | Not applicable for Firebolt                                     |
| reference_generation           | `TEXT`        | Not applicable for Firebolt                                     |
| user_defined_type_catalog    | `TEXT`        | Not applicable for Firebolt                                     |
| user_defined_type_schema     | `TEXT`        | Not applicable for Firebolt                                     |
| user_defined_type_name       | `TEXT`        | Not applicable for Firebolt                                     |
| is_insertable_into            | `TEXT`        | Not applicable for Firebolt                                     |
| is_typed                       | `TEXT`        | Not applicable for Firebolt                                     |
| commit_action                  | `TEXT`        | Not applicable for Firebolt                                     |
