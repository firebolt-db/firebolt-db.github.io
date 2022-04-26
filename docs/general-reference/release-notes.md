---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
nav_order: 6
has_toc: false
has_children: true
parent: General reference
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the past 30 days are below. See the [Release notes archive](release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## April 26, 2022

* [New features](#new-features)
* [Enhancements, changes, and resolved issues](#enhancements-changes-and-resolved-issues)

### New features

* **New engine instance types (Beta)**  
  Added support for creating engines using [i3en instance types](https://aws.amazon.com/ec2/instance-types/i3en/){:target="_blank"} (i3en.2xlarge, i3en.6xlarge, and i3en.12xlarge). These storage optimized instances offer the lowest price per GB of SSD instance storage. This new class of instances is ideal for workloads with demanding query performance requirements that must keep large amounts of data in engine cache. To see instance details and cost per hour, add or edit an engine and then choose the i3en instances from the **Engine spec** list.

### Enhancements, changes, and resolved issues

* **Improved query execution experience (Beta)**  
  When a query takes a long time to run in the Firebolt UI, it is no longer required to run the query in async mode.
  