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
| `<parameter>` | Constant string containing the name of the query parameter to evaluate | `TEXT` |

## Return Type
`TEXT`

## Specifying query parameters
In order to pass query parameters to the query, the user can specify a new request property named `query_parameters`.
The PARAM function looks for this request property and expects a JSON format with the following schema:

```sql
query_parameters: json_array | json_object
json_array: [ json_object, … ]
json_object: { “name” : parameter_name, “value” : parameter_value }
```

For example: 

* Single parameter:

{ “name”: “country”, “value”: “USA” }


* Multiple parameters

[ 
  { “name”: “country”, “value”: “USA” },
  { “name”: “states”, “value”: “WA, OR, CA” },
  { “name”: “max_sales”, “value”: 10000 }
]

## Examples
{: .no_toc}

Query:
```sql
SELECT COUNT(*) FROM Sales WHERE country_name = PARAM('country')
```

Query parameters:
```sql
{ “name”: “country”, “value”: “USA” }
```

**Returns**: 
Count of sales for USA
