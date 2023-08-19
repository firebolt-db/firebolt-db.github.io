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


## DB version 3.26
**September 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### New features

* #### New setting to limit rows in result

  [A new setting](../general-reference/system-settings.md#limit-the-number-of-result-rows) `max_result_rows` controls the limit of rows in result sets. The default value of the `max_result_rows` setting is 0.

### Enhancements, changes and new integrations

* #### <!--- FIR-24598 ---> Improved support for interval arithmetic

  You can now use the expression:
  `date_time + INTERVAL * d`
  where `date_time` is a constant or column reference of type `DATE`, `TIMESTAMP`, `PGDATE`, `TIMESTAMPNTZ`, or `TIMESTAMPTZ`, and `d` is a constant or column reference of type `DOUBLE PRECISION`. The effect is that the `INTERVAL` is scaled by `d`, and the resulting `INTERVAL` is added to `date_time`. For example: 
  `INTERVAL '1 day' * 3 -> INTERVAL '3 days'`

### Resolved issues

* <!--- FIR-23676 ---> Fixed an issue where query progress was not reflected in the `information_schema.running_queries` table.

* <!--- FIR-25396 ---> Significantly increased performance of the `COPY TO` function.