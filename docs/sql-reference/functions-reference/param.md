---
layout: default
title: PARAM
description: Reference material for PARAM function
parent: SQL functions
---

# PARAM

Evaluates a provided query parameter and returns its value as `TEXT`.

## Syntax
{: .no_toc}

```sql
PARAM(<parameter>)
```

| Parameter | Description                         |Supported input types |
| :--------- | :----------------------------------- | :---------------------|
| `<parameter>` | Constant string containing the name of the query parameter to evaluate. | `TEXT` |

## Return Type
`TEXT`

## Specifying query parameters
To pass query parameters to the query, you must specify a request property named `query_parameters`.
The `PARAM` function looks for this request property and expects a JSON format with the following schema:

```sql
query_parameters: json_array | json_object
json_array: [ json_object, … ]
json_object: { “name” : parameter_name, “value” : parameter_value }
```

You can include a single query parameter in the request properties, for example: 

`{ “name”: “country”, “value”: “USA” }`


or multiple query parameters:

`[ 
  { “name”: “country”, “value”: “USA” },
  { “name”: “states”, “value”: “WA, OR, CA” },
  { “name”: “max_sales”, “value”: 10000 }
]`

## Examples
{: .no_toc}

With query parameters set as: 
```sql
{ "name": "level", "value": "Drift" }
```

the query below counts the number of "Drift" type levels:
```sql
SELECT COUNT(*) AS level_count FROM levels WHERE leveltype = PARAM('level')
```

**Returns**: 
| level_count   |
| :------------- |
| 2              |
