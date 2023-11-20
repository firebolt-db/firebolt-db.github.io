---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
parent: General reference
nav_order: 1
has_toc: false
has_children: false
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the latest version are below. 

<!--- See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes. -->

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## DB version 3.30
**November 2023**

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

<!--- FIR-27590 ---> **New comparison operators**

[New comparison operators](../general-reference/operators.md) `IS DISTINCT FROM` and `IS NOT DISTINCT FROM` have been added.

### Enhancements, changes and new integrations

<!--- FIR-27355 ---> **Support for nullable arrays**

Support has been added to allow the [ANY_MATCH](../sql-reference/functions-reference/any-match.md) lambda function to work with nullable arrays

### Resolved issues

* Indirectly granted privileges have been removed from the `information_schema.object_privileges` view. 

* Fixed an issue where `ARRAY_FIRST` and `ARRAY_FIRST_INDEX` returned an error if the given input was nullable.