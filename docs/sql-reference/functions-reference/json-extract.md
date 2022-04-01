---
layout: default
title: JSON_EXTRACT
description: Reference material for JSON_EXTRACT function
parent: SQL functions
---

## JSON_EXTRACT

Takes an expression containing JSON string, a JSON Pointer, and a type parameter. It returns a typed scalar, or an array pointed by the JSON Pointer.

If the key pointed by the JSON pointer is not found, or the type of the value under that key is different from the one specified, the function returns `NULL`

For more information on manipulating JSON data sets, please refer to [JSON function reference conventions](./index.md#json-function-reference-conventions).

##### Syntax
{: .no_toc}

```sql
​​JSON_EXTRACT(<json>, '<json_pointer_expression>', '<expected_type>')
```

| Parameter                   | Type           | Description                                                                                       |
| :--------------------------- | :-------------- | :------------------------------------------------------------------------------------------------- |
| `<json>`                    | TEXT           | The JSON document from which the value is to be extracted.                                        |
| `<json_pointer_expression>` | Literal string | A JSON pointer to the location of the value in the JSON document.                                 |
| `<expected_type>`           | Literal String | A literal string name of the expected [return type](json-functions.md#supported-type-parameters). |

**Return Value**

If the key pointed by the JSON path exists and its type conforms with the `expected_type` parameter, then `JSON_EXTRACT` returns the value under that key.

Otherwise, it returns `NULL`

##### Example
{: .no_toc}

The examples below use our [JSON Common Example](./index.md#json-common-example)

```sql
SELECT
    JSON_EXTRACT(< json_common_example >, '/value/dyid', 'INT')
```

**Returns**: `987`

```sql
SELECT
    JSON_EXTRACT(<json_common_example>, '/value/no_such_key', 'TEXT')
```

**Returns**: `NULL`

```sql
SELECT
    JSON_EXTRACT(<json_common_example>, '/value/uid', 'INT')
```

**Returns**: `NULL` since the JSON type under that key is a string.

```sql
SELECT
    JSON_EXTRACT(<json_common_example>,'/value/keywords', 'ARRAY(TEXT)')
```

**Returns**: `["insanely","fast","analytics"]`
