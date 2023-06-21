---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
nav_order: 2
has_toc: false
has_children: true
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the latest version are below. See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.


## DB version 3.24
**June 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  
### New features

* #### <!--- FIR-18691 —--> **Added support for functions HLL_COUNT_BUILD, HLL_COUNT_EXTRACT and HLL_COUNT_MERGE_PARTIAL**

  [HLL_COUNT_BUILD](../sql-reference/functions-reference/hll-count-build.md) uses the HLL++ algorithm and allows you to control the set sketch size precision, aggregating input values to an HLL++ sketch represented as the `BYTEA` data type. Later individual sketches can be merged to a single sketch using the aggregate function [HLL_COUNT_MERGE_PARTIAL](../sql-reference/functions-reference/hll-count-merge-partial.md), or the estimated cardinality extracted (to get the final estimated distinct count value) using the [HLL_COUNT_EXTRACT](../sql-reference/functions-reference/hll-count-extract.md) scalar function.

* #### <!--- FIR-21223 ---> **Added support for new function PARAM()**

  Use the new [PARAM function]() to reference values of query parameters. 

### Enhancements, changes and new integrations

* #### <!--- FIR-22195 ---> Added UTF-8 validation for text fields

  All text fields (both literals and those from an external source) must be UTF-8 encoded to pass validation. To store strings that are not UTF-8 encoded, use the `BYTEA` data type as an alternative. 

* #### <!--- FIR-22642 --->  Nullability for CREATE TABLE columns

  All columns in tables created using `CREATE TABLE AS SELECT` are now nullable. In addition, multiple anonymous column names in a `CREATE TABLE` statement will now cause the statement to be rejected.

* #### <!--- FIR-23522 ---> Update to the relationship of floating point NaN to other numbers

  The value of floating point NaN is always the largest when compared to other numeric values, for example: 
  `-∞ < any number < ∞ < NaN`.

### Resolved issues

* <!--- FIR-24007 ---> Fixed an issue preventing columns with spaces from being used in the primary index definition.

* <!--- FIR-23842 ---> Fixed an issue where adding filters on a partition key could affect query performance.

* <!--- FIR-22286 ---> Fixed an issue causing chained UNION/INTERSECT operations to be applied in the wrong order.
