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

## DB version 3.20.0 
**March 2023**

* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  
### Enhancements, changes, and new integrations

* #### <!--- FIR-20900 —--> Function support added for new `PGDATE`, `TIMESTAMPTZ`, and `TIMESTAMPNTZ` data types

  The following new and updated functions can now be used with new data types `PGDATE`, `TIMESTAMPTZ`, and `TIMESTAMPNTZ`.

  * [TO_CHAR](../sql-reference/functions-reference/to-char-new.md)
  * [CURRENT_PGDATE](../sql-reference/functions-reference/current-pgdate.md)
  * [LOCALTIMESTAMPNTZ](../sql-reference/functions-reference/localtimestampntz.md)
  * [CURRENT_TIMESTAMPTZ](../sql-reference/functions-reference/current-timestamptz.md)
  * [TO_TIMESTAMPTZ](../sql-reference/functions-reference/to-timestamptz.md)

{: .warning}
  >**To use the new data types, new external and dimension/fact tables must be created. Reingest will be required to recognize new precision.**
  >* To ingest from an existing table into a new table using the new types, simply cast a column of type `DATE` to `PGDATE` and a column of type >`TIMESTAMP` to `TIMESTAMPNTZ`. 
  >* To ingest into a new table using the new types from external data, create an external table with the new types.
  >
  >Starting in the next version, you will have the option to use the type names `DATE` and `TIMESTAMP` instead of new type names `PGDATE` and `TIMESTAMPNTZ`, but data must be reingested using the new types before this option is enabled. `TIMESTAMPTZ` will remain the same, as that is a new type added. Please raise any questions or feedback with your Customer Success team.

* #### <!--- FIR-18850 —--> Changed NULL behavior of `CONCAT` function

  NULL inputs to [the `CONCAT` function](../sql-reference/functions-reference/concat.md) are now treated as empty strings, therefore any NULL inputs are ignored. When all inputs are NULL, the result will be an empty string. When using `||`, any NULL input still retains the old behavior and results in a NULL output.

{: .warning}
  >If you are using the `CONCAT` function on strings with NULL inputs and you don't want NULL values to be ignored, you will need to use the `||` function instead.
  
* #### <!--- FIR-21015 —--> Additional syntax for ARRAY data type names

  Syntax options for defining columns with [the `ARRAY` data type](../general-reference/data-types.md#array) have been updated to include `<data-type>[]` and `<data-type> ARRAY`. Array element type is nullable when using the new syntax options. 

  For example, the following three queries will create tables with the same `demo_array` column of type `ARRAY` of nullable `TEXT`.

  ```sql
  CREATE DIMENSION TABLE demo1 (
  demo_array ARRAY(TEXT NULL)
  );
  
  CREATE DIMENSION TABLE demo2 (
  demo_array TEXT[]
  );

  CREATE DIMENSION TABLE demo3 (
  demo_array TEXT ARRAY
  );
  ```
 To specify the constraint for an array element to be not nullable, you must then use `ARRAY(<data-type> NOT NULL)` syntax.

* #### <!--- FIR-20822 —--> Added flag support for `REGEXP_LIKE`

  The [`REGEXP_LIKE` function](../sql-reference/functions-reference/regexp-like.md) now supports an optional `<flag>` input, to allow additional controls over the regular's expression matching behavior.

  For example, the `i` flag causes the regular expression matching in the following query to be case-insensitive. Without this flag, the query would not find a match and would return `0`.

  ```sql
  SELECT
	  REGEXP_LIKE('ABC', '[a-z]', 'i'); ---> 1
  ```

* #### <!--- FIR-20808 —--> Parquet and ORC support added for binary data type

  Binary type data from external Parquet or ORC file types will now be ingested directly with [the data type `BYTEA`](../general-reference/bytea-data-type.md#importing-bytea-from-external-source). Previously, data were ingested as type `TEXT` and then converted to data type `BYTEA`. 

* #### <!--- FIR-21179 —--> Export all results from the SQL Workspace  (UI release)

  [Exporting the entire results section](../using-the-sql-workspace/using-the-sql-workspace.md#exporting-results-to-a-local-hard-drive) from the SQL Workspace in CSV or JSON format is now supported.

* #### <!--- FIR-19287 —-->Renamed column from `information_schema.tables`

  Renamed the `number_of_segments` column from `information_schema.tables` to `number_of_tablets` to better reflect Firebolt's data structure.

* #### <!--- FIR-21118 —--> Added support for empty statements

  Empty statements containing comments only are now supported and will run without error. 

### Resolved issues

* <!--- FIR-20808 —-->Fixed an issue where `AVG` and `SUM` functions performed on large `DECIMAL` columns produced an error; results now use the same precision and scale as the input type. 
