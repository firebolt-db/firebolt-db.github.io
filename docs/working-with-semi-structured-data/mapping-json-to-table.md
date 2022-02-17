---
layout: default
title: Mapping data from JSON to table
description: Learn how to map data from a JSON document to rows and columns in a Firebolt table.
nav_order: 1
parent: Working with semi-structured data
---

# Mapping data from JSON records to rows in a Firebolt table

Throughout this section, we use a common example set of JSON records that can result from a website's logs or web-analytics platform, and the Firebolt table into which that JSON record is ingested. We start with a simple example that becomes more involved and realistic as we present new concepts.

Each record in the source data represents a "visit" or "session" on the website. Records are stored in an "Object per line" file. Each line is a JSON object, although the file as a whole is not a valid JSON. These files are usually stored in a data lake in compressed form.

## Source JSON record structure
Assume we have the following two records in the source data lake file.

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

Important characteristics of the JSON records:

* Each record has mandatory scalar fields `id`, `StartTime`, and `Duration`.
* There is an array of `tags` of arbitrary length, potentially empty.
* There is a *map* of `user_agent` properties. These properties can change from record to record, and the full set of potential properties is not known when you create the Firebolt table.

## Corresponding Firebolt table structure
The JSON records above are represented in a Firebolt table that is created with the DDL example below. A fact table example is shown (a dimension table would be acceptable as well) and the `PRIMARY INDEX` definition is arbitrary.

```sql
CREATE [FACT|DIMENSION] TABLE visits
(
    id INT,
    start_time DATETIME,
    tags ARRAY(TEXT),
    agent_props_keys ARRAY(TEXT),
    agent_props_vals ARRAY(TEXT)
)
PRIMARY INDEX start_time;
```
With the JSON records above ingested into the table, table data appears as shown below.  For more information about using Firebolt semi-structured functions to transform JSON records into table rows, see [Ingesting semi-structured data](ingesting-semi-structured-data.md).

{: .note}
The data type is shown in capital letters beside the column name for clarity and is not part of the column name.

| id INT | start_time DATETIME | duration INT | tags ARRAY\(TEXT\) | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |

Important characteristics of the table:

* The mandatory scalar fields correspond to regular columns.
* For the `tags` array, we define a column with the data type `ARRAY(TEXT)`.
* For the `user_agent` properties map, we define *two* columns: one for the keys and one for the values. This is a common pattern used in Firebolt to represent maps (also known as *dictionaries*).
