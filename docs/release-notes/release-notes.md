---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
nav_order: 2
has_toc: false
has_children: true
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the past month are below. See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## DB version 3.21.0 
**March 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  
### New features

* #### Data manipulation commands now available (Beta release)

  Beta support is now available for data manipulation commands [UPDATE](../sql-reference/commands/update.md) and [DELETE](../sql-reference/commands/delete.md). A [VACUUM](../sql-reference/commands/vacuum.md) has also been added to optimize frequently updated tables.

  For more information and known limitations in the beta release, please see linked documentation. 

### Enhancements, changes, and new integrations
<!-- 
* #### DATE and TIMESTAMP synonyms available for new data types

  A new option enables the use of familiar type names `DATE` and `TIMESTAMP` as synonyms for the new expanded data types `PGDATE` and `TIMESTAMPNTZ`. `TIMESTAMPTZ` will remain the same as a new type added.  

  {: .warning}
  >**To use the new data types, new external and dimension/fact tables must be created. Reingest will be required to recognize new precision.**
  >* To ingest from an existing table into a new table using the new types, simply cast a column of type `DATE` to `PGDATE` and a column of type >`TIMESTAMP` to `TIMESTAMPNTZ`. 
  >* To ingest into a new table using the new types from external data, create an external table with the new types.

  Data must be reingested using the new types before this option is enabled. Please contact your Customer Success team to enable this option once you have reingested using the new types. If you are a new customer starting on DB version 3.21.0, this option will be enabled by default.  -->

* #### <!--- FIR-18674 —--> Updates to data types

  Firebolt now uses the following built-in type names in `INFORMATION_SCHEMA.COLUMNS` and in auto-generated aliases for `CAST` operations:

    | Standard type | Synonyms |
    | :-------------- | :------- | 
    | `TEXT`          | `STRING`, `VARCHAR` |
    | `INTEGER`       | `INT`, `INT4` |
    | `BIGINT`        | `LONG`, `INT8` |
    | `REAL`          | `FLOAT`, `FLOAT4` |
    | `DOUBLE PRECISION` | `DOUBLE`, `FLOAT8` |
    | `NUMERIC`       | `DECIMAL` |


* #### <!--- --->Parquet, Avro and ORC support added for new data types

  These file types can now be used to ingest new `PGDATE`, `TIMSTAMPNTZ` and `TIMESTAMPTZ` data types. For more information see [data type documention](../general-reference/data-types.md#date-and-time).

  Starting in the next version, you will have the option to use the type names `DATE` and `TIMESTAMP` instead of new type names `PGDATE` and `TIMESTAMPNTZ`, but data must be reingested using the new types before this option is enabled. `TIMESTAMPTZ` will remain the same, as that is a new type added. See [here](release-notes-archive.md#db-version-3200) for instructions to reingest. Please raise any questions or feedback with your Customer Success team. 

### Resolved issues

* <!--- FIR-20551 —-->Fixed an error `Cannot parse input: expected <END OF LINE>` on ingest of large CSV files.
