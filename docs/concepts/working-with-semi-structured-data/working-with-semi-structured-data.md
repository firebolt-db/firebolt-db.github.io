---
layout: default
title: Working with semi-structured data
nav_order: 3
parent: Concepts
has_children: true
---
# Working with semi-structured data

Semi-structured data is any data that does not adhere to a strict tabular schema and/or some of its field types is not of standard SQL type. Such data usually has a nested structure and supports complex data types like arrays, maps, and structs \(compound types\).

The prototypical example of such a data format is JSON, but many other serialization formats such as Avro, Parquet, and ORC support similar features.

For reference see [semi-structured data functions](../../sql-reference/functions-reference/semi-structured-functions/)

Arrays are the building blocks of how Firebolt represent semi-structured data, among others, they are used to represent:

* Arrays of varying lengths in the input, unknown at the creation of the table. These arrays can have arbitrary nesting levels, however, the nesting level should be the same for a given column and known at the creation time of the table.  
* Maps - using two coordinated arrays - one for keys, the other for values. This is especially useful for JSON like semi-structured data sources in which each object can have different keys - so a fixed schema cannot handle such data properly

In some cases, when the JSON adheres to a fixed schema, that is, each object has a known set of keys, and nesting level of at most 2 \(not including nesting of arrays which as stated - can be arbitrary\) the data can be ingested directly.

This page will introduce the correspondence between semi-structured constructs to firebolt arrays. The subsection will elaborate on the following topics:

* [Working with arrays](working-with-arrays.md)
* [Ingesting semi-structured data](ingesting-semi-structured-data.md)

## Representing semi-structured data in Firebolt

### Source Data

Throughout this page and its subsections, we will use a set of JSON records that can result from a website's logs/web-analytics platform. We will start with a simple example that will become more involved and realistic as we present new concepts.

Each record in the source data represents a "visit" or "session" on the website. The records will usually be stored in an "Object per line" file, that is, each line is a JSON object, although the file as a whole is not a valid JSON. This test file will usually be stored in the Data Lake in a compressed form. More about it in the [ingestion section](ingesting-semi-structured-data.md).

Assume we have the following two records:

```javascript
// 1st record
{
    "id": 1,
    "StartTime": "2020-01-06 17:00:00",
    "Duration": 450,
    "tags": ["summer-sale","sports"],
    "user_agent":{
        "agent": "Mozilla/5.0",
        "platform": "Windows NT 6.1",
        "resolution": "1024x4069"
    }
}

// 2nd record
{
    "id": 2,
    "StartTime": "2020-01-05 12:00:00",
    "Duration": 959,
    "tags": ["gadgets","audio"],
    "user_agent":{
        "agent": "Safari",
        "platform": "iOS 14"
    }
}
```

Here are some important points to pay attention to:

* For each record, there are mandatory scalar fields: "id", "StartTime", and "Duration".
* There is an array of arbitrary length \(potentially empty\) of "tags".
* There is a "map" of user agent properties. Those properties can change from record to record and the full set of potential properties is not known at the creation of the table.

### Representation as a Firebolt table

Let's see how we represent the above semi-structured "schema" in a Firebolt table.

* For the mandatory scalar fields, we will have regular columns.
* For the "tags" array we will define a column whose type will be `ARRAY(TEXT)`.
* For the user agent properties map, we will define _two_ columns: one for the keys and one for the values - this is a pattern used to represent maps \(or dictionaries\) in Firebolt. We will encounter it in many examples.

Combining the above will result in the following table - note that the headings specify the column name and type

| id INT | StartTime DATETIME | Duration INT | tags ARRAY\(TEXT\) | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |

The DDL statement creating the above table will be:

```sql
CREATE [FACT|DIMENSION] TABLE visits
(
    id INT,
    StartTime DATETIME,
    tags ARRAY(TEXT),
    agent_props_keys ARRAY(TEXT),
    agent_props_vals ARRAY(TEXT)
)
PRIMARY INDEX ...
```

In the next sections, we will see how to query and manipulate the resultant table \([working with arrays](working-with-arrays.md)\) and how to ingest and transform the semi-structured data into a Firebolt table \([ingesting semi-structured data](ingesting-semi-structured-data.md)\).
