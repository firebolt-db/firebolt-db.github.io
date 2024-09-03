---
layout: default
title: Release notes
description: Latest release notes for the Firebolt data warehouse.
parent: General reference
nav_order: 1
has_toc: false
has_children: false
---

{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/godocs/).

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but we aggregate release notes to cover a longer time period for easier reference. The most recent release notes from the latest version are below. 

- See the [Release notes archive](../release-notes/release-notes-archive.md) for earlier-version release notes.

{: .note}
Firebolt might roll out releases in phases. New features and changes may not yet be available to all accounts on the release date shown.

## DB version 3.32
**April 2024**

* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### Enhancements, changes and new integrations

<!--- FIR-31191 --->**New Identifier Rules for Table Expression Query**

In order to prevent table expression query failure, new structure for naming conventions have been added. The first character of an identifier must now be either a letter (a-z) or an underscore (_). After the initial character, identifiers can include letters, underscores, or digits (0-9). 

<!--- FIR-25079 --->**Spilling Aggregations**

Firebolt can now process most aggregations that exceed the available main memory of the engine by spilling to the SSD cache when needed. This happens transparently to the user. A query that made use of this capability will populate the `spilled_bytes` column in `information_schema.engine_query_history`. Spilling does not support aggregations where a single group exceeds the available memory (e.g., `select count(distinct high_cardinality_column) from huge_table`) and may not yet work reliably for all aggregate functions or engine specs. We will continue improving the feature in upcoming releases.

<!--- FIR-30398 --->**Align the syntax of our escape string literals with PostgreSQL**

Escape [string literals](../data-types.md) now support octal and Unicode escape sequences. As a result, escape string literals now behave exactly like PostgreSQL. Example: `SELECT E'\U0001F525b\x6F\154t';` returns `🔥bolt`. If the setting `standard_conforming_strings` is not enabled for you, regular string literals (e.g., `SELECT 'foo';`) will also recognize the new escape sequences. However, we recommend exclusively using escape string literals for using escape sequences. Please be aware that you will get different results if you previously used (escape) string literals containing the syntax we now use for Unicode and octal escape sequences.

<!--- FIR-29729 --->**Remove old deprecated REGENERATE AGGREGATING INDEX**

 `REGENERATE AGGREGATING INDEX` syntax has been removed.  

 **Disable Data Definition Language (DDL)**
 
 In previous versions, we provided the capability for users to execute Data Definition Language (DDL) statements on the system engine through the activation of a designated feature flag. However, subsequent analysis has revealed that this functionality is not widely utilized and presents considerable challenges in terms of providing efficient support for this capability in the forthcoming version of Firebolt. As a result, the decision has been made to disable the feature that permits the execution of DDL operations on the system engine in the current version of Firebolt. We recommend that users migrate these operations to the user engine. For operations such as creation, modification, and deletion pertaining to the engine, users are advised to utilize the Web User Interface.