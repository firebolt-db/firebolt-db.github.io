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

## December 2022

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

* #### <!--- FIR-3917 —-->Added support for CSV TYPE options on ingest
**(DB version 3.14.0)**

  Added support for additional TYPE options for the [CREATE EXTERNAL TABLE command](../sql-reference/commands/create-external-table.md#type), to allow configuration for ingesting different CSV file formats. Some of these options may be available in previous versions. 

  * `[ALLOW_DOUBLE_QUOTES = {TRUE|FALSE}]`, `[ALLOW_SINGLE_QUOTES = {TRUE|FALSE}]`: Define that unescaped double or single quotes in CSV input file will not cause an error to be generated on ingest. 

  * `[ALLOW_COLUMN_MISMATCH = {TRUE|FALSE}]`: Defines that the number of delimited columns in a CSV input file can be fewer than the number of columns in the corresponding table. 

  * `[ALLOW_UNKNOWN_FIELDS = {TRUE|FALSE}]`: Defines that the number of delimited columns in a CSV input file can be more than the number of columns in the corresponding table. 

  * `[ESCAPE_CHARACTER = {‘<character>’|NONE}`: Defines which character is used to escape, to change interpretations from the original. 

  * `[FIELD_DELIMITER = '<field_delimeter>']`: Defines a custom field delimiter to separate fields for ingest. 

  * `[NEW_LINE_CHARACTER = '<new_line_character>']`: Defines a custom new line delimiter to separate entries for ingest. 

  * `[NULL_CHARACTER = '<null_character>']`: Defines which character is interpreted as `NULL`. 

  * `[SKIP_BLANK_LINES {TRUE|FALSE}]`: Defines that any blank lines encountered in the CSV input file will be skipped. 

### Enhancements, changes, and new integrations

* #### <!--- FIR-16182 —-->**Added support for nullable arrays** 
**(DB version 3.11.0)**

  Nullable type is now generally available for arrays, enabled for DB version 3.11 and above. 
