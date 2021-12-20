---
layout: default
title: String functions
nav_order: 6
parent: SQL functions reference
---

# String functions
{: .no_toc}

* Topic ToC
{:toc}

## BASE64\_ENCODE

Encodes a string into Base64 notation.

### Syntax
{: .no_toc}

```sql
BASE64_ENCODE(<expr>)
```

| Parameter | Description                                                                 |
| :--------- | :--------------------------------------------------------------------------- |
| `<expr>`  | Any expression that evaluates to a `STRING`, `TEXT`, or `VARCHAR` data type |

### Example
{: .no_toc}

```sql
SELECT
	BASE64_ENCODE('Hello World');
```

**Returns**: `SGVsbG8gV29ybGQ=`

## CONCAT

Concatenates the strings listed in the arguments without a separator.

### Syntax
{: .no_toc}

```sql
CONCAT( <string>, <string2>[, ...n] );
```
**&mdash;OR&mdash;**

```sql
<string> || <string2> || [ ...n]
```

| Parameter                     | Description                     |
| :----------------------------- | :------------------------------- |
| `<string>, <string2>[, ...n]` | The strings to be concatenated. |

### Example
{: .no_toc}

```sql
SELECT
	concat('Hello ', 'World!');
```

**Returns**: `Hello World!`

## EXTRACT\_ALL

Extracts fragments within a string that match a specified regex pattern. String fragments that match are returned as an array of `string` types.

### Syntax
{: .no_toc}

```sql
EXTRACT_ALL( <expr>, '<regex_pattern>' )
```

| Parameter         | Description                                                                 |
| :----------------- | :--------------------------------------------------------------------------- |
| `<expr>`          | Any expression that evaluates to a `STRING`, `TEXT`, or `VARCHAR` data type |
| `<regex_pattern>` | An re2 regular expression used for matching.                                |

### Example
{: .no_toc}

In the example below, `EXTRACT_ALL` is used to match variants of "Hello World". The regular expression pattern `'Hello.[Ww]orld!?'` does not match any special characters except for `!`.

```sql
SELECT
	EXTRACT_ALL (
		'Hello world, ;-+ Hello World!',
		'Hello.[Ww]orld!?'
	);
```

**Returns**:

```
["Hello world","Hello World!"]
```

## GEN\_RANDOM\_UUID

Returns a version 4 universally unique identifier (UUID) according to [RFC-4122](https://tools.ietf.org/html/rfc4122#section-4.4). This function accepts no arguments.

### Syntax
{: .no_toc}

```sql
GEN_RANDOM_UUID()
```

### Example
{: .no_toc}

The example below outputs the result of `GEN_RANDOM_UUID` as `session_id`.

```sql
SELECT
	GEN_RANDOM_UUID() AS session_id;
```

**Returns**:

```
+--------------------------------------+
|              session_id              |
+--------------------------------------+
| 08a95d43-2f01-4227-a111-de4f8ad205a0 |
+--------------------------------------+
```

## ILIKE

Allows matching of strings based on comparison to a pattern. `ILIKE` is normally used as part of a `WHERE` clause.

### Syntax
{: .no_toc}

```sql
<expr> ILIKE '<pattern>'
```

| Parameter   | Description                                                                                                                                                                                                                                                                              |
| :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<expr>`    | Any expression that evaluates to a `TEXT`, `STRING`, or `VARCHAR` data type.                                                                                                                                                                                                             |
| `<pattern>` | Specifies the pattern to match and is case-insensitive. SQL wildcards are supported: <br> <br>* Use an underscore (`_`) to match any single character<br>* Use a percent sign (`%`) to match any number of any characters, including no characters. |

**Example**

For this example, we will create and load data into a demonstration table `match_test`:

```sql
CREATE DIMENSION TABLE match_test (first_name TEXT, last_name TEXT);

INSERT INTO
	match_test
VALUES
	('Sammy', 'Sardine'),
	('Franco', 'Fishmonger'),
	('Carol', 'Catnip'),
	('Thomas', 'Tinderbox'),
	('Deborah', 'Donut'),
	('Humphrey', 'Hoagie'),
	('Frank', 'Falafel');
```

We can match first names that partially match the string "Fran" and any following characters as follows:

```sql
SELECT
	*
FROM
	match_test
WHERE
	first_name ILIKE 'Fran%';
```

**Returns**:

```
+------------+------------+
| first_name | last_name  |
+------------+------------+
| Frank      | Falafel    |
| Franco     | Fishmonger |
+------------+------------+
```

## LENGTH

Calculates the string length.

### Syntax
{: .no_toc}

```sql
​​LENGTH(<string>)​​
```

| Parameter  | Description                                |
| :---------- | :------------------------------------------ |
| `<string>` | The string for which to return the length. |

### Example
{: .no_toc}

```sql
SELECT LENGTH('abcd')
```

**Returns**: `4`

## LOWER

Converts the string to a lowercase format.

### Syntax
{: .no_toc}

```sql
​​LOWER(<string>)​​
```

| Parameter  | Description                 |
| :---------- | :--------------------------- |
| `<string>` | The string to be converted. |

### Example
{: .no_toc}

```
SELECT
	LOWER('ABCD');
```

**Returns**: `abcd`

## LPAD

Adds a specified pad string to the end of the string repetitively up until the length of the resulting string is equivalent to an indicated length.

The similar function to pad the end of a string is [`RPAD`](string-functions.md#rpad).

### Syntax
{: .no_toc}

```sql
​​LPAD(<str>, <length>[, <pad>])​​
```

| Parameter  | Description                                                                                                                                                                                                                 |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<str>`    | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string. ​ `<str>` can be a literal string or the name of a column. |
| `<length>` | The length of the string as an integer after it has been left-padded. ​ A negative number returns an empty string.                                                                                                          |
| `<pad>`    | The string to add to the start of the primary string `<str>`. If left blank, `<pad>` defaults to whitespace characters.                                                                                                     |

### Example
{: .no_toc}

The following statement adds the string "ABC" in front of the string Firebolt repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT
	LPAD('Firebolt', 20, 'ABC');
```

**Returns**:

```
ABCABCABCABCFirebolt
```

## LTRIM

Removes all consecutive occurrences of common whitespace (ASCII character 32) from the beginning of a string. It doesn’t remove other kinds of whitespace characters (tab, no-break space, etc.).

### Syntax
{: .no_toc}

```sql
​​LTRIM(<target>)​​
```

| Parameter  | Description               |
| :---------- | :------------------------- |
| `<target>` | The string to be trimmed. |

### Example
{: .no_toc}

```sql
SELECT
	LTRIM('     Hello, world! ');
```

**Returns**:

```
Hello, world!
```

## MATCH

Checks whether the string matches the regular expression `<pattern`>, which is a RE2 regular expression. ​ Returns `0` if it doesn’t match, or `1` if it matches.

### Syntax
{: .no_toc}

```sql
​​MATCH(<string>, '<pattern>')​​
```

| Parameter   | Description                                                           |
| :----------- | :--------------------------------------------------------------------- |
| `<string>`  | The string used to search for a match.                                |
| `<pattern>` | The regular expression pattern used to search `<string>` for a match. |

### Example
{: .no_toc}

The example below generates `0` as a result because it found no match. It is searching a string of numbers for alphabet characters.\*\* \*\*

```sql
SELECT
	MATCH('123','\\[a-Z|A-Z]') AS res;
```

**Returns**: `0`

In this second example, the `MATCH` expression generates a result of `1` because it found a match. It is searching for numeric digits in the string "123".

```sql
SELECT
	MATCH('123','\\d+');
```

**Returns**: `1`

## MATCH\_ANY

The same as [MATCH](string-functions.md#match), but it searches for a match with one or more more regular expression patterns. It returns `0` if none of the regular expressions match and `1` if any of the patterns matches.

Synonym for `MULTI_MATCH_ANY`

### Syntax
{: .no_toc}

```sql
​​MATCH_ANY(<string>, <pattern_array>)​​
```

| Parameter         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| :----------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>`        | The string to search for a match.                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `<pattern_array>` | A series of one or more regular expression patterns to search for a match in the `<string>`.<br>`<pattern_array>`</code> must be enclosed in brackets. Each pattern must be enclosed in single quotes and separated with commas.<br>For example, the `<pattern_array>` below consists of two regular expression patterns:<br>`[ '\\d+', '\\[a-Z|A-Z]' ]` |

### Example
{: .no_toc}

The query below searches for any matches within the string ​`123` ​​with the patterns `​['\d+','\[a-Z|A-Z]']`​. ​ Since at least one is found, it returns: `1`

```sql
SELECT
	MATCH_ANY('123', [ '\\d+', '\\[a-Z|A-Z]' ]) AS res;
```

**Returns**: `1`

## MD5

Calculates the MD5 hash of string, returning the result as a string in hexadecimal.

### Syntax
{: .no_toc}

```sql
​​MD5(<string>)​​
```

| Parameter  | Description                                               |
| :---------- | :--------------------------------------------------------- |
| `<string>` | The string to hash. For `NULL`, the function returns `0`. |

### Example
{: .no_toc}

```sql
SELECT
	MD5('text') AS res;
```

**Returns**: `1cb251ec0d568de6a929b520c4aed8d1`

## MD5\_NUMBER\_LOWER64

Represent the lower 64 bits of the MD5 hash value of the input string as `BIGINT`.

### Syntax
{: .no_toc}

```sql
​​MD5_NUMBER_LOWER64(<string>)​​
```

| Parameter  | Description                                                              |
| :---------- | :------------------------------------------------------------------------ |
| `<string>` | The string to calculate the MD5 hash value on and represent as `BIGINT.` |

### Example
{: .no_toc}

```sql
SELECT
	MD5_NUMBER_LOWER64('test') AS res;
```

**Returns**: `14618207765679027446`

## MD5\_NUMBER\_UPPER64

Represent the upper 64 bits of the MD5 hash value of the input string as `BIGINT`.

### Syntax
{: .no_toc}

```sql
​​MD5_NUMBER_UPPER64(<string>)​​
```

| Parameter  | Description                                                  |
| :---------- | :------------------------------------------------------------ |
| `<string>` | The string to calculate the MD5 on and represent as `BIGINT` |

### Example
{: .no_toc}

```sql
SELECT
	MD5_NUMBER_UPPER64('test') AS res;
```

**Returns**: `688887797400064883`

## REGEXP\_LIKE

This check whether a string pattern matches a regular expression string. Returns `0` if it doesn’t match, or `1` if it matches. ​ This is a ​​RE2​​ regular expression.

### Syntax
{: .no_toc}

```sql
​REGEXP_LIKE(<string>, '<pattern>')​​
```

| Parameter   | Description                                               |
| :----------- | :--------------------------------------------------------- |
| `<string>`  | The string searched for a match using the RE2 pattern.    |
| `<pattern>` | The pattern used to search for a match in the `<string>`. |

### Example
{: .no_toc}

```sql
​​SELECT REGEXP_LIKE('123','\\[a-z]') AS res;​​
```

**Returns**: `0`

```sql
SELECT REGEXP_LIKE('123','\\d+') AS res;​
```

**Returns**: `1`

## REGEXP\_MATCHES

Returns an array of all substrings that match a regular expression pattern. If the pattern does not match, returns an empty array.

```sql
REGEXP_MATCHES(<string>, <pattern>[,'<flag>[...]'])
```

| Parameter   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| :----------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>`  | The string from which to extract substrings, based on a regular expression                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `<pattern>` | An [re2 regular expression](https://github.com/google/re2/wiki/Syntax) for matching with the string.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `<flag>`    | Optional. Flags allow additional controls over characters used in the regular expression matching. If using multiple flags, you can include them in the same single-quote block without any separator character.<br>Firebolt supports the following re2 flags to override default matching behavior.* `i` - Specifies case-insensitive matching.<br>* `m` - Specifies multi-line mode. In this mode, `^` and `$` characters in the regex match the beginning and end of line.<br>* `s` - Specifies that the `.` metacharacter in regex matches the newline character in addition to any character in `.`<br>* Specifies Ungreedy mode. In this mode, the meaning of the metacharacters `*` and `+` in regex `<pattern>` are swapped with `*?` and `+?`, respectively. See the examples using flags below for the difference in how results are returned. |

### Example
{: .no_toc}

```sql
SELECT
	REGEXP_MATCHES('ABC', '^([A-Z]+)');
```
**Returns**: `["ABC"]`

```sql
SELECT
	REGEXP_MATCHES('Learning #Firebolt #REGEX', '#([A-Za-z0-9_]+)');
```
**Returns**: `["Firebolt", "REGEX"]`

####Example&ndash;using flags

The `i` flag causes the regular expression to be case insensitive. Without this flag, this query would only match and return `ABC`.

```sql
SELECT
	REGEXP_MATCHES('ABCdef', '^([A-Z]+)', 'i');
```

**Returns**: `["ABCdef"]`

The `U` flag causes metacharacters like `+` to return as few characters together as possible. Without this flag, this query would return `["PPL","P"]`.

```sql
SELECT
	REGEXP_MATCHES('aPPLePie', '([A-Z]+)', 'U');
```

**Returns**: `["P","P","L","P"]`


## REPEAT

This function repeats the provided string a requested number of times.

### Syntax
{: .no_toc}

```sql
REPEAT(<string>, <repeating_number>)
```

| Parameter            | Description                                                                                                    |
| :-------------------- | :-------------------------------------------------------------------------------------------------------------- |
| `<string>`           | The string to be repeated.                                                                                     |
| `<repeating_number>` | The number of needed repetitions. The minimum valid repeating number is `0`, which results in an empty string. |

### Example
{: .no_toc}

```sql
SELECT
	REPEAT('repeat 3 times ' , 3);
```

**Returns**: `repeat 3 times repeat 3 times repeat 3 times`

## REPLACE

Replaces all occurrences of the `<pattern>` substring within the `<string>` with the `<replacement>` substring.

### Syntax
{: .no_toc}

```sql
REPLACE (<string>, <pattern>, <replacement>)​
```

| Parameter       | Description                                                                                                                                                                                |
| :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `<string>`      | The original string that will be searched for instances of the `<pattern>`.                                                                                                                |
| `<pattern>`     | The substring to be searched and replaced in the string.                                                                                                                                   |
| `<replacement>` | The substring to replace the original substring defined by `<pattern>`. To remove the `<pattern>` substring with no replacement, you can use a empty string `''` as the replacement value. |

### Example
{: .no_toc}

In the example below, "hello" in "hello world" is replaced with "nice".

```sql
SELECT
	REPLACE('hello world','hello','nice') AS res;
```

**Returns**: `nice world`

In this example below, "world" is replaced by an empty string.

```sql
SELECT
	REPLACE('hello world',' world','') AS res;
```

**Returns**: `hello`

In this following example, the substring "hi" is not found in the original string, so the string is returned unchanged.

```sql
SELECT
	REPLACE('hello world','hi','something') AS res;
```

**Returns**: `hello world`

## REVERSE

This function returns a string of the same size as the original string, with the elements in reverse order.

### Syntax
{: .no_toc}

```sql
REVERSE(<string>)
```

| Parameter  | Description                |
| :---------- | :-------------------------- |
| `<string>` | The string to be reversed. |

### Example
{: .no_toc}

```sql
SELECT
	REVERSE('abcd') AS res
```

**Returns**: `'dcba'`

## RPAD

Adds a specified pad string to the end of the string repetitively up until the length of the resulting string is equivalent to an indicated length.

The similar function to pad the start of a string is [`LPAD`](string-functions.md#lpad).

### Syntax
{: .no_toc}

```sql
​​RPAD(<str>, <length>[, <pad>])​​
```

| Parameter  | Description                                                                                                                                                                                                                 |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<str>`    | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string. ​ `<str>` can be a literal string or the name of a column. |
| `<length>` | The integer length that the string will be after it has been left-padded. ​ A negative number returns an empty string.                                                                                                      |
| `<pad>`    | The string to add to the end of the primary string `<str>`. If left blank, `<pad>` defaults to whitespace characters.                                                                                                       |

### Example
{: .no_toc}

The following statement adds the string "ABC" to the end of the string "Firebolt" repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT
	RPAD('Firebolt', 20, 'ABC');
```

**Returns**: `FireboltABCABCABCABC`

## RTRIM

Removes all consecutive occurrences of common whitespace (ASCII character 32) from the end of a string. It doesn’t remove other kinds of whitespace characters (tab, no-break space, etc.).

### Syntax
{: .no_toc}

```sql
​​RTRIM(<target>)​​
```

| Parameter  | Description               |
| :---------- | :------------------------- |
| `<target>` | The string to be trimmed. |

### Example
{: .no_toc}

```sql
SELECT
	RTRIM('Hello, world!     ');
```

**Returns**: `Hello, world!`

## SPLIT

This function splits a given string by a given separator and returns the result in an array of strings.

### Syntax
{: .no_toc}

```sql
SPLIT( <delimiter>, <string> )
```

| Parameter     | Description                           |
| :------------- | :------------------------------------- |
| `<delimiter>` | The separator to split the string by. |
| `<string>`    | The string to split.                  |

### Example
{: .no_toc}

```sql
SELECT
	SPLIT('|','this|is|my|test') AS res;
```

**Returns**: `["this","is","my","test"]`

## SPLIT\_PART

Divides a string based on a specified delimiter into an array of substrings. ​ The string in the specified index is returned, with `1` being the first index. If the string separator is empty, the string is divided into an array of single characters.

### Syntax
{: .no_toc}

```sql
​​SPLIT_PART(<string>, <delimiter>, <index>)​​
```

{: .note}
Please note that the order of the arguments is different than the `SPLIT` function.

| Parameter     | Description                                                                                                                                    |
| :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>`    | An expression evaluating to a string to be split.                                                                                              |
| `<delimiter>` | Any character or substring within `<string>`. If `<delimiter>` is an empty string `''`, the `<string>` will be divided into single characters. |
| `<index>`     | The index from which to return the substring.                                                                                                  |

### Example
{: .no_toc}

```sql
SELECT
	SPLIT_PART('hello#world','#',1) AS res;
```

**Returns**: `hello`

```sql
SELECT
	SPLIT_PART('this|is|my|test', '|', 4 ) AS res;
```

**Returns**: `test`

```sql
SELECT
	SPLIT_PART('hello world', '', 7 ) AS res;
```

**Returns**: `w`

## STRPOS

Returns the position (in bytes) of the substring found in the string, starting from 1. The returned value is for the first matching value, and not for any subsequent valid matches.

### Syntax
{: .no_toc}

```sql
​​STRPOS(<string>, <substring>)​​
```

| Parameter     | Description                         |
| :------------- | :----------------------------------- |
| `<string>`    | The string that will be searched. |
| `<substring>` | The substring to search for.        |

### Example
{: .no_toc}

```sql
SELECT
	STRPOS('hello world','hello') AS res;
```

**Returns**: `1`

```sql
SELECT
	STRPOS('hello world','world') AS res;
```

**Returns**: `7`

## SUBSTR

Returns a substring starting at the character indicated by the `<offset>` index and including the number of characters defined by the `<length>`. Character indexing starts from index 1. The `<offset>` and `<length>` arguments must be constants.

### Syntax
{: .no_toc}

```sql
SUBSTR(<string>, <offset> [, <length>])
```

| Parameter  | Description                                                                                                                                                                       |
| :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<string>` | The string to be offset.                                                                                                                                                          |
| `<offset>` | The starting position for the substring. 1 is the first character.                                                                                                                |
| `<length>` | Optional. The number of characters to be returned by the `SUBSTR` function. If left blank, `length` by default returns all of the string not specified by the `offset` parameter. |

### Example
{: .no_toc}

In the example below, the string is offset by 1 and so the `SUBSTR` command begins at the first letter, "h". The `<length>` of 5 indicates the resulting string should be only five characters long.

```sql
SELECT
	SUBSTR('hello world', 1, 5);
```

**Returns**: `hello`

In this next example, there is no `<length>` provided. This means all characters are included after the `<offset>` index, which is 7.

```sql
SELECT
	SUBSTR('hello world', 7);
```

**Returns**: `world`

## TO\_DATE

Converts a string to `DATE` type.

### Syntax
{: .no_toc}

```sql
​​TO_DATE(<string>)​​
```

| Parameter  | Description                                                                |
| :---------- | :-------------------------------------------------------------------------- |
| `<string>` | The string to convert to a date. The string format should be: ‘YYYY-MM-DD’ |

### Example
{: .no_toc}

```sql
SELECT
	TO_DATE('2020-05-31') AS res;
```

**Returns**: `2020-05-31`

## TO\_DOUBLE

Converts a string to a numeric `DOUBLE` data type.

### Syntax
{: .no_toc}

```sql
TO_DOUBLE(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

### Example
{: .no_toc}

```sql
SELECT
	TO_DOUBLE('100');
```

**Returns**: `100`

## TO\_FLOAT

Converts a string to a numeric `FLOAT` data type.

### Syntax
{: .no_toc}

```sql
TO_FLOAT(<expr>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

### Example
{: .no_toc}

```sql
SELECT
	TO_FLOAT('10.5');
```

**Returns**: `10.5`

## TO\_INT

Converts a string to a numeric `INT` data type.

### Syntax
{: .no_toc}

```sql
TO_INT(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

### Example
{: .no_toc}

```sql
SELECT
	TO_INT('10');
```

**Returns**: `10`

## TO\_LONG

Converts a string to a numeric `LONG` data type.

### Syntax
{: .no_toc}

```sql
TO_LONG(<exp>)
```

| Parameter | Description                                                                                              |
| :--------- | :-------------------------------------------------------------------------------------------------------- |
| `<expr>`  | Any numeric data types or numeric characters that resolve to a `VARCHAR`, `TEXT`, or `STRING` data type. |

### Example
{: .no_toc}

```sql
SELECT
	TO_LONG('1234567890');
```

**Returns**: `1234567890`

## TO\_TIMESTAMP

Converts a string to timestamp.

### Syntax
{: .no_toc}

```sql
​​TO_TIMESTAMP(<string>)​​
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

### Example
{: .no_toc}

```sql
SELECT
	TO_TIMESTAMP('2020-05-31 10:31:14') AS res;
```

**Returns**: `2020-05-31 10:31:14`

## TO\_UNIX\_TIMESTAMP

Converts a string to a UNIX timestamp.

### Syntax
{: .no_toc}

```sql
​​TO_UNIX_TIMESTAMP(<string>)​​
```

| Parameter  | Description                                        |
| :---------- | :-------------------------------------------------- |
| `<string>` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

### Example
{: .no_toc}

```sql
SELECT
	TO_UNIX_TIMESTAMP('2017-11-05 08:07:47');
```

**Returns**: `1509869267`

## TO\_UNIXTIME

For ​`DATETIME` ​​arguments: this function converts the value to its internal numeric representation (Unix Timestamp). ​ For ​`TEXT` ​​arguments: this function parses ​`DATETIME` ​​from a string and returns the corresponding Unix timestamp.

### Syntax
{: .no_toc}

```sql
​​TO_UNIXTIME(<string>)​​
```

| Parameter  | Description                 |
| :---------- | :--------------------------- |
| `<string>` | The string to be converted. |

### Example
{: .no_toc}

```sql
SELECT
	TO_UNIXTIME('2017-11-05 08:07:47') AS TO_UNIXTIME;
```

**Returns**: `1509869267`

## TRIM

Removes all specified characters from the start, end, or both sides of a string. By default removes all consecutive occurrences of common whitespace (ASCII character 32) from both ends of a string.

### Syntax
{: .no_toc}

```sql
​​TRIM( [LEADING | TRAILING | BOTH] <trim_character> FROM <target_string>)​​
```

| Parameter                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ```[ LEADING | TRAILING | BOTH ]``` | Specifies which part or parts of the `<target_string>` to remove the defined `<trim_character>`. If unspecified, this defaults to `BOTH`.<br><br>`LEADING` - trims from the beginning of the specified string<br><br>`TRAILING` - trims from the end of the specified string. <br><br>`BOTH` - trims from the beginning and the end of the specified string. |
| `<trim_character>`                | The characters to be removed.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `<target_string>`                 | The string to be trimmed.                                                                                                                                                                                                                                                                                                                                                                                                                             |

### Example
{: .no_toc}

In the example below, no part of the string is specified for `TRIM`, so it defaults to `BOTH`.

```sql
SELECT
	TRIM('$' FROM '$Hello world$') AS res;
```

**Returns**: `Hello world`

This next example trims only from the start of the string because the `LEADING` parameter is specified.

```
SELECT
	TRIM( LEADING '$' FROM '$Hello world$') AS res;
```

**Returns**: `Hello world$`

## UPPER

Converts the string to uppercase format.

### Syntax
{: .no_toc}

```sql
​​UPPER(<string>)​​
```

| Parameter  | Description                                             |
| :---------- | :------------------------------------------------------- |
| `<string>` | The string to be converted to all uppercase characters. |

### Example
{: .no_toc}

```sql
SELECT
	UPPER('hello world')
```

**Returns**: `HELLO WORLD`
