---
layout: default
title: SQL commands
description: Reference for SQL commands and operators in Firebolt.
nav_order: 14
has_children: true
has_toc: false
---

# SQL commands

Use the alphabetical list in the navigation pane to find the syntax for commands that you already know.

Use the functional list below to find commands for a specific task area that you're working in.

* [Engines](#engines)  
  Start, stop, and manage Firebolt engines.

* [Data ingest and movement](#data-ingest-and-movement)  
  Move data between your data lake and Firebolt, and betweeen Firebolt resources.

* [Database objects](#database-objects)  
  DDL. Create, alter, drop, and otherwise manage objects like databases, tables, and views in your Firebolt account.

* [Data manipulation (beta)](#data-manipulation)  
  DML. Update data or delete data from tables in your Firebolt account. 

* [Queries and query optimization](#queries-and-query-optimization)  
  Analyze data with `SELECT`. Tune and optimize query performance with other commands.

* [Information schema](#information-schema)  
  Query the Firebolt information schema for metadata related to Firebolt objects and resources.

## Engines

* [ALTER ENGINE](alter-engine.md)
* [ATTACH ENGINE](attach-engine.md)
* [CREATE ENGINE](create-engine.md)
* [DETACH ENGINE (deprecated)](detach-engine.md)
* [DROP ENGINE](drop-engine.md)
* [SHOW CACHE](show-cache.md)
* [SHOW ENGINES](show-engines.md)
* [START ENGINE](start-engine.md)
* [STOP ENGINE](stop-engine.md)

## Data ingest and movement

* [ALTER TABLE...DROP PARTITION](alter-table-drop-partition.md)
* [CREATE EXTERNAL TABLE](create-external-table.md)
* [INSERT INTO](insert-into.md)
* [COPY TO](copy-to.md)

## Database objects

* [ALTER TABLE...DROP PARTITION](alter-table-drop-partition.md)
* [CREATE AGGREGATING INDEX](create-aggregating-index.md)
* [CREATE DATABASE](create-database.md)
* [CREATE EXTERNAL TABLE](create-external-table.md)
* [CREATE FACT or DIMENSION TABLE](create-fact-dimension-table.md)
* [CREATE JOIN INDEX](create-join-index.md) (legacy)
* [CREATE VIEW](create-view.md)
* [DESCRIBE](describe.md)
* [DROP DATABASE](drop-database.md)
* [DROP TABLE](drop-table.md)
* [DROP VIEW](drop-view.md)
* [INSERT INTO](insert-into.md)
* [REFRESH JOIN INDEX](refresh-join-index.md) (legacy)
* [SHOW COLUMNS](show-columns.md)
* [SHOW DATABASES](show-databases.md)
* [SHOW TABLES](show-tables.md)
* [TRUNCATE TABLE](truncate-table.md)

## Data manipulation

* [UPDATE (beta)](update.md)
* [DELETE (beta)](delete.md)

## Queries and query optimization

* [CREATE AGGREGATING INDEX](create-aggregating-index.md)
* [DROP INDEX](drop-index.md)
* [EXPLAIN](explain.md)
* [SELECT](select.md)
* [SHOW INDEXES](show-indexes.md)
* [COPY TO](copy-to.md)
* [VACUUM (beta)](vacuum.md)

## Metadata

* [DESCRIBE](describe.md)
* [SHOW CACHE](show-cache.md)
* [SHOW COLUMNS](show-columns.md)
* [SHOW DATABASES](show-databases.md)
* [SHOW ENGINES](show-engines.md)
* [SHOW INDEXES](show-indexes.md)
* [SHOW TABLES](show-tables.md)
