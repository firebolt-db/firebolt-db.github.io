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

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the past month are below. See the [Release notes archive](release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## October 2022

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

* #### <!--- FIR-15853 —-->Added support for functions REGEXP\_REPLACE and REGEXP\_REPLACE\_ALL
**(DB version 3.11.0)**

  Use these functions to replace matching patterns in the input with a replacement. The [REGEXP\_REPLACE](../sql-reference/functions-reference/regexp-replace.md) function replaces the first match only (from the left), [REGEXP\_REPLACE\_ALL](../sql-reference/functions-reference/regexp-replace.md) function replaces all the matches.

### Enhancements, changes, and new integrations

* #### <!--- FIR-14886 —-->Added support for “OR” operator for JOIN 
**(DB version 3.11.0)**

  Allows performing JOINs with multiple join conditions linked via the “OR” operator

* #### <!--- FIR-15683 —-->Updated syntax to generate an aggregating index 
**(DB version 3.11.0)**

  The [CREATE AGGREGATING INDEX](../sql-reference/commands/create-aggregating-index.md) command will now generate the aggregating index, without using the additional AND GENERATE clause. 

* #### <!--- FIR-15452 —-->Added support for window function frame definitions
**(DB version 3.11.0)**

  Add support for n PRECEDING, n FOLLOWING, and CURRENT ROW when defining the frame start and end in window functions.

* #### <!--- FIR-15022 —-->VERSION() function now available
**(DB version 3.8.0)**

  Query the engine version using the new [VERSION()](../sql-reference/functions-reference/version.md) function. Engine version is also now available as a column in the [information\_schema.engines](../general-reference/information-schema/engines.md) view. 

* #### <!--- FIR-15152 —--> Information schema updated
**(DB version 3.8.0)**

  System-defined tables metadata can now be queried via the [information\_schema.tables](../general-reference/information-schema/tables.md) view.



