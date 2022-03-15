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
  These functions work on array-typed columns, but instead of being applied row by row, they combine the results or all the array belonging to the groups defined by the `GROUP BY` clause.

* [Aggregation functions](#aggregation-functions)  
  These functions perform a calculation across a set of rows, returning a single value.

* [Array functions](#array-functions)  
  Used for the manipulation and querying of array typed columns, such as transformation, filtering, and un-nesting (an operation that converts the array to a regular column)

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

* [ARRAY_MAX_GLOBAL](array-max-global.md)  

* [ARRAY_MIN_GLOBAL](array-min-global.md)  

* [ARRAY_SUM_GLOBAL](array-sum-global.md)  

## Aggregation functions

* [ANY](any.md)  

* [ANY_VALUE](any_value.md)  

* [APPROXPERCENTILE](approx-percentile.md)  

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

* [ALL_MATCH](all-match.md)  

* [ANY_MATCH](any-match.md)  

* [ARRAY_CONCAT](array-concat.md)  

* [ARRAY_COUNT](array-count.md)  

* [ARRAY_COUNT_GLOBAL](array-count-global.md)  

* [ARRAY_CUMULATIVE_SUM](array-cumulative-sum.md)  

* [ARRAY_DISTINCT](array-distinct.md)  

* [ARRAY_FILL](array-fill.md)  

* [ARRAY_FIRST](array-first.md)  

* [ARRAY_FIRST_INDEX](array-first-index.md)  

* [ARRAY_INTERSECT](array-intersect.md)  

* [ARRAY_JOIN](array-join.md)  

* [ARRAY_MAX](array-max.md)  

* [ARRAY_MIN](array-min.md)  

* [ARRAY_REPLACE_BACKWARDS](array-replace-backwards.md)  

* [ARRAY_REVERSE](array-reverse.md)  

* [ARRAY_SORT](array-sort.md)  

* [ARRAY_SUM](array-sum.md)  

* [ARRAY_UNIQ](array-uniq.md)  

* [ARRAY_UNNEST](array_unnest.md)  

* [CONTAINS](contains.md)  

* [ELEMENT_AT](element-at.md)  

* [FILTER](filter.md)  

* [FLATTEN](flatten.md)  

* [INDEX_OF](index-of.md)  

* [LENGTH](length.md)  

* [NEST](nest.md)  

* [REDUCE](reduce.md)  

* [SLICE](slice.md)  

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

* [AVG](avg.md)  

* [COUNT](count.md)  

* [DENSE_RANK](dense-rank.md)  

* [LAG](lag.md)  

* [LEAD](lead.md)  

* [MAX](max.md)  

* [MIN](min.md)  

* [RANK](rank.md)  

* [ROW_NUMBER](row-number.md)  

* [SUM](sum.md)  
