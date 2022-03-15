---
layout: default
title: Working with semi-structured data
description: Learn how to handle semi-structured data in Firebolt.
nav_order: 10
has_children: true
---
# Working with semi-structured data

Semi-structured data is any data that does not adhere to a strict tabular schema, or data where some field types are not of the standard SQL data types. Semi-structured data usually has a nested structure and supports complex data types like arrays, maps, and structs (compound types).

JSON is the a common example of a semi-structured data type, but many other serialization formats such as Parquet and ORC support similar features.

Arrays are the building blocks of how Firebolt transforms semi-structured data so that it can be queried efficiently. Arrays in Firebolt are implemented for the following source data constructs.

* Arrays in the source data that have a length that is variable so that it can't be known when you create the table. These arrays can have arbitrary nesting levels, but the nesting level should be the same for a given column and known when you create the table.
* Maps (also known as dictionaries) in the source data, which use two coordinated arrays: one for keys, and one for values. This is especially useful for JSON-like, semi-structured data sources in which each object can have different keys, so a fixed schema cannot handle the data properly.

In some cases, when the JSON adheres to a fixed schema&mdash;that is, each object has a known set of keys, and a nesting level of at most two, not including the nesting level of arrays, which can be arbitrary&mdash;the data can be ingested directly.

This section introduces the correspondence between semi-structured constructs to Firebolt arrays.
