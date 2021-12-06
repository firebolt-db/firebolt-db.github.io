# JSON Functions

This page describes the functions used for JSON manipulation supported in ​Firebolt​.

JSON functions are used to extract values or sub-object from a JSON string.

The functions accept a JSON Pointer argument which specifies the key whose value will be extracted. For an overview of JSON Pointer refer to [our documentation](json-pointer.md) and/or the [official standard](https://tools.ietf.org/html/rfc6901).

For the rest of this page we will assume that the variable `json` contains the following JSON document:

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

## Type parameters

Some of the functions described below accept a _type parameter_. This parameter is given as a literal string name of one of the supported Firebolt SQL types that correspond to the expected type to be found under the key pointed by the JSON pointer parameter.

{: .note}
The JSON type system has fewer types than SQL, therefore not all SQL types are supported by the type parameter.

### Supported Types

* `INT` - used for integers as well as JSON boolean
* `DOUBLE` - used for real numbers. It will also work with integers, for performance reasons prefer using INT when you know that the values in the JSON document are integers
* `TEXT`
* `ARRAY` of one of the above types

Types that are _not supported_: `DATE`, `DATETIME`, `FLOAT` - for real numbers always use `DOUBLE`.

## JSON\_EXTRACT

Takes an expression containing JSON string, a JSON Pointer, and a type parameter, and returns a typed scalar, or an array pointed by the JSON Pointer.

If the key pointed by the JSON pointer is not found, or the type of the value under that key is different from the one specified, the function returns `NULL`

**Syntax**

```sql
​​JSON_EXTRACT(json, json_pointer_expression, expected_type)
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `json` | TEXT | The JSON document from which the value is to be extracted |
| `json_pointer_expression` | Literal string | A JSON pointer to the location of the value in the JSON document |
| `expected_type` | Literal String | A literal string name of the expected return type. See supported types bellow |

**Return Value**

If the key pointed by the JSON path exists and its type conforms with the`expected_type` parameter - the value under that key.

Otherwise, return `NULL`

**Usage example**

```sql
SELECT JSON_EXTRACT(json,'/value/dyid', 'INT')
```

Returns: **987**

```sql
JSON_EXTRACT(json, '/value/no_such_key', 'TEXT')
```

Returns: `NULL`

```sql
JSON_EXTRACT(json, '/value/data/uid', 'INT')
```

Returns: `NULL` since the JSON type under that key is a string.

```sql
JSON_EXTRACT(json,'/value/keywords', 'ARRAY(TEXT)')
```

Returns: `["insanely","fast","analytics"]`

## JSON\_EXTRACT\_RAW

Returns the scalar or sub-object pointed by the JSON Pointer as a string.

**Syntax**

```sql
​​JSON_EXTRACT_RAW(json, json_pointer_expression)
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `json` | TEXT | The JSON document from which the sub-object is to be extracted |
| `json_pointer_expression` | Literal string | A JSON pointer to the location of the sub-object in the JSON |

**Return value**

A string representation of the scalar or sub-object under the specified key, if such key exists. Otherwise `NULL`

**Usage Example**

```sql
SELECT JSON_EXTRACT_RAW(json,'/value/dyid')
```

Returns: "987"

```sql
JSON_EXTRACT_RAW(json, '/value/data/tagIdToHits')
```

Returns \(as a TEXT\):

```javascript
"map": {
  "1737729": 32,
  "1775582": 35
}
```

## JSON\_EXTRACT\_ARRAY\_RAW

Returns a string representation of a JSON array pointed by the supplied JSON pointer.

This function is useful when working with heterogeneously typed arrays and arrays containing JSON objects in which case each object will be further processed by functions such as [TRANSFORM](https://app.gitbook.com/@firebolt/s/documentation-dev/~/drafts/-MPiM8b7cHe_PO5iU_Ok/v/ariel%2Fjson-functions/sql-functions-reference/semi-structured-functions#transform).

**Syntax**

```sql
​​JSON_EXTRACT_ARRAY_RAW(json, json_pointer_expression)
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `json` | TEXT | The JSON document from which the array is to be extracted |
| `json_pointer_expression` | Literal string | A JSON pointer to the location of the array in the JSON |

**Return value**

A Firebolt array whose elements are string representations of the scalars or objects contained in the JSON array under the specified key, if such key exists. Otherwise `NULL`

**Usage example**

```sql
SELECT JSON_EXTRACT_ARRAY_RAW(json, '/value/events')
```

Returns \(as an array of TEXT\):

```javascript
[
        '{
            "EventId": 547,
            "EventProperties" :
            {
                "UserName":"John Doe",
                "Successful": true
            }
        }',
        '{
            "EventId": 548,
            "EventProperties" :
            {
                "ProductID":"xy123",
                "items": 2
            }
        }'
    ]
```

Note that the single quotes denote that these are SQL strings, within a Firebolt array. The exact output may vary depending on the selected output format.

## JSON\_EXTRACT\_KEYS

Returns an array of strings containing the keys under the \(sub\)-object pointed by the JSON Pointer.

**Syntax**

```sql
JSON_EXTRACT_KEYS(json, json_pointer_expression)
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `json` | TEXT | The JSON document from the keys are to be extracted |
| `json_pointer_expression` | Literal string | A JSON pointer to the location of \(sub\)-object whose keys are to be extracted |

**Return value**

A Firebolt array of strings consisting the keys of JSON \(sub\)-object, if such key exists. Otherwise `NULL`

**Usage example**

```sql
SELECT JSON_EXTRACT_KEYS(json, 'value')
FROM RAW_JSON
```

Returns: `["dyid","uid","keywords","tagIdToHits","events"]`

## JSON\_EXTRACT\_VALUES

Returns an array of string representations, each element containing the value \(scalar or sub-object\) pointed by the JSON Pointer.

**Syntax**

```sql
​​JSON_EXTRACT_VALUES(json, json_pointer_expression)
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `json` | TEXT | The JSON document from which the values are to be extracted |
| `json_pointer_expression` | Literal string | A JSON pointer to the location of \(sub\)-object whose values are to be extracted |

**Return value**

A Firebolt array of strings consisting the values of the JSON \(sub\)-object, if such key exists. Otherwise `NULL`

**Usage example**

```sql
select JSON_EXTRACT_VALUES(j, 'value')
FROM RAW_JSON
```

Returns:

```javascript
[
    '"987"',
    '"987654"',
    '["insanely","fast","analytics"]',
    '{"map":{"1737729":32,"1775582":35}}',
    '[{"EventId":547,"EventProperties":{"UserName":"John Doe","Successful":true}},{"EventId":548,"EventProperties":{"ProductID":"xy123","items":2}}]'
]
```

Here, as with [JSON\_EXTRACT\_KEYS](https://app.gitbook.com/@firebolt/s/documentation-dev/v/ariel%2Fjson-functions/sql-functions-reference/json-functions#json_extract_keys), the single quotes are to illustrate that it is a Firebolt array whose elements are SQL strings. The results as a whole _is not_ a JSON string. Each element of the result is.
