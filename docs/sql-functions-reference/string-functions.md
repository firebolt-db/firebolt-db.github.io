# String functions

This page describes the string functions supported in Firebolt.

## SUBSTR

Returns a substring starting with the byte from the ‘offset’ index and ‘length’ bytes long.  
Character indexing starts from index 1 \(as in standard SQL\). The ‘offset’ and ‘length’ arguments must be constants.

**Syntax**

```sql
SUBSTR(s, offset, length)
```

| Parameter | Description |
| :--- | :--- |
| `s` | The string to be offset. |
| `offset` | Count left to right the number of characters to offset from and not include in the results. 1 indicates starting with the first character. |
| `length` | The total amount of characters included in the returned result. |

**Usage** **example**

```sql
SELECT SUBSTR('hello world', 1, 5);
```

The string is offset by 1 and so begins with "h". 5 indicates the resulting string should be only five characters long.

Returns: hello

## CONCAT

Concatenates the strings listed in the arguments, without a separator.

**Syntax**

```sql
CONCAT(s1,s2,…);
```

Or

```sql
S1 || S2 || S3
```

| Parameter | Description |
| :--- | :--- |
| `s` | The strings, to be concatenated. |

**Usage** **example**

```sql
SELECT concat('Hello, ', 'World!')
```

Returns: Hello World!

## REPLACE

Replaces all occurrences of the ‘pattern’ substring of the ‘haystack’ string with the ‘replacement’ substring.

**Syntax**

```sql
REPLACE (haystack, pattern, replacement)​
```

| Parameter | Description |
| :--- | :--- |
| `haystack` | The entire original string |
| `pattern` | The substring to be searched and replaced in the string. |
| `replacement` | The substring to replace the original substring \(the 'pattern'\). |

**Usage examples**

```sql
SELECT REPLACE('hello world','hello','nice') AS res;
```

Returns:'nice world'

```sql
SELECT REPLACE('hello world',' world','') AS res;
```

Returns: 'hello'

```sql
SELECT REPLACE('hello world','hi','something') AS res;
```

Returns: 'hello world'

String functions

## REGEXP\_LIKE

This function holds a regular expression, used to check whether a pattern matches the regular expression string. Returns 0 if it doesn’t match, or 1 if it matches. ​ This is a ​​re2​​ regular expression.

**Syntax**

```sql
​REGEXP_LIKE(haystack, pattern)​​
```

| Parameter | Description |
| :--- | :--- |
| `haystack` | The string in which to search for a match.pattern |
| `pattern` | The pattern with which to search for a match in the string. |

**Usage examples**

```sql
​​SELECT REGEXP_LIKE('123','\\[a-z]') AS res;​​
```

Returns: 0

```sql
SELECT REGEXP_LIKE('123','\\d+') AS res;​
```

Returns: 1

## STRPOS

Returns the position \(in bytes\) of the substring found in the string, starting from 1.

**Syntax**

```sql
​​STRPOS(haystack, needle)​​
```

| Parameter | Description |
| :--- | :--- |
| `haystack` | The string in which to search for the needle. |
| `needle` | The substring to be searched for. |

**Usage examples**

```sql
SELECT STRPOS('hello world','hello') AS res
```

Returns: 1

```sql
SELECT STRPOS('hello world','world') AS res
```

Returns: 7

## TRIM

Removes all specified characters from the start or end of a string. By default removes all consecutive occurrences of common whitespace \(ASCII character 32\) from both ends of a string.

**Syntax**

```sql
​​TRIM([LEADING|TRAILING|default = BOTH] <trim_character> FROM <target_string>)​​
```

| Parameter | Description |
| :--- | :--- |
| `LEADING` | Removes all special characters from the beginning of the specified string. |
| `TRAILING` | Removes all special characters from the end of the specified string. |
| `BOTH` | Removes all special characters from the beginning and the end of the specified string. |
| `trim_character` | The characters to be removed. |
| `target_string` | The string to be trimmed. |

**Usage example**

```sql
SELECT TRIM('$' FROM '$Hello world$') AS res;
```

Returns: ‘ Hello world’

## LTRIM

Removes all consecutive occurrences of common whitespace \(ASCII character 32\) from the beginning of a string. It doesn’t remove other kinds of whitespace characters \(tab, no-break space, etc.\).

**Syntax**

```sql
​​LTRIM(<target>)​​
```

| Parameter | Description |
| :--- | :--- |
| `target` | The string to be trimmed. |

**Usage example**

```sql
SELECT LTRIM('     Hello, world! ')
```

Returns: Hello, world!

## RTRIM

Removes all consecutive occurrences of common whitespace \(ASCII character 32\) from the end of a string. It doesn’t remove other kinds of whitespace characters \(tab, no-break space, etc.\).

**Syntax**

```sql
​​RTRIM(<target>)​​
```

| Parameter | Description |
| :--- | :--- |
| `target` | The string to be trimmed. |

**Usage example**

```sql
SELECT RTRIM('Hello, world!     ')
```

Returns: Hello, world!

## BTRIM

Removes all consecutive occurrences of common whitespace \(ASCII character 32\) from the beginning and the end of a string. It doesn’t remove other kinds of whitespace characters \(tab, no-break space, etc\).

**Syntax**

```sql
​​BTRIM(<target>)​​
```

| Parameter | Description |
| :--- | :--- |
| `target` | The string to be trimmed. |

**Usage example**

```sql
SELECT BTRIM('Hello, world!     ')
```

Returns: Hello, world!

## LPAD

Adds the pad in front of the string repetitively up until the length of the resulting string is equivalent to the indicated length.

**Syntax**

```sql
​​LPAD(<str>, <length> [, <pad>])​​
```

| Parameter | Description |
| :--- | :--- |
| `str` | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string. ​ str can be a literal string or the name of a column. |
| `length` | The length of the string as an integer after it has been left-padded. ​ A negative number returns an empty string. |
| `pad` | The string to left-pad to primary string \(str\). |

**Usage example**

The following statement adds the string ABC in front of the string Firebolt repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT LPAD("Firebolt", 20, "ABC");
```

Returns: ABCABCABCABCFirebolt

## RPAD

Adds the pad at the end of the string repetitively up until the length of the resulting string is equivalent to the indicated length.

**Syntax**

```sql
​​RPAD(<str>, <length> [, <pad>])​​
```

| Parameter | Description |
| :--- | :--- |
| `str` | The original string. If the length of the original string is larger than the length parameter, this function removes the overflowing characters from the string. ​ str can be a literal string or the name of a column. |
| `length` | The length of the string as an integer after it has been left-padded. ​ A negative number returns an empty string. |
| `pad` | The string to right-pad to primary string \(str\). |

**Usage example**

The following statement adds the string ABC to the end of the string Firebolt repetitively until the resulting string is equivalent to 20 characters in length.

```sql
SELECT RPAD("Firebolt", 20, "ABC");
```

Returns: FireboltABCABCABCABC

## TO\_DATE

Converts a string to date.

**Syntax**

```sql
​​TO_DATE(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string format should be: ‘YYYY-MM-DD’ |

**Usage example**

```sql
SELECT TO_DATE('2020-05-31') AS res;
```

Returns: 2020-05-31

## TO\_TIMESTAMP

Converts a string to timestamp.

**Syntax**

```sql
​​TO_TIMESTAMP(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

**Usage example**

```sql
SELECT TO_TIMESTAMP('2020-05-31 10:31:14') AS res;
```

Returns: 2020-05-31 10:31:14

## TO\_UNIX\_TIMESTAMP

Converts a string to a UNIX timestamp.

**Syntax**

```sql
​​TO_UNIX_TIMESTAMP(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string format should be: ‘YYYY-MM-DD HH:mm:ss’ |

**Usage example**

```sql
SELECT TO_UNIX_TIMESTAMP('2020-05-31') AS res;
```

## MD5

Calculates the MD5 hash of string, returning the result as a string in hexadecimal.

**Syntax**

```sql
​​MD5(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to hash. For NULL, the function returns 0. |

**Usage examples**

```sql
SELECT MD5('text') AS res;
```

Returns: 1cb251ec0d568de6a929b520c4aed8d1

## MD5\_NUMBER\_UPPER64

Represent the upper 64 bits of the MD5 hash value of the input string as BIGINT.

**Syntax**

```sql
​​MD5_NUMBER_UPPER64('string')​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to calculate the MD5 on and represent as BIGINT |

**Usage examples**

```sql
SELECT MD5_NUMBER_UPPER64('test') AS res;
```

Returns: 688887797400064883

## MD5\_NUMBER\_LOWER64

Represent the lower 64 bits of the MD5 hash value of the input string as BIGINT.

**Syntax**

```sql
​​MD5_NUMBER_LOWER64('string')​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to calculate the MD5 on and represent as BIGINT |

**Usage examples**

```sql
SELECT MD5_NUMBER_LOWER64('test') AS res;
```

Returns: 14618207765679027446

## MATCH

Checks whether the string matches the regular expression pattern. A re2 regular expression. ​ Returns 0 if it doesn’t match, or 1 if it matches.

**Syntax**

```sql
​​MATCH(haystack, pattern)​​
```

| Parameter | Description |
| :--- | :--- |
| `haystack` | The string in which to search for a match. |
| `pattern` | The pattern with which to search for a match in the string. |

**Usage examples**

```sql
SELECT MATCH('123','\\[a-Z|A-Z]') AS res;
```

Returns: 0

```sql
SELECT MATCH('123','\\d+');
```

Returns: 1

## MATCH\_ANY

The same as [MATCH](string-functions.md#match), but returns 0 if none of the regular expressions are matched and 1 if any of the patterns matches.

**Syntax**

```sql
​​MATCH_ANY(haystack, [pattern1, pattern2, …, pattern])​​
```

| Parameter | Description |
| :--- | :--- |
| `haystack` | The string in which to search for a match. |
| `pattern` | The pattern with which to search for a match in the string. |

**Usage examples**

```sql
SELECT MATCH_ANY('123',['\\d+','\\[a-Z|A-Z]']) AS res;
```

The above query searches for any matches within the string ​`123` ​​to the pattern `​['\d+','\[a-Z|A-Z]']`​. ​ Since at least one is found, returns: 1

## SPLIT\_PART

Divides a string into substrings separated by a constant string delimiter of multiple characters as the separator. ​ The string in the specified index is returned. If the string separator is empty, the string is divided into an array of single characters.

**Syntax**

```sql
​​SPLIT_PART(string, delimiter, index)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be split. |
| `delimiter` | Any string within a string |
| `index` | Indicates the index from where to start searching for matches. |

**Usage examples**

```sql
SELECT SPLIT_PART('hello#world','#',1) AS res;
```

Returns: ‘hello’

## TO\_UNIXTIME

For ​`DATETIME` ​​arguments: this function converts the value to its internal numeric representation \(Unix Timestamp\). ​ For ​`TEXT` ​​arguments: this function parses ​`DATETIME` ​​from a string and returns the corresponding Unix timestamp.

**Syntax**

```sql
​​TO_UNIXTIME(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be converted. |

**Usage examples**

```sql
SELECT TO_UNIXTIME('2017-11-05 08:07:47'') AS TO_UNIXTIME;
```

Returns: 1509836867

## LENGTH

Calculates the String length.

**Syntax**

```sql
​​LENGTH(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string for which to return the length. |

**Usage examples**

```sql
SELECT LENGTH('abcd') AS length;
```

Returns: 4

## UPPER

Converts the string to upper case format.

**Syntax**

```sql
​​UPPER(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be converted. |

## LOWER

Converts the string to a lower case format.

**Syntax**

```sql
​​LOWER(string)​​
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be converted. |

## UUID\_GENERATE\_V4

This function can be used to generate a random unique numeric value for any object in the database.

**Syntax**

```sql
​​UUID_GENERATE_V4()​​
```

## **REVERSE**

This function returns a string of the same size as the original string, with the elements in reverse order.

**Syntax**

```sql
REVERSE(string)
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be reversed. |

**Usage Example**

```sql
SELECT REVERSE('abcd') AS res
```

Returns: 'dcba'

## **SPLIT**

This function splits a given string by a given separator and returns the result in an array of strings.

**Syntax**

```sql
SPLIT('seperator',string)
```

| Parameter | Description |
| :--- | :--- |
| `seperator` | The separator to split the string by. |
| `string` | The string to split. |

**Usage Example**

```sql
SELECT SPLIT('|','this|is|my|test') AS res
```

Returns: \["this","is","my","test"\]

## **REPEAT**

This function repeats the provided string a requested number of times.

**Syntax**

```sql
REPEAT('string',repeating_number)
```

| Parameter | Description |
| :--- | :--- |
| `string` | The string to be repeated. |
| `repeating number` | The number of needed repetitions. |

**Usage Example**

```sql
SELECT REPEAT(‘repeat 3 times ’,3);
```

Returns: 'repeat 3 times repeat 3 times repeat 3 times '

