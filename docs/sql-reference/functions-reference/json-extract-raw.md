---
layout: default
title: JSON_EXTRACT_RAW
description: Reference material for JSON_EXTRACT_RAW function
parent: SQL functions
---

## JSON_EXTRACT_RAW

Returns a string representation of the scalar or sub-object under the key indicated by `<json_pointer_expression>` if the key exists. If the key does not exist, returns `NULL`.

For more information on manipulating JSON data sets, please refer to [JSON function reference conventions](./index.md#json-function-reference-conventions).

##### Syntax
{: .no_toc}

```sql
​​JSON_EXTRACT_RAW(<json>, <json_pointer_expression>)
```

| Parameter                   | Type           | Description                                                       |
| :--------------------------- | :-------------- | :----------------------------------------------------------------- |
| `<json>`                    | TEXT           | The JSON document from which the value is to be extracted         |
| `<json_pointer_expression>` | Literal string | A JSON pointer to the location of the scalar or value in the JSON |

##### Example
{: .no_toc}

The examples below use our [JSON Common Example](./index.md#json-common-example)

```sql
SELECT
    JSON_EXTRACT_RAW(<json_common_example>,'/value/dyid')
```

**Returns**: `987`

```sql
JSON_EXTRACT_RAW(<json_common_example>, '/value/tagIdToHits')
```

**Returns**: `{"map":{"1737729":32,"1775582":35}}`
