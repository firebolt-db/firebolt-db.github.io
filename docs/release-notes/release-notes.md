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
- [URL_ENCODE](../sql-reference/functions-reference/url_encode.md) percent-encodes all non _unreserved characters_; for example, ```SELECT URL_ENCODE(` !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\`abcdefghijklmnopqrstuvwxyz{|}~`);``` returns: %20%21%22%23%24%25%26%27%28%29%2A%2B%2C-.%2F0123456789%3A%3B%3C%3D%3E%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%5E_%60abcdefghijklmnopqrstuvwxyz%7B%7C%7D~
- [URL_DECODE](../sql-reference/functions-reference/url_decode.md) decodes percent-encoded characters; for example, ```SELECT URL_DECODE('https://www.firebolt.io/?example_id%3D1%26hl%3Den');```
returns: https://www.firebolt.io/?example_id=1&hl=en

#### New GENERATE_SERIES function

Support has been added for the [GENERATE_SERIES function](../sql-reference/functions-reference/generate-series.md) to generate a list of values based on the start, stop, and optional configurable increment step. 

### Enhancements, changes, and new integrations

#### Updates to CSV ingestion
TRUE and FALSE are now accepted as valid `BOOLEAN` values when ingesting CSV files.

