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

## October 2022

* [New features](#new-features)
* [Enhancements, changes, and new integrations](#enhancements-changes-and-new-integrations)

### New features

* #### <!--- FIR-15853 —-->Added support for functions REGEXP\_REPLACE and REGEXP\_REPLACE\_ALL
**(DB version 3.11.0)**

  Use these functions to replace matching patterns in the input with a replacement. The [REGEXP\_REPLACE](../sql-reference/functions-reference/regexp-replace.md) function replaces the first match only (from the left), [REGEXP\_REPLACE\_ALL](../sql-reference/functions-reference/regexp-replace.md) function replaces all the matches.

### Enhancements, changes, and new integrations

* #### <!--- FIR-12587 —-->Added support for DECIMAL data type
 **(DB version 3.11.7)**

  Beta support for the [DECIMAL](decimal-data-type.md) data type is coming in version 3.11.7.

  {: .warning}
  In previous versions, DECIMAL type columns are stored as DOUBLE type. Therefore, this change may require your action. 
  
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


* #### <!--- FIR-14886 —-->Added support for “OR” operator for JOIN 
**(DB version 3.11.0)**

  Allows performing JOINs with multiple join conditions linked via the “OR” operator

* #### <!--- FIR-15683 —-->Updated syntax to generate an aggregating index 
**(DB version 3.11.0)**

  The [CREATE AGGREGATING INDEX](../sql-reference/commands/create-aggregating-index.md) command will now generate the aggregating index, without using the additional AND GENERATE clause. 

* #### <!--- FIR-15452 —-->Added support for window function frame definitions
**(DB version 3.11.0)**

  Adds support for UNBOUNDED PRECEDING, n PRECEDING, CURRENT ROW, n FOLLOWING, and UNBOUNDED FOLLOWING [frame definitions](../sql-reference/functions-reference/#window-functions) for the frame start and end in window functions, and frame specification modes (ROWS, RANGE), as well as resolving some of the out-of-memory cases present in the previous implementation.

* #### <!--- FIR-15022 —-->VERSION() function now available
**(DB version 3.8.0)**

  Query the engine version using the new [VERSION()](../sql-reference/functions-reference/version.md) function. Engine version is also now available as a column in the [information\_schema.engines](../general-reference/information-schema/engines.md) view. 

* #### <!--- FIR-15152 —--> Information schema updated
**(DB version 3.8.0)**

  System-defined tables metadata can now be queried via the [information\_schema.tables](../general-reference/information-schema/tables.md) view.



