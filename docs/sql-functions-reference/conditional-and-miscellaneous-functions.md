# Conditional and miscellaneous functions

This page describes the conditional and miscellaneous functions supported in Firebolt.

## COALESCE

Checks from left to right for the first non-NULL argument found for each entry parameter pair. For example, for an Employee table \(where each employee can have more than one location\), check multiple location parameters, find the first non-null pair per employee \(the first location with data per employee\).

**Syntax**

```sql
​​COALESCE(value,…)
```

| Parameter | Description |
| :--- | :--- |
| value | The value\(s\) to coalesce. Can be either: column name, ​ ​a function applied on a column \(or on another function\), and a literal \(constant value\). |

**Usage example**

```sql
SELECT COALESCE(null, "London","New York") AS res;
```

Returns: London

## CAST

Converts data types into other data types based on the specified parameters.

**Syntax**

```sql
CAST(value AS type)
```

<table>
  <thead>
    <tr>
      <th style="text-align:left">Parameter</th>
      <th style="text-align:left">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>value</code>
      </td>
      <td style="text-align:left">
        <p>The original value to be converted or an expression that translates into
          the original value.</p>
        <p>Can be either:&#x200B; &#x200B;column name, &#x200B; &#x200B;a function
          applied on a column (or on another function), and a literal (constant value).</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>type</code>
      </td>
      <td style="text-align:left">The target <a href="../general-reference/some-page.md">data type</a> (case-insensitive).</td>
    </tr>
  </tbody>
</table>

**Usage example**

```sql
SELECT CAST('1' AS INT) as res;
```

Returns: 1

## CASE

The CASE expression is a conditional expression similar to if-then-else statements.  
If the result of the condition is true then the value of the CASE expression is the result that follows the condition. ​ If the result is false any subsequent WHEN clauses \(conditions\) are searched in the same manner. ​ If no WHEN condition is true then the value of the case expression is the result specified in the ELSE clause. ​ If the ELSE clause is omitted and no condition matches, the result is null.

**Syntax**

```sql
CASE 
    WHEN condition THEN result 
    [WHEN ...] 
    [ELSE result]
END;
```

| Parameter | Description |
| :--- | :--- |
| `condition` | An expression that returns a boolean result. ​ A condition can be defined for each WHEN, and ELSE clause. |
| `result` | The result of any condition. Every ​`THEN` ​​clause receives a single result. All results in a single ​`CASE` ​​function must share the same data type. |

**Usage example**

In a table listing movies by title and length, the following query categorizes each entry by length. If the movie is longer than zero minutes and less than 50 minutes it is categorized as SHORT. When the length is 50-120 minutes, it's categorized as Medium, and when even longer, it's categorized as Long.

```sql
SELECT
   title,
   length,
   CASE
      WHEN
         length > 0 
         AND length <= 50 
      THEN
         'Short' 
      WHEN
         length > 50 
         AND length <= 120 
      THEN
         'Medium' 
      WHEN
         length > 120 
      THEN
         'Long' 
   END
   duration 
FROM
   film 
ORDER BY
   title;
```

