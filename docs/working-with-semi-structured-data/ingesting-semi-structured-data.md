---
layout: default
title: Ingesting semi-structured data
description: Learn how to ingest (load) semi-structured data from your data lake into the Firebolt data warehouse.
nav_order: 2
parent: Working with semi-structured data
---
# Ingesting semi-structured data

There are three major approaches to ingest and handle semi-structured data as shown below. All approaches can be combined depending on the nature of the input data and the queries to run over the data.

1. Transforming the input using JSON and `ARRAY` functions to fit the target schema during ingestion.  

2. Ingesting the JSON object as raw `TEXT` rows, and later using JSON and `ARRAY` functions to query and manipulate them.  

3. When the input JSON adheres to a fixed schema&mdash;that is, each object has a known set of keys, and the nesting level of at most two (not including nesting of arrays, which can be arbitrary)&mdash;the data can be ingested directly. Omitted keys can be handled by specifying default values for the respective columns, but keys that are defined at table creation time are ignored. This approach is not common with true, semi-structured sources. This approach usually applies to exports from table-oriented storage.

Assume that each JSON record is stored as plain text in the column `raw_json` of a \(potentially external\) table named `source_json` in the format shown below.

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

Recall that we want the target Firebolt table named `visits` to have columns and values similar to the table shown below.

| id (INTEGER) | start_time (DATETIME) | duration (INTEGER) | tags (ARRAY(TEXT)) | agent_props_keys | agent_props_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |

## Extracting top-level scalars and arrays

For the top-level keys (`id`, `Duration`, and `tags`), the task is straightforward using the [JSON_EXTRACT](../sql-reference/functions-reference/json-extract.md) function. Although "StartTime" is also a scalar field, because there is no native DATETIME type in JSON type system, it requires an additional step.

`JSON_EXTRACT` accepts the following parameters:

* An expression that resolves to a JSON document.
* A [JSON pointer expression](../sql-reference/functions-reference/index.md#json-pointer-expression-syntax) that specifies how to extract the value from the JSON object.
* A type specifier that indicates the Firebolt data type that the function returns. This type should correspond to the JSON type that the pointer references. For more information, see [Supported type parameters](../sql-reference/functions-reference/index.md#supported-type-parameters).

Firebolt's native support for arrays makes the extraction of `tags` as simple as other scalar types.

The query example shown below combines these element to return the desired tabular representation shown above for `id`, `Duration`, and `tags`.

```sql
SELECT
  JSON_EXTRACT(raw_json, '/id','INTEGER') as id,
  JSON_EXTRACT(raw_json, '/Duration','INTEGER') as duration,
  JSON_EXTRACT(raw_json, '/tags','ARRAY(TEXT)') as tags
FROM
  source_json;
```

**Returns**:

| id | duration | tags |
| :--- | :--- | :--- |
| 1 | 450 | \["summer-sale","sports"\] |
| 2 | 959 | \["gadgets","audio"\] |

We want to store `StartTime` as a `DATETIME` data type. This enables optimizations, correct ordering, and other benefits. Because the JSON type system lacks a type, we cast the result of `JSON_EXTRACT` for this JSON field to the `DATETIME` data type.

```sql
SELECT
-- ... other fields
  CAST(JSON_EXTRACT(raw_json, '/StartTime','TEXT') AS DATETIME)
FROM
  source_json
```

## Extracting sub-object keys and values

We need to take the JSON keys of the sub-object `user_agent`, along with their corresponding values, and reshape them as two coordinated arrays.

We can use the functions [JSON_EXTRACT_KEYS](../sql-reference/functions-reference/json-extract-keys.md) and [JSON_EXTRACT_VALUES](../sql-reference/functions-reference/json-extract-values.md) to achieve this.

`JSON_EXTRACT_KEYS` returns the keys under the sub-object indicated by the JSON pointer. `JSON_EXTRACT_VALUES` returns the values of this sub-object *as strings*. That means that if a key contains an arbitrarily nested sub-object, the whole object is returned as a single `TEXT` element in the resulting array.

### Putting it all together

The following statement takes the raw JSON input and uses `INSERT INTO` to load the results into the table `visits`. The result is provided as an illustration, since an `INSERT INTO ...` returns only the number of affected rows.

```sql
INSERT INTO
  visits
SELECT
  JSON_EXTRACT(raw_json, '/id','INTEGER') as id,
  CAST(JSON_EXTRACT(raw_json, '/StartTime','TEXT') AS DATETIME) as StartTime,
  JSON_EXTRACT(raw_json, '/Duration','INTEGER') as duration,
  JSON_EXTRACT(raw_json, '/tags','ARRAY(TEXT)') as tags,
  JSON_EXTRACT_KEYS(raw_json,'/user_agent') as agent_props_keys,
  JSON_EXTRACT_VALUES(raw_json,'/user_agent') as agent_props_vals
FROM
  doc_visits_source
```

Result \(if the script whould have been excecuted without the `INSERT INTO` clause\):

| id | StartTime | duration | tags | agent\_props\_keys | agent\_props\_vals |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 2020-01-06 17:00:00 | 450 | \["summer-sale","sports"\] | \["agent", "platform", "resolution"\] | \["Mozilla/5.0", "Windows NT 6.1", "1024x4069"\] |
| 2 | 2020-01-05 12:00:00 | 959 | \["gadgets","audio"\] | \["agent", "platform"\] | \["Safari", "iOS 14"\] |
