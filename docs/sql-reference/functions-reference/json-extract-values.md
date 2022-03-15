---
layout: default
title: JSON_EXTRACT_VALUES
description: Reference material for JSON_EXTRACT_VALUES function
parent: SQL functions
---

## JSON_EXTRACT_VALUES

Returns an array of string representations, each element containing the value pointed by the JSON Pointer.

For more information on manipulating JSON data sets, please refer to [JSON functions](./json-functions.md).

The example below uses our [JSON Common Example](./json-functions.md#json-common-example)

##### Syntax
{: .no_toc}

```sql
​​JSON_EXTRACT_VALUES(<json>, '<json_pointer_expression>')
```

| Parameter                   | Type           | Description                                                     |
| :--------------------------- | :-------------- | :--------------------------------------------------------------- |
| `<json>`                    | TEXT           | The JSON document from which the values are to be extracted     |
| `<json_pointer_expression>` | Literal string | A JSON pointer to the location where values are to be extracted |

**Return value**

A Firebolt array of string values based on the location specified by the `<json_pointer_expression>.` If no such key exists, it returns `NULL.`

##### Example
{: .no_toc}

```sql
SELECT
    JSON_EXTRACT_VALUES(<json_common_example>, 'value')
FROM
    RAW_JSON
```

**Returns**: `["987","\"987654\"","[\"insanely\",\"fast\",\"analytics\"]","{\"map\":{\"1737729\":32,\"1775582\":35}}","[{\"EventId\":547,\"EventProperties\":{\"UserName\":\"John Doe\",\"Successful\":true}},{\"EventId\":548,\"EventProperties\":{\"ProductID\":\"xy123\",\"items\":2}}]"]`
