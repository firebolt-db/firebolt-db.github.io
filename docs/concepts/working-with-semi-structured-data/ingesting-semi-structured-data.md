---
layout: default
title: Ingesting semi-structured data
nav_order: 1
parent: Working with semi-structured data
grand_parent: Concepts
---
# Ingesting semi-structured data

There are three major approaches to ingest and handle semi-structured data:

1. Transforming the input using JSON and `ARRAY` functions to fit the target schema during ingestion.
2. Ingesting the JSON object as raw `TEXT` rows, and later using JSON and `ARRAY` functions to query and manipulate them
3. When the input JSON adheres to a fixed schema, that is, each object has a known set of keys, and the nesting level of at most 2 \(not including nesting of arrays which as stated - can be arbitrary\) the data can be ingested directly. Omitted keys can be handled by specifying default values for the respective columns, but keys that are defined at table creation time will be ignored.

All options can be combined depending on the use case: the nature of the input data and the queries to be performed. The 3rd approach is not very common with true semi-structured data sources, but usually is the result of an export from table-oriented storage, and therefore will be discussed in a separate section.

We will continue with our source JSON example. Assume that each JSON record is stored as plain text in the column `raw_json` of a \(potentially external\) table named `source_json`

As a reminder here are the JSON records:

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

Recall that the target table named "Visits" should look as follows:

| id INT | StartTime DATETIME | Duration INT | tags ARRAY\(TEXT\) | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |

## Extracting top-level scalars and arrays

For the top-level keys: "id", "Duration", and "tags" the task is straightforward using [JSON\_EXTRACT](../../sql-reference/functions-reference/semi-structured-functions/json-functions.md#json_extract) function. This function accepts three parameters:


Although "StartTime" is also a scalar field, since there is no native DATETIME type in JSON type system it will require an additional step


1. An expression containing a JSON string
2. A [JSON Pointer](ingesting-semi-structured-data.md) specifying the location in the JSON object from where the value will be extracted,
3. A type specifier indicating Firebolt's SQL type that will be returned from the function. This type should correspond to the JSON type found under the key pointed by the JSON Pointer. For a detailed discussion of JSON to SQL type mapping see the [Type Parameters](../../sql-reference/functions-reference/semi-structured-functions/json-functions.md#type-parameters) section in the [JSON Functions](../../sql-reference/functions-reference/semi-structured-functions/json-functions.md) reference.

Note that our native support for arrays makes the extraction of `tags` as simple as other scalar types. Putting those concepts in action will result in the following query that will return the expected tabular representation:

```sql
SELECT
JSON_EXTRACT(raw_json, '/id','INT') as id,
JSON_EXTRACT(raw_json, '/Duration','INT') as duration,
JSON_EXTRACT(raw_json, '/tags','ARRAY(TEXT)') as tags
FROM source_json
```

Result:

| id | duration | tags |
| :--- | :--- | :--- |
| 1 | 450 | \["summer-sale","sports"\] |
| 2 | 959 | \["gadgets","audio"\] |

Since we want to store "StartTime" as a `DATETIME` SQL typed column, which will allow many optimizations, correct ordering, and other benefits, and since JSON type system lacks such type we will have to cast the result of `JSON_EXTRACT` of this field:

```sql
SELECT
-- ... other fields
CAST(JSON_EXTRACT(raw_json, '/StartTime','TEXT') AS DATETIME)
FROM source_json
```

## Extracting sub-object keys and values

Now we have to perform a non-trivial transformation to the input data. We need to take the JSON keys of the sub-object `user_agent` , and their corresponding values and reshape them as two coordinated arrays.

The functions [`JSON_EXTRACT_KEYS`](../../sql-reference/functions-reference/semi-structured-functions/json-functions.md#json_extract_keys) and [`JSON_EXTRACT_VALUES`](../../sql-reference/functions-reference/semi-structured-functions/json-functions.md#json_extract_values)do exactly this.

The first will return the keys under the sub-objects pointed by the JSON pointer provided as the first parameter, and the second will return the values of this sub-object _**as strings**_. That means that if under a certain key there is an arbitrarily nested sub-object - the whole object will be returned as a single `TEXT` element in the resulting array.

### Putting it all together

The following statement takes the raw JSON input and transforms it into our target schema. The result is provided as an illustration, since an `INSERT INTO ...` return only the number of affected rows.

```sql
INSERT INTO Visits
SELECT
JSON_EXTRACT(raw_json, '/id','INT') as id,
CAST(JSON_EXTRACT(raw_json, '/StartTime','TEXT') AS DATETIME) as StartTime,
JSON_EXTRACT(raw_json, '/Duration','INT') as duration,
JSON_EXTRACT(raw_json, '/tags','ARRAY(TEXT)') as tags,
JSON_EXTRACT_KEYS(raw_json,'/user_agent') as agent_props_keys,
JSON_EXTRACT_VALUES(raw_json,'/user_agent') as agent_props_vals
FROM doc_visits_source
```

Result \(if the script whould have been excecuted without the `INSERT INTO` clause\):

| id | StartTime | duration | tags | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |
