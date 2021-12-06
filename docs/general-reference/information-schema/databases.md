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

|                                  |               |                                                                   |
| -------------------------------- | ------------- | ----------------------------------------------------------------- |
| **Name**                         | **Data Type** | **Description**                                                   |
| catalog\_name                    | `TEXT`        | Name of the catalog. Firebolt provides a single ‘default’ catalog |
| schema\_name                     | `TEXT`        | Name of the database                                              |
| default\_character\_set\_catalog | `TEXT`        | Not applicable for Firebolt                                       |
| default\_character\_set\_schema  | `TEXT`        | Not applicable for Firebolt                                       |
| default\_character\_set\_name    | `TEXT`        | Not applicable for Firebolt                                       |
| sql\_path                        | `TEXT`        | Not applicable for Firebolt                                       |
