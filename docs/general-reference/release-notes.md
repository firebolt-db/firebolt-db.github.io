---
layout: default
title: Release notes
nav_order: 5
has_toc: false
parent: General reference
---

# Release notes

Firebolt continuously releases updates so that you can benefit from the latest and most stable service. These updates might happen daily, but for easier readability, we aggregate notification of releases into release notes that cover a longer time period.

The most recent release notes are listed here.

Firebolt might roll out releases in phases. Features and bug fixes may not yet be available in all accounts on the date of release listed.

## Jan. 11, 2022

**SQL and database**

* Added the following functions to handle `NULL` values:
  * `IFNULL ( <expr1>, <expr2> )`. If `<expr1>` is `NULL`, returns `<expr2>`; otherwise returns `<expr1>`.
  * `ZEROIFNULL ( <expr> )`. If `<expr>` is `NULL`, returns `0` otherwise, returns `<expr>`.

* Setting the FDB compression at the DB level is now supported using the flag use_compressed_parts. Default=false. Unless set (at the DB level), the DB will use the default region setting [INTERNAL ONLY].

**Bug fixes**
* Fixed an issue that could cause a failure when canceling a query run on external tables.
* Fixed an issue that prevented using the `REPLACE` keyword within the `CREATE VIEW` statement.


{: .note}
Earlier version release notes are available in the [release notes archive](https://www.notion.so/Firebolt-release-notes-5669618c83904f67949c481be383f784).
