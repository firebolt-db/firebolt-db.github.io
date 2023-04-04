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
  Used for the manipulation and querying of `ARRAY`-typed columns, such as transforming and filtering. Includes [Lambda functions](#lambda-functions).

* [Conditional and miscellaneous functions](#conditional-and-miscellaneous-functions)  
  These functions include various methods for modifying data types and applying conditional operations.   

* [Date and time functions](#date-and-time-functions)  
  Functions for manipulating date and time data types.   

* [JSON functions](#json-functions)  
  These functions extract and transform JSON into Firebolt native types, or JSON sub-objects. They are used either during the ELT process or applied to columns storing JSON objects as plain `TEXT`.

* [Numeric functions](#numeric-functions)  
  Functions for manipulating data types including `INTEGER`, `BIGINT`, `DOUBLE PRECISION`, and other numeric types.

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

* [APPROX_COUNT_DISTINCT](approx-count-distinct.md)  

* [APPROX_PERCENTILE](approx-percentile.md)  

* [AVG](avg.md)

* [CHECKSUM](checksum.md)  

* [COUNT](count.md)  

* [HLL_COUNT_DISTINCT](hll-count-distinct.md)  

* [MAX](max.md)  

* [MAX_BY](max-by.md)  

* [MEDIAN](median.md)  

* [MIN](min.md)  

* [MIN_BY](min-by.md)  

* [NEST](nest.md)  

* [PERCENTILE_CONT](percentile-cont.md)

* [PERCENTILE_DISC](percentile-disc.md)

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

## Bytea functions

* [CONCAT](concat.md)

* [DECODE](decode.md)

* [ENCODE](encode.md)

* [LENGTH](length.md)

## Conditional and miscellaneous functions

* [CASE](case.md)  

* [CAST](cast.md)  

* [CITY_HASH](city-hash.md)  

* [COALESCE](coalesce.md)  

* [IFNULL](ifnull.md)  

* [NULLIF](nullif.md)  

* [TRY_CAST](try-cast.md)  

* [VERSION](version.md)

* [ZEROIFNULL](zeroifnull.md)  

## Date and time functions

* [CURRENT_DATE](current-date.md)  

* [CURRENT_TIMESTAMP](current-timestamp.md)  

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

* [LIKE](like.md)

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

* [REGEXP_REPLACE](regexp-replace.md)

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

* [TO_TIMESTAMP](to-timestamp.md)  

* [TO_UNIX_TIMESTAMP](to-unixtime.md)  

* [TO_UNIXTIME](to-unix-timestamp.md)  

* [TRIM](trim.md)  

* [UPPER](upper.md)  

## Window functions

* [AVG](avg-window.md)  

* [COUNT](count-window.md)  

* [CUME_DIST](cume-dist.md)

* [DENSE_RANK](dense-rank.md)

* [FIRST_VALUE](first-value.md)

* [LAG](lag.md)

* [LEAD](lead.md)

* [MAX](max-window.md)

* [MIN](min-window.md)

* [NTH_VALUE](nth-value.md)

* [NTILE](ntile.md)

* [PERCENT_RANK](percent-rank.md)

* [PERCENTILE_CONT](percentile-cont-window.md)

* [PERCENTILE_DISC](percentile-disc-window.md)

* [RANK](rank.md)  

* [ROW_NUMBER](row-number.md)  

* [SUM](sum-window.md)  

Some functions support an optional `frame_clause`.

The `frame_clause` can be one of the following: 

```sql
    { RANGE | ROWS } <frame_start>
    { RANGE | ROWS } BETWEEN <frame_start> AND <frame_end>
  ```

where `<frame_start>` and `<frame_end>` is one of the following: 

```sql 
  UNBOUNDED PRECEDING
  offset PRECEDING
  CURRENT ROW
  offset FOLLOWING
  UNBOUNDED FOLLOWING
```

The `frame_clause` specifies the set of rows constituting the window frame within the current partition. The frame can be specified in `RANGE` or `ROWS` mode; in each case, the frame runs from the `<frame_start>` to the `<frame_end>`. If `<frame_end>` is omitted, the end defaults to `CURRENT ROW`.

**Usage**
 
* The default framing option is `RANGE UNBOUNDED PRECEDING`, which is the same as `RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`. With an `ORDER BY` clause, this sets the frame to be all rows from the partition start through the current row's last `ORDER BY` peer. Without an `ORDER BY` clause, all rows of the partition are included in the window frame, since all rows become peers of the current row.

* The number of rows to the end of the frame is limited by the number of rows to the end of the partition; for rows near the partition ends, the frame might contain fewer rows than elsewhere.

**UNBOUNDED PRECEDING, UNBOUNDED FOLLOWING**
* A `<frame_start>` of `UNBOUNDED PRECEDING` means that the frame starts with the first row of the partition. Similarly a `<frame_end>` of `UNBOUNDED FOLLOWING` means that the frame ends with the last row of the partition.

**CURRENT ROW**
* In `RANGE` mode, a `<frame_start>` of `CURRENT ROW` means the frame starts with the current row's first peer row (a row that the window's `ORDER BY` clause sorts as equivalent to the current row), while a `<frame_end>` of `CURRENT ROW` means the frame ends with the current row's last peer row. 

* In `ROWS` mode, `CURRENT ROW` simply means the current row.

**offset PRECEDING, offset FOLLOWING**

* For the `offset PRECEDING` and `offset FOLLOWING` frame options, the offset must be an expression not containing any variables, aggregate functions, or window functions. The meaning of the offset depends on the frame mode:
  * In `ROWS` mode, the offset must yield a non-null, non-negative integer, and the option means that the frame starts or ends the specified number of rows before or after the current row.

  * In `RANGE` mode, these options require that the `ORDER BY` clause specify exactly one column. The offset specifies the maximum difference between the value of that column in the current row and its value in preceding or following rows of the frame. The data type of the offset expression varies depending on the data type of the ordering column. For numeric ordering columns it is typically of the same type as the ordering column. For DATE or TIMESTAMP ordering columns, it is an interval. For example, if the ordering column is of type DATE or TIMESTAMP, one could write `RANGE BETWEEN '1 day' PRECEDING AND '10 days' FOLLOWING`. The offset is still required to be non-null and non-negative, though the meaning of “non-negative” depends on the data type.  
  
  * In `ROWS` mode, `0 PRECEDING` and `0 FOLLOWING` are equivalent to `CURRENT ROW`. This normally holds in `RANGE` mode as well, for an appropriate data-type-specific meaning of “zero”.


**Restrictions**

* `frame_start` cannot be `UNBOUNDED FOLLOWING`
* `frame_end` cannot be `UNBOUNDED PRECEDING`
* `frame_end` cannot appear earlier in the above list of `frame_start` and `frame_end` options than the `frame_start` choice does. 
   For example `RANGE BETWEEN CURRENT ROW AND offset PRECEDING` is not allowed, but `ROWS BETWEEN 7 PRECEDING AND 8 PRECEDING` is allowed, even though it would never select any rows.


**Example**

The example below is querying test scores for students in various grade levels. Unlike a regular `AVG()` aggregation, the window function allows us to see how each student individually compares to the average test score for their grade level, as well as compute the average test score while looking at different slices of the data for different grade levels – narrowing down the set of rows that constitutes the window using framing options such as PRECEDING or FOLLOWING.

```sql
SELECT
  first_name,
  grade_level,
  test_score,
  ROUND(AVG(test_score) OVER (PARTITION BY grade_level), 2) AS test_score_avg,
  ROUND(AVG(test_score) OVER (PARTITION BY grade_level ORDER BY test_score ASC ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS avg_1p_1f,
  ROUND(AVG(test_score) OVER (PARTITION BY grade_level ORDER BY test_score ASC ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING), 2) AS avg_2p_2f,
  ROUND(AVG(test_score) OVER (PARTITION BY grade_level ORDER BY test_score ASC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING), 2) AS avg_up_2f
FROM
  class_test
ORDER BY 
  grade_level, 
  test_score;
```

**Returns**:

```
' | first_name | grade_level | test_score | test_score_avg | avg_1p_1f | avg_2p_2f | avg_up_2f |
  +------------+-------------+------------+----------------+-----------+-----------+-----------+
' | Frank      | 9           | 76         | 81.33          | 77        | 77.67     | 77        |
' | Jojo       | 9           | 78         | 81.33          | 77.67     | 78.25     | 77.67     |
' | Iris       | 9           | 79         | 81.33          | 79        | 79.6      | 78.25     |
' | Peter      | 9           | 80         | 81.33          | 81.33     | 82.4      | 79.6      |
' | Sammy      | 9           | 85         | 81.33          | 85        | 83.5      | 81.33     |
' | Humphrey   | 9           | 90         | 81.33          | 87.5      | 85        | 81.33     |
' | Yolinda    | 10          | 30         | 68.2           | 44.5      | 55.67     | 44.5      |
' | Albert     | 10          | 59         | 68.2           | 55.67     | 63        | 55.67     |
' | Deborah    | 10          | 78         | 68.2           | 74        | 68.2      | 63        |
' | Mary       | 10          | 85         | 68.2           | 84        | 77.75     | 68.2      |
' | Shawn      | 10          | 89         | 68.2           | 87        | 84        | 68.2      |
' | Carol      | 11          | 52         | 73             | 60        | 64.33     | 60        |
' | Larry      | 11          | 68         | 73             | 64.33     | 67        | 64.33     |
' | Wanda      | 11          | 73         | 73             | 72        | 68.8      | 67        |
' | Otis       | 11          | 75         | 73             | 74.67     | 77.2      | 68.8      |
' | Shangxiu   | 11          | 76         | 73             | 81.67     | 79.5      | 73        |
' | Roseanna   | 11          | 94         | 73             | 85        | 81.67     | 73        |
' | Thomas     | 12          | 66         | 89             | 77.5      | 82.33     | 77.5      |
' | Jesse      | 12          | 89         | 89             | 82.33     | 85        | 82.33     |
' | Brunhilda  | 12          | 92         | 89             | 91.33     | 86.8      | 85        |
' | Charles    | 12          | 93         | 89             | 93        | 93.6      | 86.8      |
' | Franco     | 12          | 94         | 89             | 95.67     | 94.75     | 89        |
' | Gary       | 12          | 100        | 89             | 97        | 95.67     | 89        |
  +------------+-------------+------------+----------------+-----------+-----------+-----------+
```

