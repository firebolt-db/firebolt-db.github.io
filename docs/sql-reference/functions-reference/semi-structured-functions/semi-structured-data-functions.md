---
layout: default
title: Semi-structured data functions
description: Reference for SQL functions available in Firebolt for working with semi-structured data.
nav_order: 5
parent: SQL functions reference
has_children: true
no_toc: true
---

# Semi-structured data functions

Firebolt supports loading and manipulating semi-structured data such as JSON. This, and similar formats \(e.g. Avro, Parquet\) can contain compound types such as arrays, maps, and structs. Firebolt uses its native `ARRAY` type to model and query such semi-structured data.

The raw JSON input can be transformed into Firebolt's arrays during ingestion, or stored as a plain `TEXT` column. In both cases,[ JSON functions](json-functions.md) will be used to transform the nested, compound JSON types to Firebolt arrays, while [array functions](array-functions.md), including Aggregate Array Functions, will be used to manipulate and query the semi-structured data.

* [Array functions](array-functions.md)&ndash;used for the manipulation and querying of array typed columns, such as [transformation](array-functions.md#transform), [filtering](array-functions.md#filter), and [un-nesting](array-functions.md#array_unnest-deprecated) (an operation that converts the array to a regular column).
* [Aggregate array functions](aggregate-array-functions.md)&ndash;these functions work on array-typed columns, but instead of being applied row by row, they combine the results or all the array belonging to the groups defined by the `GROUP BY` clause.
* [JSON functions](json-functions.md)&ndash;these function extract and transform raw JSON into Firebolt native types, or JSON sub-objects. They are used either during the ELT process or applied to columns storing JSON objects as plain `TEXT`.         
