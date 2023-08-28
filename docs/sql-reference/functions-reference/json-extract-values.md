---
layout: default
title: JSON_EXTRACT_VALUES
description: Reference material for JSON_EXTRACT_VALUES function
parent:  SQL functions
---

# JSON_EXTRACT_VALUES

Returns an array of string values from a JSON document using the key location specified by the `<json_pointer_expression>.` If no such key exists, returns `NULL.`

## Syntax
{: .no_toc}

```sql
JSON_EXTRACT_VALUES(<json>, '<json_pointer_expression>')
```

# Parameters 
{: .no_toc}

| Parameter                   | Description                                               | Supported input types | 
| :--------------------------- | :--------------------------------------------------------- | :----------|
| `<json>`                    | The JSON document from which the array is to be extracted. | `TEXT` | 
| `<json_pointer_expression>` | A JSON pointer to the location of the array in the JSON. For more information, see [JSON pointer expression syntax](./index.md#json-pointer-expression-syntax).    | `TEXT` | 

# Return Types 
* If key is provided, returns an `ARRAY` of strings
* If no key is provided, returns `NULL` 

## Example
{: .no_toc}

For the JSON document indicated by `<json_common_example>` below, see [JSON common example](./index.md#json-common-example). The **Returns** result is based on this common example.

```sql
SELECT
    JSON_EXTRACT_VALUES(<json_common_example>, 'value')
FROM
    RAW_JSON
```

**Returns**:

`["987","\"987654\"","[\"insanely\",\"fast\",\"analytics\"]","{\"map\":{\"1737729\":32,\"1775582\":35}}","[{\"EventId\":547,\"EventProperties\":{\"UserName\":\"John Doe\",\"Successful\":true}},{\"EventId\":548,\"EventProperties\":{\"ProductID\":\"xy123\",\"items\":2}}]"]`
