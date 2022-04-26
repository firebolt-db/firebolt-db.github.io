---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
nav_order: 8
has_toc: false
has_children: true
parent: General reference
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the past 30 days are below. See the [Release notes archive](release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## May 11, 2022

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### New features

* **Added support for `CREATE OR REPLACE VIEW` statement**  
  The `IF NOT EXISTS` and `OR REPLACE` options are incompatible when creating a view. For more information, see [CREATE VIEW](../sql-reference/commands/create-view.md).

* **Added `ALTER DATABASE` statement**  
  Allows you to change the engine configuration and the database description. For more information, see [ALTER DATABASE](../sql-reference/commands/alter-database.md).

* **Added `TO_CHAR` function**   
  Converts a timestamp or a numeric type to strings in a format that you specify. For more information, see [TO_CHAR](../sql-reference/functions-reference/to-char.md).

* **Materialized CTEs (Beta)**  
  Added an optimization hint to support caching large, computationally expensive CTE results in memory for reuse to increase query performance. For more information, see [SELECT](../sql-reference/commands/select.md#materialized-common-table-expressions-beta).

* **Added support for SET statements passed via SQL in the Python SDK**  

### Enhancements, changes, and new integrations

* **Engine specs are now Firebolt-specific**  
  Firebolt engine spec names have changed from AWS EC2 names to Firebolt-specific names&mdash;for example, **M4**. This change simplifies engine specs and aligns them with Firebolt usage and deployment. This is the first step toward improving the overall engine selection and usage experience, allowing Firebolt to update underlying hardware more quickly and automatically. For more information, see [Working with engines](../working-with-engines/index.md).

* **Expanded application of aggregating indexes**  
  The query optimizer now uses aggregating indexes in more cases to improve performance.

* **Python SDK updates**  
  * Support added for `DECIMAL`, `DATE32`, and `DATETIME64` data types in the Python SDK.
  * Added the ability to disable caching of authentication tokens for use in read-only environments like AWS Lambda.

* **Added a materialization connector in Estuary for Firebolt**  
  For more information, see the [Firebolt materialization connector topic](https://docs.estuary.dev/reference/Connectors/materialization-connectors/Firebolt/) in Estuary documentation.

### Resolved issues

* Fixed an issue where complex join conditions could fail when evaluating `NULL` values.

* Fixed an issue that caused [dropping partitions by date extraction](../working-with-partitions.md#partition-and-drop-by-date-extraction) to fail.

* Fixed an issue that caused `DROP AGGREGATING INDEX` to run slower than expected.

* Fixed an issue with queries containing subqueries, where the outer query limit clause would override the inner query limit clause.

* Fixed an issue that could cause canceling a query to fail if the query was reading an external table.

* Fixed an issue that could prevent aggregating index creation on aggregations used with a few functions (for example, `SUM`, `LENGTH`, and `COUNT`).

* Fixed an issue that caused `NULL`s to be mishandled in some `CASE` statements.

* Fixed an issue that required non-reserved keywords to be enclosed in quotes.

* Fixed the data type for the `number_of_rows` column in `information_schema.tables` from `INT` to `BIGINT`.
