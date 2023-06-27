---
layout: default
title: PARAM
description: Reference material for PARAM function
parent: SQL functions
---

# PARAM

Evaluates provided query parameter and returns its value as `TEXT`

## Syntax
{: .no_toc}

```sql
PARAM(<param_name>)
```

| Parameter      | Description                                   |
| :------------- |:--------------------------------------------- |
| `<param_name>` | Constant string containing name of the query parameter to evaluate |

## Specifying query parameters
In order to pass query parameters to the query, the user can specify a new request property named `query_parameters`.
The param function looks for it, and it expects it to be in JSON format with the following schema:

```sql
query_parameters: json_array | json_object
json_array: [ json_object, … ]
json_object: { “name” : param_name, “value” : param_value }
```

### Examples
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
