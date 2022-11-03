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

## November 2022

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

* #### <!--- FIR-15968, FIR-15744 —-->Added support for functions
**(DB version 3.13.0)**

  * [FIRST_VALUE](../sql-reference/functions-reference/first-value.md): Returns the first value evaluated in the specified window frame.
  * [NTH_VALUE](../sql-reference/functions-reference/nth-value.md): Returns the value evaluated of the nth row of the specified window frame (starting at the first row).
  * [NTILE](../sql-reference/functions-reference/ntile.md): Divides an ordered data set equally into a specified number of buckets.
  * [CUME\_DIST](../sql-reference/functions-reference/cume-dist.md): Calculates the relative rank (cumulative distribution) of the current row in relation to other rows in the same partition within an ordered data set.
  * [PERCENT\_RANK](../sql-reference/functions-reference/percent-rank.md): Calculates the relative rank of the current row within an ordered data set.
  * [PERCENTILE\_CONT (aggregation function)](../sql-reference/functions-reference/percentile-cont.md): Calculates a percentile, assuming a continuous distribution of values.
  * [PERCENTILE\_CONT (window function)](../sql-reference/functions-reference/percentile-cont-window.md): Calculates a percentile over a partition, assuming a continuous distribution of values.
  * [PERCENTILE\_DISC (aggregation function)](../sql-reference/functions-reference/percentile-disc.md): Returns a percentile for an ordered data set, equal to a specific column value.
  * [PERCENTILE\_DISC (window function)](../sql-reference/functions-reference/percentile-disc-window.md): Returns a percentile over a partition for an ordered data set, equal to a specific column value.

* #### <!--- FIR-15007 —-->Added support for TRUNCATE TABLE command
**(DB version 3.11.0)**
  
  Use the [TRUNCATE TABLE](../sql-reference/commands/truncate-table.md) command to remove all rows from a table. 

* #### <!--- FIR-12587 —-->Added support for DECIMAL data type
 **(DB version 3.13.0)**

  Beta support for the [DECIMAL](decimal-data-type.md) data type is coming in version 3.13. 

  {: .warning}
  In previous versions, DECIMAL type columns are stored as DOUBLE type. Therefore, this change may require your action. Restart analytics engines before general purpose engines to use this new feature, and see below for additional actions. 
  
  **If your existing data model contains tables defined with DOUBLE type columns:**
  * If you want to preserve the DOUBLE data type going forward, no change is required. The DECIMAL data type can be used for new tables/columns.
   
  **If your existing data model contains tables defined with DECIMAL type columns:**
   * If you do not want to change your tables, no action is required. These columns will just show up as type DOUBLE. You can safely use the DECIMAL type for new tables/columns.

   * If your table defined with columns as DECIMAL are recreated periodically (by your ELT process), new columns will be defined as DECIMAL(38,0) – default precision and scale. If you don’t want to switch to the DECIMAL data type for the existing data flows, you can change your ELT flows and replace the DECIMAL keyword with DOUBLE.

   * If you are using a function with a DECIMAL type in your ELT process, ensure that function is [supported for the DECIMAL data type](decimal-data-type.md#supported-functions-beta-release).  

   * To change the data type of columns defined as DECIMAL but stored as DOUBLE, you will need to recreate the table with the new definition (column defined as DECIMAL(p,s)). To avoid precision loss, we highly recommend re-ingesting the data from the source (i.e., via external table) rather than casting values to decimal from the existing table (i.e., `INSERT INTO new_table(d) SELECT CAST(d as DECIMAL(38,9)) FROM old_table;`).
   
   * To avoid any downtime for the end-users in scenarios involving re-creating and re-ingesting the table, we suggest creating a view that reads from the existing table (`old_table`). After the new table (`new_table`) is created and data is ingested, repoint the view to the new table name (`new_table`) using the `CREATE OR REPLACE VIEW` command. 
 
  **Examples of changes in behavior**
 
  * Comparing two values that differ by a small offset yields different results when stored as DECIMAL vs. DOUBLE, because DOUBLE is a variable-precision data type, whereas DECIMAL is exact with fixed precision:
  ```sql
      SELECT '1.00000000000000000000000005'::DECIMAL(38,30) = '1.00000000000000000000000004999'::DECIMAL(38,30); -- false
      SELECT '1.00000000000000000000000005'::DOUBLE = '1.00000000000000000000000004999'::DOUBLE;  --true
  ```

  * Expressions involving DECIMAL data types with different precision and scale will yield an error:
  ```sql
    SELECT 3::DECIMAL + 2::DECIMAL(3,1); -- Invalid operation error: Operations between decimals with different precision and scale is not supported at the moment. Explicitly cast one of the decimals to other decimal precision and scale.
  ```

  * Functions `ROUND`, `TO_STRING`, and `TO_TEXT` applied on DECIMAL will return the data type matching the input data type. 

 ### Enhancements, changes, and new integrations

* #### <!--- FIR-16295 —-->**Information schema updated**
**(DB version 3.13.0)**

  Added `cpu_usage_us` and `cpu_delay_us` columns to the [information_schema.query_history view](../general-reference/information-schema/query-history-view.md) view.
