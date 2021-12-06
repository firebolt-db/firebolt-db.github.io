# Date and time functions

This page describes the date and time functions and [format expressions](date-and-time-functions.md#date-format-expressions) supported in Firebolt.

## CURRENT\_DATE

Returns the current date.

**Syntax**

```sql
​​CURRENT_DATE()​​
```

## NOW

Returns the current date and time.

**Syntax**

```sql
​​NOW()​​
```

## TIMEZONE

Accepts zero arguments and returns the current timezone of request execution

**Syntax**

```sql
​​TIMEZONE()​​
```

## TO\_STRING

Converts a date into a STRING. The date is any [date data type​​](../general-reference/some-page.md).

**Syntax**

```sql
TO_STRING(date)
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date to be converted to a string. |

**Usage example**

```sql
SELECT TO_STRING(NOW());
```

This que**r**y returns today's date and the current time similar to the following: ​ 2022-10-10 22:22:33

## DATE\_ADD

Calculates a new date based on the specified unit, interval, and indicated date.

**Syntax**

```sql
​​DATE_ADD(unit, interval, date_expr)​​
```

| Parameter | Description |
| :--- | :--- |
| `unit` | A valid unit is SECOND \| MINUTE \| HOUR \| DAY \| WEEK \| YEAR \| EPOCH |
| `interval` | The number of times to increase the ​`date_expr​​`. |

**Usage example**

```sql
SELECT DATE_ADD('WEEK', 15, CAST ('2017-06-15 09:34:21' AS DATETIME));
```

Returns: 2017-09-28 09:34:21

## FROM\_UNIXTIME

Convert Unix time \(LONG in epoch seconds\) to DATETIME \(YYYY-MM-DD HH:mm:ss\).

**Syntax**

```sql
​​FROM_UNIXTIME(unix_time)​​
```

| Parameter | Description |
| :--- | :--- |
| `unix_time` | The UNIX epoch time that is to be converted. |

**Usage example**

```sql
SELECT FROM_UNIXTIME(1493971667);
```

Returns: 2017-05-05 08:07:47

## DATE\_DIFF

Difference between ​​`start_date`​​ and ​`end_date`​​ expressed in the indicated ​unit​​.

**Syntax**

```sql
​​DATE_DIFF(unit, start_date, end_date)​​
```

| Parameter | Description |
| :--- | :--- |
| `unit` | Time unit, in which the returned value is to be expressed \(String\). ​  Supported values: second \| minute \| hour \| day \| week \| month \| quarter \| year \|. |
| `start_date` | The first time \(in `DATE` or `DATETIME` format\) value to be used to calculate the difference. |
| `end_date` | The last time \(in `DATE` or `DATETIME` format\) value to be used to calculate the difference. |

**Usage examples**

```sql
SELECT DATE_DIFF('hour', CAST('2020/08/31 10:00:00' AS DATETIME), CAST('2020/08/31 11:00:00' AS DATETIME));
```

Returns: 1

```sql
SELECT DATE_DIFF('day', CAST('2020/08/31 10:00:00' AS DATETIME), CAST('2020/08/31 11:00:00' AS DATETIME));
```

Returns: 0

## DATE\_TRUNC

Truncate a given date to a specified position.

**Syntax**

```sql
​​DATE_TRUNC(precision, date)​​
```

| Parameter | Description |
| :--- | :--- |
| `precision` | Time unit, in which the returned value is to be expressed \(String\). ​  Supported values: second \| minute \| hour \| day \| week \| month \| quarter \| year \|. |
| `date` | The date which needs to be truncated \(DATE or DATETIME\) |

**Usage example**

```sql
SELECT DATE_TRUNC('minute', CAST('2020/08/31 10:31:36' AS TIMESTAMP));
```

Returns: 2020-08-31 10:31:00

## DATE\_FORMAT

Formats a ​`DATE` ​​or ​`DATETIME` ​​according to the given format expression.

**Syntax**

```sql
​​DATE_FORMAT(date, format)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date to be formatted |
| `format` | The format to be used for the output. Formats are described ​[here​​](date-and-time-functions.md#date-format-expressions). |

**Usage example**

```sql
SELECT DATE_FORMAT(CAST('2020/08/31 10:33:44' AS DATETIME), '%Y-%m-%d') as res;
```

Returns: 2020-08-31

## EXTRACT

Retrieves subfields such as year or hour from date/time values.

**Syntax**

```sql
​​EXTRACT(field FROM source)​​
```

| Parameter | Description |
| :--- | :--- |
| `field` | Supported fields: DAY \| MONTH \| YEAR \| HOUR \| MINUTE \| SECOND \| EPOCH |
| `source` | A value expression of type timestamp. |

**Usage example**

```text
SELECT EXTRACT(YEAR FROM TIMESTAMP '2020-01-01 10:00:00') AS res;
```

Returns: 2020

## TO\_YEAR

Converts a date or timestamp \(any date format we support\) to a number containing the year.

**Syntax**

```sql
​​TO_YEAR(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the year. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 1975

## TO\_QUARTER

Converts a date or timestamp \(any date format we support\) to a number containing the quarter.

**Syntax**

```sql
​​TO_QUARTER(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the quarter. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_QUARTER(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 2

## TO\_MONTH

Converts a date or timestamp \(any date format we support\) to a number containing the month.

**Syntax**

```sql
​​TO_MONTH(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the month. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_MONTH(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 4

## TO\_WEEK

Converts a date or timestamp \(any date format we support\) to a number containing the week.

**Syntax**

```sql
​​TO_WEEK(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the week. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_WEEK(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 16

## TO\_DAY\_OF\_WEEK

Converts a date or timestamp \(any date format we support\) to a number containing the number of the day of the week \(Monday is 1, and Sunday is 7\).

**Syntax**

```sql
​​TO_DAY_OF_WEEK(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the day of the week. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_DAY_OF_WEEK(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 2

## TO\_DAY\_OF\_YEAR

Converts a date or timestamp \(any date format we support\) to a number containing the number of the day of the year.

**Syntax**

```sql
​​TO_DAY_OF_YEAR(date)​​
```

| Parameter | Description |
| :--- | :--- |
| `date` | The date or timestamp to be converted into the number of the day of the year. |

**Usage example**

For Tuesday, April 22, 1975:

```sql
SELECT TO_DAY_OF_YEAR(CAST('1975/04/22' AS DATE)) as res;
```

Returns: 112

## TO\_HOUR

Converts a timestamp \(any date format we support\) to a number containing the hour.

**Syntax**

```sql
​​TO_HOUR(timestamp)​​
```

| Parameter | Description |
| :--- | :--- |
| `timestamp` | The timestamp to be converted into the number of the hour. |

**Usage example**

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_HOUR(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

Returns: 12

## TO\_MINUTE

Converts a timestamp \(any date format we support\) to a number containing the minute.

**Syntax**

```sql
​​TO_MINUTE(timestamp)​​
```

| Parameter | Description |
| :--- | :--- |
| `timestamp` | The timestamp to be converted into the number of the minute. |

**Usage example**

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_MINUTE(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

Returns: 20

## TO\_SECOND

Converts a timestamp \(any date format we support\) to a number containing the second.

**Syntax**

```sql
​​TO_SECOND(timestamp)​​
```

| Parameter | Description |
| :--- | :--- |
| `timestamp` | The timestamp to be converted into the number of the second. |

**Usage example**

For Tuesday, April 22, 1975 at 12:20:05:

```sql
SELECT TO_SECOND(CAST('1975/04/22 12:20:05' AS TIMESTAMP)) as res;
```

Returns: 5

## Date format expressions

The following table details the supported constant expression format syntax options for the `DATE_FORMAT` function.

<table>
  <thead>
    <tr>
      <th style="text-align:left">Expression</th>
      <th style="text-align:left">Description</th>
      <th style="text-align:left">Examples for Tuesday the 2nd of April, 1975 at 12:24:48:13 past midnight</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>%C</code>
      </td>
      <td style="text-align:left">The year divided by 100 and truncated to integer (00-99)</td>
      <td style="text-align:left">19</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%d</code>
      </td>
      <td style="text-align:left">Day of the month, zero-padded (01-31)</td>
      <td style="text-align:left">02</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%D</code>
      </td>
      <td style="text-align:left">Short MM/DD/YY date, equivalent to %m/%d/%y</td>
      <td style="text-align:left">04/02/75</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%e</code>
      </td>
      <td style="text-align:left">Day of the month, space-padded ( 1-31)</td>
      <td style="text-align:left">2</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%F</code>
      </td>
      <td style="text-align:left">Short YYYY-MM-DD date, equivalent to %Y-%m-%d</td>
      <td style="text-align:left">1975-04-02</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%H</code>
      </td>
      <td style="text-align:left">The hour in 24h format (00-23)</td>
      <td style="text-align:left">00</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%I</code>
      </td>
      <td style="text-align:left">The hour in 12h format (01-12)</td>
      <td style="text-align:left">12</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%j</code>
      </td>
      <td style="text-align:left">Day of the year (001-366)</td>
      <td style="text-align:left">112</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%m</code>
      </td>
      <td style="text-align:left">month as a decimal number (01-12)</td>
      <td style="text-align:left">04</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%M</code>
      </td>
      <td style="text-align:left">minute (00-59)</td>
      <td style="text-align:left">24</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%n</code>
      </td>
      <td style="text-align:left">new-line character (&#x2018;&#x2019;) in order to add a new line in the
        converted format.</td>
      <td style="text-align:left">
        <p>Returns:</p>
        <p>1975</p>
        <p>04</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%p</code>
      </td>
      <td style="text-align:left">AM or PM designation</td>
      <td style="text-align:left">PM</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%R</code>
      </td>
      <td style="text-align:left">24-hour HH:MM time, equivalent to %H:%M</td>
      <td style="text-align:left">00:24</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%S</code>
      </td>
      <td style="text-align:left">The second (00-59)</td>
      <td style="text-align:left">48</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%T</code>
      </td>
      <td style="text-align:left">ISO 8601 time format (HH:MM:SS), equivalent to %H:%M:%S</td>
      <td style="text-align:left">00:24:48</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%u</code>
      </td>
      <td style="text-align:left">ISO 8601 weekday as number with Monday as 1 (1-7)</td>
      <td style="text-align:left">2</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%V</code>
      </td>
      <td style="text-align:left">ISO 8601 week number (01-53)</td>
      <td style="text-align:left">17</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%w</code>
      </td>
      <td style="text-align:left">weekday as a decimal number with Sunday as 0 (0-6)</td>
      <td style="text-align:left">2</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%y</code>
      </td>
      <td style="text-align:left">Year, last two digits (00-99)</td>
      <td style="text-align:left">75</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%Y</code>
      </td>
      <td style="text-align:left">Year</td>
      <td style="text-align:left">1975</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>%%</code>
      </td>
      <td style="text-align:left">a % sign</td>
      <td style="text-align:left">%</td>
    </tr>
  </tbody>
</table>

