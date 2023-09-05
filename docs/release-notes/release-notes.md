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


## DB version 3.27
**September 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### New features

#### Add `URL_DECODE` and `URL_ENCODE` SQL functions
- `URL_ENCODE` percent-encodes all non "Unreserved Characters"
- `URL_DECODE` decodes percent-encoded characters

#### New GENERATE_SERIES function
Add GENERATE_SERIES function to generate a list of values based on the start, stop, and optional configurable increment step. Start/Stop can be either numeric or timestamp, while step can be either numeric or interval. 

### Enhancements, changes, and new integrations

#### Updates to CSV ingestion
Allow `true` and `false` as valid boolean values when ingesting csv files

