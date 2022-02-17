---
layout: default
title: JSON functions
description: Reference for SQL functions for working with JSON available in Firebolt.
nav_order: 1
parent: Semi-structured data functions
grand_parent: SQL functions reference
---

# JSON functions
{: .no_toc}

This page describes the functions used for JSON manipulation using ​Firebolt​. You can use JSON functions to extract values and objects from a JSON document.

* Topic ToC
{:toc}

## Function reference conventions

This reference uses the following conventions to represent function syntax.

### JSON pointer parameters

This reference uses the placeholder `json_pointer_expression` to indicate where you should use a JSON pointer. A JSON pointer is a way to access specific elements in a JSON document. For a formal specification, see [RFC6901](https://tools.ietf.org/html/rfc6901).

A JSON pointer starts with a forward slash (`/`), which denotes the root of the JSON document. This is followed by a sequence of property (key) names or zero-based ordinal numbers separated by slashes. You can specify property names or use ordinal numbers to specify the _n_th property or the _n_th element of an array.

The tilde (`~`) and forward slash (`/`) characters have special meanings and need to be escaped according to the guidelines below:

* To specify a literal tilde (`~`), use `~0`
* To specify a literal slash (`/`), use `~1`

For example, consider the JSON document below.

```javascript
{
    "key": 123,
    "key~with~tilde": 2,
    "key/with/slash": 3,
    "value": {
      "dyid": 987,
      "keywords" : ["insanely","fast","analytics"]
    }
}
```

With this JSON document, the JSON pointer expressions below evaluate to the results shown.

| Pointer             | Result                                                                                                                                                                                                                                                                                                    | Notes                                                                                                                                |
| :------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------ |
| `/`                 | `{` <br>`   "key": 123,` <br>`   "key~with~tilde": 2,` <br>`   "key/with/slash": 3,` <br>`   "value": {` <br>`      "dyid": 987,` <br>`      "keywords" : ["insanely","fast","analytics"]` <br>`   }` | The whole document                                                                                                                   |
| `/key`              | 123                                                                                                                                                                                                                                                                                                       |                                                                                                                                      |
| `/key~with~tilde`   | 2                                                                                                                                                                                                                                                                                                         | Indicates the value associated with the `key~with~tilde` property name.                                                              |
| `/key/with/slash`   | 3                                                                                                                                                                                                                                                                                                         | Indicates the value associated with the `key/with/slash` property name.                                                              |
| `/0`                | 123                                                                                                                                                                                                                                                                                                       | Uses an ordinal to indicate the value associated with the `key` property name. The `key` property is in the first 0-based position.  |
| `/value/keywords/2` | analytics                                                                                                                                                                                                                                                                                                 | Indicates the element "analytics", which is in the third 0-based position of the array value associated with they keywords property. |

### Supported type parameters

Some functions accept a *type parameter* shown as `expected_type`. This parameter is given as a literal string corresponding to supported Firebolt SQL data types to specify the expected type indicated by the JSON pointer parameter. The type parameter does not accept all SQL types because the JSON type system has fewer types than SQL.

The following values are supported for this argument:

* `INT` - used for integers as well as JSON boolean.
* `DOUBLE` - used for real numbers. It will also work with integers. For performance reasons, favor using `INT` when the values in the JSON document are known integers.
* `TEXT` - used for strings.
* `ARRAY(<type>)` - indicates an array where `<type>` is one of `INT`, `DOUBLE`, or `TEXT`.

The following data types are _not supported_: `DATE`, `DATETIME`, `FLOAT` (for real numbers, use `DOUBLE`).

### JSON common example

Usage examples in this reference are based on the JSON document below, which is referenced using the `<json_common_example>` placeholder.

```javascript
{
    "key": 123,
    "value": {
      "dyid": 987,
      "uid": "987654",
      "keywords" : ["insanely","fast","analytics"],
      "tagIdToHits": {
        "map": {
          "1737729": 32,
          "1775582": 35
        }
      },
      "events":[
        {
            "EventId": 547,
            "EventProperties" :
            {
                "UserName":"John Doe",
                "Successful": true
            }
        },
        {
            "EventId": 548,
            "EventProperties" :
            {
                "ProductID":"xy123",
                "items": 2
            }
        }
    ]
    }
}
```

## JSON_EXTRACT

Takes an expression containing JSON string, a JSON Pointer, and a type parameter. It returns a typed scalar, or an array pointed by the JSON Pointer.

If the key pointed by the JSON pointer is not found, or the type of the value under that key is different from the one specified, the function returns `NULL`

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

## JSON_EXTRACT_ARRAY_RAW

Returns a string representation of a JSON array pointed by the supplied JSON pointer. The returned string represents a Firebolt array with elements that are string representations of the scalars or objects contained in the JSON array under the specified key, if the key exists. If the key does not exist, the function returns `NULL`.

This function is useful when working with heterogeneously typed arrays and arrays containing JSON objects in which case each object will be further processed by functions such as [TRANSFORM](/array-functions.md#transform).

##### Syntax
{: .no_toc}

```sql
​​JSON_EXTRACT_ARRAY_RAW(<json>, '<json_pointer_expression>')
```

| Parameter                   | Type           | Description                                               |
| :--------------------------- | :-------------- | :--------------------------------------------------------- |
| `<json>`                    | TEXT           | The JSON document from which the array is to be extracted |
| `<json_pointer_expression>` | Literal string | A JSON pointer to the location of the array in the JSON   |

##### Example
{: .no_toc}

```sql
SELECT
    JSON_EXTRACT_ARRAY_RAW(<json_common_example>, '/value/events')
```

**Returns**: `["{\"EventId\":547,\"EventProperties\":{\"UserName\":\"John Doe\",\"Successful\":true}}","{\"EventId\":548,\"EventProperties\":{\"ProductID\":\"xy123\",\"items\":2}}"]`

## JSON_EXTRACT_KEYS

Returns an array of strings containing the keys at the nesting level indicated by the specified `<json_pointer_expression>`. If keys do not exist, returns `NULL`.

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

## JSON_EXTRACT_RAW

Returns a string representation of the scalar or sub-object under the key indicated by `<json_pointer_expression>` if the key exists. If the key does not exist, returns `NULL`.

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

```sql
SELECT
    JSON_EXTRACT_RAW(<json_common_example>,'/value/dyid')
```

**Returns**: `987`

```sql
JSON_EXTRACT_RAW(<json_common_example>, '/value/tagIdToHits')
```

**Returns**: `{"map":{"1737729":32,"1775582":35}}`

## JSON_EXTRACT_VALUES

Returns an array of string representations, each element containing the value pointed by the JSON Pointer.

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
