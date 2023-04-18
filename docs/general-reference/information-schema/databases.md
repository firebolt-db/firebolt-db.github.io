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
| database_name                 | TEXT      | Name of the database. |
| region                        | TEXT      | The AWS region in which the database is configured. |
| attached_engines              | TEXT      | A list of engine names attached to the database. |
| created_on                    | TEXT      | The time the database was created. |
| created_by                    | TEXT      | The user who created the database. |
| errors                        | TEXT      | Not applicable for Firebolt. |
