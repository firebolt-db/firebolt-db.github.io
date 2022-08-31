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

* #### <!--- FIR-12825 --> Firebolt .NET SDK now available

  The Firebolt .NET SDK can be used to connect to Firebolt from .NET applications. The SDK supports .NET Core and is available at [NuGet FireboltNetSDK](https://www.nuget.org/packages/FireboltNetSDK/0.0.1).

* #### Firebolt Go SDK now available

  The Firebolt Go SDK can be used to connect to Firebolt from Go applications. The SDK implements the Go database/sql driver specification. For more details, see the package listing at [Firebolt Go SDK](https://pkg.go.dev/github.com/firebolt-db/firebolt-go-sdk).

* #### <!--- FIR-14195 --> Information schema updated<br>
  **(DB version 3.7.0)**

  query\_history and running\_queries views can now be queried via the information\_schema.

  For more information, see [Information schema for query history](information-schema/query-history-view.html) and [Information schema for running queries](information-schema/running-queries.md).

* #### <!--- FIR-10324 --> Added support for Multi-factor authentication (MFA)<br>
  **(Beta)**

  Firebolt now supports Multi-factor authentication. 
 
  You can enable MFA for users or groups with the Firebolt Manager which sends a link to enroll in MFA using a QR code. When a user enrolls in MFA from the email, the status in Firebolt updates to **MFA enabled**.

  **To enable MFA for a Firebolt user or group of users** choose the **User Management** icon in the navigation pane. If the icon isn't available, you don't have Account Admin permissions. 
    
  ![User management icon](../assets/images/user-management.png)
  
  For more information, see [Configuring MFA for users (Beta)](../managing-your-account/managing-users.md#configuring-mfa-for-users-beta).

* #### <!--- FIR-10304 --> Added support for the hll\_count\_distinct(input, [, precision]) function<br>
  **(DB version 3.7.0)**

  Allows for precision control of the count(distinct <expr>) function with an optional precision parameter.
  
  Requires less memory than exact aggregation functions, like `COUNT(DISTINCT)`, but also introduces statistical uncertainty. The default precision is 12, with a maximum of 20.

* #### <!--- FIR-10136 --> Added new data type aliases<br>
  **(DB version 3.7.0)**

  Data type aliases have been added for `REAL`, `FLOAT4`, `FLOAT8`, `INT4`, `INT8`, and `FLOAT(p)`. For more information on data types and their aliases (synonyms), see [Data types](data-types.md).

* #### <!--- FIR-8896 --> Updated INFORMATION_SCHEMA.COLUMNS<br>
  **(DB version 3.8.0)** 

  Now includes more metadata on columns, as well as columns for views in a given database.

* #### <!--- FIR-8437 --> New script processing status in browser tab

  Added a status indicator in the browser tab so when multiple tabs are open in the browser, you can switch to a different tab and still track the status of your running script. The status adds a color coded indicator dot to the Firebolt icon in the tab. A green dot indicates the script completed successfully. The status remains in the tab for one minute after the script completes running. 
  
  For more information about this new status indicator, and running scripts, see [Running scripts and working with results](../using-the-sql-workspace/using-the-sql-workspace.md#running-scripts-and-working-with-results).

  ![](../assets/images/release-notes/script-status.gif)

* #### <!--- FIR-7229 --> Added dark mode

  Firebolt now supports an additional color theme - dark mode. You can toggle between light and dark modes in the UI. Select the toggle at the bottom of the left navigation pane to turn dark mode on and off.   
 
  ![](../assets/images/release-notes/dark-mode-toggle.gif)

* #### <!--- FIR-10347 --> Added support for IP allowed & blocked lists<br> 
  **(Beta)**

  Allows access to your Firebolt account from specific IP addresses. For more information, see [Allowing and blocking source IP addresses for users (Beta)](../managing-your-account/managing-users.md#allowing-and-blocking-source-ip-addresses-for-users-beta)
  
* #### <!--- FIR-12819 --> Added support for server-side asynchronous querying on the Python SDK

  Allows the connection to be closed while the query is still running in Firebolt.
  
* #### <!--- FIR-12822 --> Released JDBC 2.0

  The Firebolt JBDC driver is now open-source under Apache 2. The new release also adds support for view tables in `getTables()`.
  

### Resolved issues

* <!--- FIR-11369 --> An error message is now displayed when too many partitions are added using a single `INSERT` statement.
