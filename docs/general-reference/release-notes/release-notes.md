---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
parent: General reference
nav_order: 1
has_toc: false
has_children: false
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the latest version are below. 

- See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## DB version 3.31
**March 2024**

* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### Enhancements, changes and new integrations

<!--- FIR-27548 --->**Simplified table protobuf representation**

Unique constraints in tables will be blocked for new accounts.

<!--- FIR-29729 --->**Renamed spilled metrics columns**

The columns `spilled_bytes_uncompressed` and `spilled_bytes_compressed` of `information_schema.query_history` have been replaced by a single column [`spilled_bytes`](../general-reference/information-schema/query-history-view.md). It contains the amount of data that was spilled to disk temporarily while executing the query.

<!--- FIR-28276 --->**New requirements updated for EXPLAIN**

For [`EXPLAIN`](../sql-reference/commands/explain.md) queries, we now allow only one of the following options at the same time: `ALL`, `LOGICAL`, `PHYSICAL`, `ANALYZE`.`EXPLAIN (ALL)` now returns the plans in multiple rows instead of multiple columns.

<!--- FIR-29660 --->**Range violation implement for import of parquet INT columns into PDGATE columns**

Reading of Parquet/ORC integer columns will now not be allowed if the external table specifies the types of those columns to be one of the new DATE, TIMESTAMP, TIMESTAMPTZ types.

<!--- FIR-29225 --->**Syntax and planner support for LATERAL scoping**

[LATERAL](../reserved-words.md) is now a reserved keyword. It must now be used within double-quotes when using it as an object identifier

<!--- FIR-25080 --->**Spilling Joins Processing**

Firebolt can now process inner and outer joins that exceed the available main memory of the engine by spilling to the the SSD cache when needed. This happens transparently to the user. A query that made use of this capability will populate the `spilled_bytes` column in `information_schema.query_history`.

### Resolved issues

* <!--- FIR-28623 --->Fixed a bug where floating point values `-0.0` and `+0.0`, as well as `-nan` and `+nan` were not considered equal in distributed queries.

* <!--- FIR-18709 --->Updated error log for upload failure for clarity

* <!--- FIR-29759 --->TRY_CAST from TEXT to NUMERIC now works as expected: if the value cannot be parsed as NUMERIC it produces null