---
layout: default
title: JSON_EXTRACT_KEYS
description: Reference material for JSON_EXTRACT_KEYS function
parent:  SQL functions
---

# JSON_EXTRACT_KEYS

Returns an array of strings containing the keys at the nesting level indicated by the specified `<json_pointer_expression>`. If keys do not exist, returns `NULL`.

## Syntax
{: .no_toc}

```sql
JSON_EXTRACT_KEYS(<json>, '<json_pointer_expression>')
```

# Parameters 
{: .no_toc}

| Parameter                   | Description                                               | Supported input types | 
| :--------------------------- | :--------------------------------------------------------- | :----------|
| `<json>`                    | The JSON document from which the array is to be extracted. | `TEXT` | 
| `<json_pointer_expression>` | A JSON pointer to the location of the array in the JSON. For more information, see [JSON pointer expression syntax](./index.md#json-pointer-expression-syntax).    |`TEXT` | 

## Return Types 

* If a key is provided, returns an `ARRAY` of strings
* If no key is provided, returns `NULL`

## Example
{: .no_toc}

For the JSON document indicated by `<json_common_example>` below, see [JSON common example](./index.md#json-common-example). The **Returns** result is based on this common example.

```sql
SELECT
	JSON_EXTRACT_KEYS(<json_common_example>, 'value')
FROM
	RAW_JSON
```

**Returns**: `["dyid","uid","keywords","tagIdToHits","events"]`
