---
layout: default
title: SQL functions
description: Reference for SQL functions available in Firebolt.
nav_order: 15
has_children: true
has_toc: false
---

# SQL functions

Use the alphabetical list in the navigation pane to find the syntax for commands that you already know.

Use the functional list below to find commands for a specific task area that you're working in.

* [Aggregate array functions](#aggregate-array-functions)  
  These functions work on array-typed columns, but instead of being applied row by row, they combine the results of all the arrays belonging to each of the groups defined by the `GROUP BY` clause.

* [Aggregation functions](#aggregation-functions)  
  These functions perform a calculation across a set of rows, returning a single value.

* [Array functions](#array-functions)  
  Used for the manipulation and querying of `ARRAY`-typed columns, such as transforming and filtering. Includes Lambda array functions.

* [Conditional and miscellaneous functions](#conditional-and-miscellaneous-functions)  
  These functions include various methods for modifying data types and applying conditional operations.   

* [Date and time functions](#date-and-time-functions)  
  Functions for manipulating date and time data types.   

* [JSON functions](#json-functions)  
  These functions extract and transform raw JSON into Firebolt native types, or JSON sub-objects. They are used either during the ELT process or applied to columns storing JSON objects as plain `TEXT`.

* [Numeric functions](#numeric-functions)  
  Functions for manipulating data types including `INT`, `LONG`, `DOUBLE`, and other numeric types.

* [String functions](#string-functions)  
  Functions for manipulating string data types

* [Window functions](#window-functions)  
  These functions perform a calculation across a specified set of table rows.

## Aggregate array functions

Aggregate semi-structured functions work globally on all the arrays in a given column expression, instead of a row-by-row application.

At their simplest form (without a `GROUP BY` clause) - they will provide the result of globally applying the function on all of the elements of the arrays in the column expression specified as their argument. For example, `ARRAY_SUM_GLOBAL` will return the sum of all the elements in all the array of the given column. `ARRAY_MAX_GLOBAL` will return the maximum element among all of the elements in _all_ of the arrays in the given column expression.

When combined with a `GROUP BY` clause, these operations will be performed on all of the arrays in each group.

* [ARRAY_MAX_GLOBAL](array-max-global.md)  

* [ARRAY_MIN_GLOBAL](array-min-global.md)  

* [ARRAY_SUM_GLOBAL](array-sum-global.md)  

## Aggregation functions

* [ANY](any.md)  

* [ANY_VALUE](any_value.md)  

* [APPROX_PERCENTILE](approx-percentile.md)  

* [AVG](avg.md)

* [CHECKSUM](checksum.md)  

* [COUNT](count.md)  

* [MAX](max.md)  

* [MAX_BY](max-by.md)  

* [MEDIAN](median.md)  

* [MIN](min.md)  

* [MIN_BY](min-by.md)  

* [NEST](nest.md)  

* [STDDEV_SAMP](stddev-samp.md)  

* [SUM](sum.md)  

## Array functions

* [ARRAY_CONCAT](array-concat.md)

* [ARRAY_COUNT_GLOBAL](array-count-global.md)

* [ARRAY_DISTINCT](array-distinct.md)

* [ARRAY_INTERSECT](array-intersect.md)

* [ARRAY_JOIN](array-join.md)  

* [ARRAY_MAX](array-max.md)  

* [ARRAY_MIN](array-min.md)

* [ARRAY_REVERSE](array-reverse.md)

* [ARRAY_UNIQ](array-uniq.md)  

* [ARRAY_UNNEST](array_unnest.md)  

* [CONTAINS](contains.md)  

* [ELEMENT_AT](element-at.md)

* [FLATTEN](flatten.md)  

* [INDEX_OF](index-of.md)  

* [LENGTH](length.md)  

* [NEST](nest.md)  

* [REDUCE](reduce.md)  

* [SLICE](slice.md)

### Lambda functions

For more information about using Lambda functions, see [Manipulating arrays with Lambda functions](../../working-with-semi-structured-data/working-with-arrays.md#manipulating-arrays-with-lambda-functions).

* [ALL_MATCH](all-match.md)  

* [ANY_MATCH](any-match.md)  

* [ARRAY_COUNT](array-count.md)  

* [ARRAY_CUMULATIVE_SUM](array-cumulative-sum.md)  

* [ARRAY_FILL](array-fill.md)  

* [ARRAY_FIRST](array-first.md)  

* [ARRAY_FIRST_INDEX](array-first-index.md)  

* [ARRAY_REPLACE_BACKWARDS](array-replace-backwards.md)  

* [ARRAY_SORT](array-sort.md)  

* [ARRAY_SUM](array-sum.md)  

* [FILTER](filter.md)  

* [TRANSFORM](transform.md)  

## Conditional and miscellaneous functions

* [CASE](case.md)  

* [CAST](cast.md)  

* [CITY_HASH](city-hash.md)  

* [COALESCE](coalesce.md)  

* [IFNULL](ifnull.md)  

* [NULLIF](nullif.md)  

* [TRY_CAST](try-cast.md)  

* [ZEROIFNULL](zeroifnull.md)  

## Date and time functions

* [CURRENT_DATE](current-date.md)  

* [DATE_ADD](date-add.md)  

* [DATE_DIFF](date-diff.md)  

* [DATE_FORMAT](date-format.md)  

* [DATE_TRUNC](date-trunc.md)  

* [EXTRACT](extract.md)  

* [FROM_UNIXTIME](from-unixtime.md)  

* [NOW](now.md)  

* [TIMEZONE](timezone.md)  

* [TO_DAY_OF_WEEK](to-day-of-week.md)  

* [TO_DAY_OF_YEAR](to-day-of-year.md)  

* [TO_HOUR](to-hour.md)  

* [TO_MINUTE](to-minute.md)  

* [TO_MONTH](to-month.md)  

* [TO_QUARTER](to-quarter.md)  

* [TO_SECOND](to-second.md)  

* [TO_STRING](to-string.md)  

* [TO_WEEK](to-week.md)  

* [TO_WEEKISO](to-weekiso.md)  

* [TO_YEAR](to-year.md)  

## JSON functions

* [JSON_EXTRACT](json-extract.md)  

* [JSON_EXTRACT_ARRAY_RAW](json-extract-array-raw.md)  

* [JSON_EXTRACT_KEYS](json-extract-keys.md)  

* [JSON_EXTRACT_RAW](json-extract-raw.md)  

* [JSON_EXTRACT_VALUES](json-extract-values.md)  

The reference for each JSON function uses common syntax and conventions as outlined below.

### JSON pointer expression syntax

The placeholder `<json_pointer_expression>` indicates where you should use a JSON pointer, which is a way to access specific elements in a JSON document. For a formal specification, see [RFC6901](https://tools.ietf.org/html/rfc6901).

A JSON pointer starts with a forward slash (`/`), which denotes the root of the JSON document. This is followed by a sequence of property (key) names or zero-based ordinal numbers separated by slashes. You can specify property names or use ordinal numbers to specify the Nth property or the Nth element of an array.

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

| Pointer              | Result                             | Notes           |
| :------------------- | :--------------------------------- | :-------------- |
| `/`                  | `{` <br>`   "key": 123,` <br>`   "key~with~tilde": 2,` <br>`   "key/with/slash": 3,` <br>`   "value": {` <br>`      "dyid": 987,` <br>`      "keywords" : ["insanely","fast","analytics"]` <br>`   }` | Returns the whole document. |
| `/key`               | 123                                |                 |
| `/key~0with~0tilde`  | 2                                  | Indicates the value associated with the `key~with~tilde` property name. |
| `/key~1with~1slash`  | 3                                  | Indicates the value associated with the `key/with/slash` property name. |
| `/0`                 | 123                                | Uses an ordinal to indicate the value associated with the `key` property name. The `key` property is in the first 0-based position.        |
| `/value/keywords/2`  | analytics                          | Indicates the element "analytics", which is in the third 0-based position of the array value associated with they keywords property. |

### Supported type parameters

Some functions accept a *data type parameter*, indicated in this reference with the `<expected_type>` placeholder. This parameter specifies the expected type as indicated by `<json_pointer_expression>`. The `<expected_type>` is specified using a string literal that corresponds to supported Firebolt SQL data types. The type parameter does not accept all SQL types because the JSON type system has fewer types than SQL and must be one of the following:

* `INT` &ndash; used for integers as well as JSON boolean.
* `DOUBLE` &ndash; used for real numbers. It also works with integers. For performance reasons, favor using `INT` when the values in the JSON document are known integers.
* `TEXT` &ndash; used for strings.
* `ARRAY(<type>)` &ndash; indicates an array where `<type>` is one of `INT`, `DOUBLE`, or `TEXT`.

The following data types are _not supported_: `DATE`, `DATETIME`, `FLOAT` (for real numbers, use `DOUBLE`).

### JSON common example

Usage examples for JSON functions in this reference are based on the JSON document below, which is indicated using the `<json_common_example>` placeholder.

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

## Numeric functions

* [ABS](abs.md)  

* [ACOS](acos.md)  

* [ASIN](asin.md)  

* [ATAN](atan.md)  

* [ATAN2](atan2.md)  

* [CBRT](cbrt.md)  

* [CEIL, CEILING](ceil.md)  

* [COS](cos.md)  

* [COT](cot.md)  

* [DEGREES](degrees.md)  

* [EXP](exp.md)  

* [FLOOR](floor.md)  

* [LOG](log.md)  

* [MOD](mod.md)  

* [PI](pi.md)  

* [POW, POWER](pow.md)  

* [RADIANS](radians.md)  

* [RANDOM](random.md)  

* [ROUND](round.md)  

* [SIGN](sign.md)

* [SIN](sin.md)  

* [SQRT](sqrt.md)  

* [TAN](tan.md)  

* [TRUNC](trunc.md)  

## String functions

* [BASE64_ENCODE](base64-encode.md)  

* [CONCAT](concat.md)  

* [EXTRACT_ALL](extract-all.md)  

* [GEN_RANDOM_UUID](gen-random-uuid.md)  

* [ILIKE](ilike.md)  

* [LENGTH](length.md)  

* [LOWER](lower.md)  

* [LPAD](lpad.md)  

* [LTRIM](ltrim.md)  

* [MATCH](match.md)  

* [MATCH_ANY](match-any.md)  

* [MD5](md5.md)  

* [MD5_NUMBER_LOWER64](md5-number-lower64.md)  

* [MD5_NUMBER_UPPER64](md5-number-upper64.md)  

* [REGEXP_LIKE](regexp-like.md)  

* [REGEXP_MATCHES](regexp-matches.md)  

* [REPEAT](repeat.md)  

* [REPLACE](replace.md)  

* [REVERSE](reverse.md)  

* [RPAD](rpad.md)  

* [RTRIM](rtrim.md)  

* [SPLIT](split.md)  

* [SPLIT_PART](split-part.md)  

* [STRPOS](strpos.md)  

* [SUBSTR](substr.md)  

* [TO_DATE](to-date.md)  

* [TO_DOUBLE](to-double.md)  

* [TO_FLOAT](to-float.md)  

* [TO_INT](to-int.md)  

* [TO_LONG](to-long.md)  

* [TO_TIMESTAMP](to-timestamp.md)  

* [TO_UNIX_TIMESTAMP](to-unixtime.md)  

* [TO_UNIXTIME](to-unix-timestamp.md)  

* [TRIM](trim.md)  

* [UPPER](upper.md)  

## Window functions

* [AVG](avg-window.md)  

* [COUNT](count-window.md)  

* [DENSE_RANK](dense-rank.md)  

* [LAG](lag.md)  

* [LEAD](lead.md)  

* [MAX](max-window.md)  

* [MIN](min-window.md)  

* [RANK](rank.md)  

* [ROW_NUMBER](row-number.md)  

* [SUM](sum-window.md)  
