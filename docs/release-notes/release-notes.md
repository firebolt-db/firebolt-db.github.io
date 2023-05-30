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


## DB version 3.23
**May 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  
### New features

* #### <!--- FIR-18691 —--> **Added support for functions REGEXP\_EXTRACT and REGEXP\_EXTRACT\_ALL**

  Use these functions to extract matching patterns within an input expression. The [REGEXP\_EXTRACT](../sql-reference/functions-reference/regexp-extract.md) function extracts the first match only (from the left), [REGEXP\_EXTRACT\_ALL](../sql-reference/functions-reference/regexp-extract-all.md) function extracts all the matches.

* #### <!--- FIR-22914 ---> **System Engine (Beta)**

  Use the new [system engine](../working-with-engines/system-engine.md) to run metadata-related queries without having to start a separate engine. The system engine is always available in all databases to select and use. 

  {: .note}
  System engine is currently only available for accounts that have a single region enabled.

### Enhancements, changes and new integrations

* #### <!--- FIR-22195 ---> Support for AWS Glue with external tables has been removed. 

  Using AWS Glue with external tables has been deprecated. Support for this feature may be added back in the future, once optimizations to supporting architecture have been added. 

* #### <!--- FIR-22036 ---> Increasing max session duration is no longer required when setting up AWS roles to access Amazon S3

  Roles are now assumed with a default expiration time of 1 hour, and re-assumed every 30 minutes during ingest so ingests can take longer than 12 hours.

* #### <!--- FIR-22036 --->  Increased validation for CREATE TABLE parameters

  Unknown parameters in a `CREATE TABLE` statement will now cause the statement to be rejected. 

* #### <!--- FIR-23446 --->  Update to non-explicit column names

  Final result column names may be different compared to previous versions; specifically, for any select list item that does not have an explicit alias assigned, the final name of that column may be "?column?". Please assign explicit aliases to any select list expression which you want to refer to either in the same query or in other queries.

* #### Join index improvements

  Starting in version 3.23, manually creating and refreshing join indexes will no longer be necessary -  with Auto join indexes, results are now always up to date even if the underlying data changed.

### Resolved issues

* <!--- FIR-19227 ---> Fixed an issue causing a discrepancy in results of the `SHOW CACHE` command.

* <!--- FIR-16262 ---> Fixed multiple planner bugs where queries would not compile.

* <!--- FIR-22968 ---> Improved ingest stability, fixed an issue causing failed ingests on a general purpose engine.