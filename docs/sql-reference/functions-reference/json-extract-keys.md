---
layout: default
title: JSON_EXTRACT_KEYS
description: Reference material for JSON_EXTRACT_KEYS function
parent: SQL functions
---

## JSON_EXTRACT_KEYS

Returns an array of strings containing the keys at the nesting level indicated by the specified `<json_pointer_expression>`. If keys do not exist, returns `NULL`.

For more information on manipulating JSON data sets, please refer to [JSON functions](./json-functions.md).

The example below uses our [JSON Common Example](./json-functions.md#json-common-example)

##### Syntax
{: .no_toc}

```sql
JSON_EXTRACT_KEYS(<json>, '<json_pointer_expression>')
```

| Parameter                   | Type           | Description                                                     |
| :--------------------------- | :-------------- | :--------------------------------------------------------------- |
| `<json>`                    | TEXT           | The JSON document used for key extraction                       |
| `<json_pointer_expression>` | Literal string | A JSON pointer to a location where the keys are to be extracted |

##### Example
{: .no_toc}

```sql
SELECT
	JSON_EXTRACT_KEYS(< json_common_example >, 'value')
FROM
	RAW_JSON
```

**Returns**: `["dyid","uid","keywords","tagIdToHits","events"]`
