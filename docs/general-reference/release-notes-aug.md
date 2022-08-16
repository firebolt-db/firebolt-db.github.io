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

## August 2022

* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)
* [Resolved issues](#resolved-issues)

### Enhancements, changes, and new integrations

* #### <!--- FIR-3345 --> Added [DECIMAL](/selectdata-types.md#decimal) data type - DECIMAL(p,s). Numbers up to 38 digits, with an optional precision and scale 
 The maximum scale <= precision. By default, the precision is 38 and the scale is 0. 
    
 Synonymous with NUMERIC.

 Feature flag: firebolt\_use_decimal
    
For more information, see [DECIMAL](/selectdata-types.md#decimal).

* #### <!--- FIR-15022 --> VERSION function can be used to identify the current running version

* #### <!--- FIR-14195 --> QUERY\_HISTORY and RUNNING\_QUERIES views can now be queried via the INFORMATION\_SCHEMA as well

* #### <!--- FIR-10324 --> Added support for Multi-factor authentication (MFA)

 Firebolt now supports Multi-factor authentication (beta). For more information, see [Configuring MFA for users (Beta)
](../managing-your-account/managing-users.md#configuring-mfa-for-users-beta)

* #### <!--- FIR-10324 --> Added support for the hll\_count\_distinct(input, [, precision]) function

 Requires less memory than exact aggregation functions, like COUNT(DISTINCT), but also introduces statistical uncertainty. The default precision is 12.

* #### <!--- FIR-10136 --> Added type aliases REAL, FLOAT4, FLOAT8, INT4, INT8, and FLOAT(p)

* #### <!--- FIR-8896 --> INFORMATION_SCHEMA.COLUMNS now includes more metadata on columns as well as columns for views in a given database

* #### <!--- FIR-8437 --> Added an indication of the active script in the browser tab and SQL workspace

* #### <!--- FIR-7229 --> Added dark mode

 Firebolt now supports an additional color theme - dark mode. You can toggle between light and dark modes in the UI.

* #### <!--- FIR-6523 --> Added support for exact percentile aggregations using PERCENTILE\_CONT function

* #### <!--- FIR-10347 --> Added support for IP allowed & blocked lists (beta)

 Allows access to your Firebolt account from specific IP addresses. For more information, see [Allowing and blocking source IP addresses for users (Beta)
](../managing-your-account/managing-users.md#allowing-and-blocking-source-ip-addresses-for-users-beta)

### Resolved issues

* <!--- FIR-11369 --> An error message is now displayed when too many partitions are added using a single INSERT statement.

* <!--- FIR-11193-->  Fixed an issue where casting to timestamp concatenated strings representing the date and time parts returned an incorrect timestamp value.