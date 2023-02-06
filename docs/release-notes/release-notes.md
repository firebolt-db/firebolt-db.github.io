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

## DB version 3.17.0 
**February 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### New features

* #### <!--- FIR--17030 --->Added support for GROUP BY ALL

  Instead of explicitly listing all grouping elements in the `GROUP BY` clause, [use `GROUP BY ALL`](../sql-reference/commands/select.md#group-by-all) to automatically infer them from the `SELECT` list.

* #### <!--- FIR-16795 —-->New BYTEA data type

  Use the new [`BYTEA` data type](../general-reference/bytea-data-type.md) to store binary data, like images, other multimedia files, or raw bytes of information.

* #### <!--- FIR-16922 —-->New functions [ENCODE](../sql-reference/functions-reference/encode.md) and [DECODE](../sql-reference/functions-reference/decode.md)

  Use [these functions](../sql-reference/functions-reference/index.md#bytea-functions) with the new `BYTEA` data type to encode binary data into a SQL expression of type `TEXT`, and decode from type `TEXT` to type `BYTEA`.

* #### <!--- FIR-17196 --->Added support for EXCLUDE columns in SELECT *

  [Added support for `EXCLUDE` columns in SELECT *](../sql-reference/commands/select.md#select-wildcard) to define which columns to exclude from a SELECT wildcard expansion. 

* #### <!--- FIR-16745 --->New setting for parsing literal strings

  [New setting](../general-reference/system-settings.md#enable-parsing-for-literal-strings) `standard_conforming_strings` controls whether strings are parsed without escaping, treating backslashes literally.

* #### <!--- FIR-13489 --->New keyboard shortcuts (UI release)

  Use new [keyboard shortcuts](../using-the-sql-workspace/keyboard-shortcuts-for-sql-workspace.md) in the SQL workspace to save and close scripts, and expand or collapse the results pane. 

    * Close the current script in the SQL workspace with **Ctrl + Alt + x** for Windows & Linux, or **⌘ + Option + x** for Mac
    * Close all scripts in the SQL workspace with **Ctrl + Alt + g** for Windows & Linux, or **⌘ + Option + g** for Mac
    * Close all scripts except the one you are working on in the SQL workspace with **Ctrl + Alt + o** for Windows & Linux, or **⌘ + Option + o** for Mac
    * Save the current script in the SQL workspace with **Ctrl + Alt + s** for Windows & Linux, or **⌘ + Option + s** for Mac
    * Expand or collapse the results pane in the SQL workspace with **Ctrl + Alt + e** for Windows & Linux, or **⌘ + Option + e** for Mac

### Enhancements, changes, and new integrations

* #### <!--- FIR-12244 —-->Added support for CREATE TABLE as an alias for CREATE FACT TABLE

  [Added support for `CREATE TABLE` syntax](../sql-reference/commands/create-fact-dimension-table.md), with the default as fact table. `PRIMARY INDEX` is now also optional for fact tables.

* #### <!--- FIR-17189 --->Added support for the DECIMAL data type with the ARRAY\_SORT function

  [ARRAY_SORT](../sql-reference/functions-reference/array-sort.md) has been added as a function supporting the [DECIMAL data type](../general-reference/decimal-data-type.md#supported-functions-beta-release).

* #### <!--- FIR-11888 --->Minimize results in the SQL workspace (UI release)

  The results pane in the SQL workspace can now be minimized. Expand or collapse by double-clicking on the "Results" pane header, using the height control button to drag and change the size of the pane as desired, or using the keyboard shortcut **Ctrl + Alt + e**  for Windows & Linux, or **⌘ + Option + e** for Mac.

  ![](../assets/images/release-notes/expandcollapse.gif)

* #### <!--- FIR-10855 --->Primary index columns highlighted in columns object viewer (UI release)

  The columns pane in the object viewer now highlights columns that are part of a table's primary index, making it easier to identify primary indexes and the order of the columns in the primary index. 

  ![](../assets/images/release-notes/pihighlight.png)

### Resolved issues

* <!--- FIR-9797 —-->Fixed an issue where `COPY TO` export file size was limited to 2GB.

* <!--- FIR-14828 --->Fixed an issue that allowed more than one argument in `CONCAT`.

* <!--- FIR-11381 —-->Returns an error when dynamic functions are used in aggregating indexes. 

