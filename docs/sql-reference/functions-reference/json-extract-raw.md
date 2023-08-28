---
layout: default
title: JSON_EXTRACT_RAW
description: Reference material for JSON_EXTRACT_RAW function
parent:  SQL functions
---

# JSON_EXTRACT_RAW

Returns a string representation of the scalar or sub-object under the key indicated by `<json_pointer_expression>` if the key exists. If the key does not exist, returns `NULL`.

## Syntax
{: .no_toc}

```sql
JSON_EXTRACT_RAW(<json>, <json_pointer_expression>)
```

# Parameters 
{: .no_toc}

| Parameter                   | Description                                               | Supported input types | 
| :--------------------------- | :--------------------------------------------------------- | :----------|
| `<json>`                    | The JSON document from which the array is to be extracted. | `TEXT` | 
| `<json_pointer_expression>` | A JSON pointer to the location of the array in the JSON. For more information, see [JSON pointer expression syntax](./index.md#json-pointer-expression-syntax).    |    `TEXT` | 

# Return Types 

* If key is provided, returns `TEXT`
* If no key is provided, returns `NULL`

## Example
{: .no_toc}

For the JSON document indicated by `<json_common_example>` below, see [JSON common example](./index.md#json-common-example). The **Returns** result is based on this common example.

```sql
SELECT
    JSON_EXTRACT_RAW(<json_common_example>,'/value/dyid')
```

**Returns**: `987`

```sql
JSON_EXTRACT_RAW(<json_common_example>, '/value/tagIdToHits')
```

**Returns**: `{"map":{"1737729":32,"1775582":35}}`
