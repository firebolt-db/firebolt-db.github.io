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

## DB version 3.22
**April 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  
### New features

* #### DATE and TIMESTAMP names available for new data types

  A new option enables the use of familiar type names `DATE` and `TIMESTAMP` as default for the new expanded date and timestamp data types, with synonyms `PGDATE` and `TIMESTAMPNTZ`. `TIMESTAMPTZ` remains the same as a new type added. If you are a new customer starting on DB version 3.22, these new date and timestamp type names will be enabled by default. For more information, see [Date and timestamp data types](../general-reference/data-types.md/#date-and-timestamp).

  {: .warning}
  >For existing customers before DB version 3.22:
  >
  >**To use the new data types, new external and dimension/fact tables must be created and scripts updated to use functions that support these new types. Reingest will be required to recognize new precision.**
  >* To ingest from an existing table into a new table using the new types, simply cast a column of type `DATE` to `PGDATE` and a column of type >`TIMESTAMP` to `TIMESTAMPNTZ`. 
  >* To ingest into a new table using the new types from external data, create an external table with the new types.
  >
  >See [Date and timestamp (legacy)](../general-reference/legacy-date-timestamp.md#legacy-date-and-timestamp-functions) for information about how to adjust scripts for supported functions.

  For existing customers before DB version 3.22, data must be reingested using the new types and scripts updated to use supported functions **before this option is enabled**. Please contact your Customer Success team to enable the `DATE` and `TIMESTAMP` synonymns for new types once you have reingested and adjusted scripts.

* #### <!--- FIR-22348 ---> Schema changes instantly available on analytics engines

  Running engines no longer require a restart for schema changes to be reflected on analytics engines, and changes to the schema are available instantly. Schema changes include: 

    * `DROP/CREATE TABLE`
    * `DROP/CREATE AGGREGATING INDEX`
    * `DROP/CREATE JOIN INDEX`
    * `DROP/CREATE VIEW`



* #### Added support for `UPDATE` and `DELETE` commands

  Data manipulation commands [`UPDATE`](../sql-reference/commands/update.md) and [`DELETE`](../sql-reference/commands/delete.md) are generally available, for use in production workflows. 

* #### Added support for `NUMERIC` data type

  The [`NUMERIC` data type](../general-reference/numeric-data-type.md) (synonym: `DECIMAL`) is now generally available, for use in production workflows. 

### Enhancements, changes, and new integrations

* #### <!--- FIR-14538 ---> Support for OR operator added to all JOIN types

  The `OR` operator can now be used within the join condition for all types of joins. 

* #### <!--- FIR-21206 —--> UI option to explain queries (UI release)

  A new option in the UI supports [explaining statements](../using-the-sql-workspace/using-explain-to-analyze-query-execution.md#opening-visual-explain-after-you-run-a-query) for single and multi-statement scripts.  
  ![](../assets/images/explain_query_icon.png)

* #### <!--- FIR-21206 —--> Visual explain temporarily limited to text view

  Text view for [visual explain](../using-the-sql-workspace/using-explain-to-analyze-query-execution.md#opening-visual-explain-after-you-run-a-query) will be the only supported view temporarily while improvements to visual explain are developed. Other views will be added back in the future. 


### Resolved issues

* <!--- FIR-17251 —--> Improved error message when casting between data types.

* <!--- FIR-14904 ---> Fixed the `NOT` operator to work with all expressions.

* <!--- FIR-14326 ---> Fixed incorrect `source_file_name` metadata generated when an S3 bucket included empty files.

* <!--- FIR-21963 ---> Fixed an issue preventing the flattening of a list of structs when nested structs are included. 

* <!--- FIR-22756 ---> Fixed an issue causing preloaded tablets to merge in an improper order.

* <!--- FIR-23006 ---> Fixed an issue causing a `Sync out` error during delete queries.