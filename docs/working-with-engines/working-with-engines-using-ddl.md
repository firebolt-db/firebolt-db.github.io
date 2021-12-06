---
layout: default
title: Working with engines using DDL
nav_order: 2
parent: Working with engines
---

# Working with engines using DDL

You can execute the operations on engines listed below using SQL statements.

* [List \(SHOW\) engines](working-with-engines-using-ddl.md#to-list-show-all-engines-in-your-firebolt-account)
* [Start an engine](working-with-engines-using-ddl.md#to-start-an-engine)
* [Stop an engine](working-with-engines-using-ddl.md#to-stop-an-engine)
* [Create an engine](working-with-engines-using-ddl.md#to-create-an-engine)
* [Attach an engine to a database](working-with-engines-using-ddl.md#to-attach-an-engine-to-a-database)
* [Edit \(ALTER\) an engine](working-with-engines-using-ddl.md#to-edit-alter-an-engine)
* [Delete \(DROP\) an engine](working-with-engines-using-ddl.md#to-delete-drop-an-engine)

## To list \(SHOW\) all engines in your Firebolt account

* Using a running engine, execute the `SHOW ENGINES` statement as shown in the example below.

```sql
SHOW ENGINES;
```

The statement returns a list of engines by name, including the region, engine specification, scale, status, and attached database.

## To start an engine

* Using a running engine, execute a `START ENGINE` statement similar to the example below.

```sql
START ENGINE MyDatabase_MyFireboltEngine
```

## To stop an engine

* Execute a `STOP ENGINE` command using a running engine similar to the example below. You can use the same engine that you are stopping.

```sql
STOP ENGINE MyDatabase_MyFireboltEngine
```

## To create an engine

* Using a running engine, execute a `CREATE ENGINE` statement similar to one of the examples below. For more information, see [CREATE ENGINE](../sql-reference/commands/ddl-commands.md#create-engine).

### Example - Create engine using default values

```sql
CREATE ENGINE MyDatabase_MyFireboltEngine;
```

`GENERAL_PURPOSE` is the default engine type if none is specified.

### Example - Create an analytics engine, specifying all properties

```sql
CREATE ENGINE MyDatabase_MyFireboltEngine WITH  
    REGION = 'us-west-2'  
    ENGINE_TYPE = DATA_ANALYTICS  
    SCALE = 32  
    SPEC = 'c5d.4xlarge'  
    AUTO_STOP = '45'  
    WARMUP = PRELOAD_ALL_DATA;
```

## To attach an engine to a database

This action is available only using DDL.

* Using a running engine, execute an `ATTACH ENGINE` statement similar to the example below.

  ```sql
  ATTACH ENGINE MyDatabase_MyFireboltEngine TO MyDatabase;
  ```

## To edit \(ALTER\) an engine

* Using a running engine, execute an `ALTER ENGINE` statement similar to the example below.

```sql
ALTER ENGINE MyDatabase_MyFireboltEngine SET  
    SCALE = 12  
    SPEC = 'c5d.4xlarge'  
    AUTO_STOP = '45'  
    RENAME TO 'MyProductionDatabase_MyFireboltEngine'  
    WARMUP = PRELOAD_ALL_DATA;
```

## To delete \(DROP\) an engine

* Using a running engine, execute a `DROP ENGINE` SQL statement similar to the example below.

```sql
DROP ENGINE MyDatabase_MyFireboltEngine;
```
