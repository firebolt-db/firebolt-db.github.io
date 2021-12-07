---
layout: default
title: Tables
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

|                                 |               |                                                                 |
| ------------------------------- | ------------- | --------------------------------------------------------------- |
| **Column Name**                 | **Data Type** | **Description**                                                 |
| table\_catalog                  | `TEXT`        | Name of the catalog. Firebolt offers a single ‘default’ catalog |
| table\_schema                   | `TEXT`        | The name of the database                                        |
| table\_name                     | `TEXT`        | Name of the table                                               |
| primary\_index                  | `ARRAY(TEXT)` | The primary index columns                                       |
| self\_referencing\_column\_name | `TEXT`        | Not applicable for Firebolt                                     |
| reference\_generation           | `TEXT`        | Not applicable for Firebolt                                     |
| user\_defined\_type\_catalog    | `TEXT`        | Not applicable for Firebolt                                     |
| user\_defined\_type\_schema     | `TEXT`        | Not applicable for Firebolt                                     |
| user\_defined\_type\_name       | `TEXT`        | Not applicable for Firebolt                                     |
| is\_insertable\_into            | `TEXT`        | Not applicable for Firebolt                                     |
| is\_typed                       | `TEXT`        | Not applicable for Firebolt                                     |
| commit\_action                  | `TEXT`        | Not applicable for Firebolt                                     |
