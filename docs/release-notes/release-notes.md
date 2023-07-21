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


## DB version 3.25
**August 2023**

* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)
  

### Enhancements, changes and new integrations

* #### Deprecation of `catalog` metadata schema

  Support for the `catalog` schema is being phased out in favor of [information_schema views](../general-reference/information-schema/information-schema-and-usage-views.md). To ensure a smooth transition, please update code to use `information_schema` - for example, any query currently reading from `catalog.query_history` or `catalog.running_queries` should be modified to query from `information_schema.query_history` or `information_schema.running_queries`. **Please note, all column names in `information_schema` views are lowercase** - for example, `START_TIME` from `catalog.query_history` is now named `start_time` in the `information_schema.query_history` view.

* #### <!--- FIR-24427 ---> Information schema updated

  Added columns to the [information_schema.databases view](../general-reference/information-schema/databases.md):
   * `compressed_size`
   * `uncompressed_size`
   * `description` 

  Added columns to the [information_schema.engines view](../general-reference/information-schema/engines.md):
   * `engine_type`
   * `auto_stop`
   * `url`
   * `warmup`

### Resolved issues

  * <!--- FIR-23929 ---> Fixed an issue preventing certain array type columns being imported from a Parquet file. 

  * <!--- FIR-25059 ---> Fixed an issue causing `inf` and `nan` values to be incorrectly encoded as `NULL` values. 
