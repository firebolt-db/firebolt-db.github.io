---
layout: default
title: CREATE TABLE AS SELECT (CTAS)
Description: Reference and syntax for the CTAS SQL command.
parent: SQL commands
---

# CREATE FACT or DIMENSION TABLE...AS SELECT

Creates a table and loads data into it based on the [SELECT](query-syntax.md) query. The table column names and types are automatically inferred based on the output columns of the [SELECT](query-syntax.md). When specifying explicit column names those override the column names inferred from the [SELECT](query-syntax.md).

## Syntax

Fact table:

```sql
CREATE FACT TABLE [IF NOT EXISTS] <table_name>
[(<column_name>[, ...n] )]
PRIMARY INDEX <column_name>[, <column_name>[, ...n]]
[PARTITION BY <column_name>[, <column_name>[, ...n]]]
AS <select_query>
```

Dimension table:

```sql
CREATE DIMENSION TABLE [IF NOT EXISTS] <table_name>
[(<column_name>[, ...n] )]
[PRIMARY INDEX <column_name>[, <column_name>[, ...n]]]
AS <select_query>
```

| Parameter                                       | Description                                                                                                     |
| :----------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- |
| `<table_name>`                                  | An identifier that specifies the name of the external table. This name should be unique within the database. |
| `<column_name>` | An identifier that specifies the name of the column. This name should be unique within the table.               |
| `<select_query`>                                | Any valid select query                                                                                          |
