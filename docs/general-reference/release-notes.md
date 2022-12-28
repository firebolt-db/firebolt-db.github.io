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

## December 28, 2022

* [New features](#new-features)
* [Resolved issues](#resolved-issues)

### New features

* #### <!--- FIR-13527 —-->Added support for TSV TYPE options on ingest
**(DB version 3.15.0)**

  Added support for additional TYPE options for the [`CREATE EXTERNAL TABLE` command](../sql-reference/commands/create-external-table.md#type), to allow configuration for ingesting different TSV file formats. Some of these options may be available in previous versions. 

### Resolved issues

* <!--- FIR-16182 —-->Fixed an issue causing an `Internal Hash error` error with multiple occurrences of asterisk characters in nested views. (DB version 3.15.0)