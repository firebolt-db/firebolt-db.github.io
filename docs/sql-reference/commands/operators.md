---
layout: default
title: Operators
nav_order: 2
parent: SQL commands reference
---

# Operators

This section describes the operators supported in Firebolt.

## Arithmetic

{: .note}
> Precision means that representation of a number is guaranteed to be accurate up to X number digits. In Firebolt, calculations are 6 digits accurate for `FLOAT` numbers and 15 for `DOUBLE PRECISION`. This means that calculations have a precision of 6 or 15 respectively and numbers  are truncated to that precision. For example, if a number is stored as 1.234567, it is automatically truncated to 1.23456 for `FLOAT`.
>
> When performing arithmetic, the number of leading digits in the output is the product of the leading digits in both inputs. This means that if either or both of the input numbers are larger than 6, then those numbers are first truncated and then the arithmetic is performed.

| Operator | Operator description                             | Example             | Result |
| :-------- | :------------------------------------------------ | :------------------- | :------ |
| +        | addition                                         | `SELECT 2 + 3;`     | 5      |
| -        | subtraction                                      | `SELECT 2 - 3;`     | -1     |
| \*       | multiplication                                   | `SELECT 2 * 3;`     | 6      |
| /        | division (integer division truncates the result) | `SELECT 4 / 2;`     | 2      |
| %        | modulo (remainder)                               | `SELECT 5 % 4;`     | 1      |
| ^        | exponentiation                                   | `SELECT 2.0 ^ 3.0;` | 8      |

## Comparison

Comparison operators are usually implemented with `WHERE` clauses.

```sql
SELECT * FROM Table_Name
WHERE Price >= Number;
```

| Operator | Example | Explanation                      |
| :-------- | :------- | :-------------------------------- |
| =        | `a=b`   | a is equal to b.                 |
| <=       | `a<=b`  | a is less than or equal to b.    |
| !=       | `a!=b`  | a is not equal to b.             |
| <>       | `a<>b`  | a is not equal to b.             |
| >        | `a>b`   | a is greater than b.             |
| >=       | `a>=b`  | a is greater than or equal to b. |
| <        | `a<b`   | a is less than b.                |

Comparison operators are typically used in the `WHERE` clause of a query.

## Strings

To concatenate strings, you can use the `CONCAT` function.

```sql
SELECT concat('This', ' is', ' a', ' parenthetical', 'concantenation.') AS Concatenated_String
```

Alternatively, you can use the double pipe || operator.

```sql
SELECT 'This' || ' is' || ' a' || ' double pipe' || ' concantenation.' AS Concatenated_String
```

## Boolean

Boolean operators return the result of a Boolean operation between one or more expressions.

| Operator | Example   | Explanation                   |
| :-------- | :--------- | :----------------------------- |
| AND      | `x AND y` | True if both x and y are true |
| NOT      | `NOT x`   | True if x is false            |
| X OR Y   | `x OR y`  | True if either x or y is true |

## Date and time

### Interval

Use the interval operator to add or subtract a period of time to/from a `DATE`, `TIME`, or `TIMESTAMP`. &#x20;

**Syntax**

```sql
{ +|- } INTERVAL '<quantity> [ <date_unit> ] [ ...]'
```

|               |                                                                                                                                                                                                                                                             |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Component     | Description                                                                                                                                                                                                                                                 |
| `<quantity>`  | An integer. Multiple `<quantities>` and `<date_units>` can be used in the same `INTERVAL` command if they are separated by spaces.                                                                                                                          |
| `<date_unit>` | A date measurement including any of the following: `millennium`, `century`, `decade`, `year`, `month`, `week`, `day`, `hour`, `minute`, `second`, `millisecond`, `microsecond `or their plural forms.  If unspecified, `<date_unit>` defaults to `second`.  |



**Usage example**

```sql
<date_column> + INTERVAL '1 year 2 months 3 days'
<date_column> - INTERVAL '2 weeks'
<date_column> - INTERVAL '1 year 3 hours 20 minutes'
```

## Cast operator

Values can be converted from one [data type](../../general-reference/data-types.md) to another by using the [`CAST`](../functions-reference/conditional-and-miscellaneous-functions.md#cast) function or the `::` operator.&#x20;

**Syntax**

```sql
 -- CAST function
 CAST(<value> AS <type>)
 -- :: operator
 <value>::<type>
```

|           |                                                                                                                                                                            |
| :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Component | Description                                                                                                                                                                |
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name, ​ ​a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](../../general-reference/data-types.md) (case-insensitive).                                                                                                               |

**Usage example**

```sql
SELECT '2021-12-31'::DATE;
SELECT 8.5::FLOAT;
SELECT col_a::BIGINT;
```

## Subquery

Subqueries are queries contained within other queries. They are typically used to return entries based on the existence or absence of a condition, as part of a `WHERE` clause. This section describes subquery operators supported in Firebolt.

| Operator     | Explanation                                                                                                                                        |
| :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `EXISTS`     | The `EXISTS` operator is used to check for the existence of any record in a subquery. It returns TRUE if the subquery returns one or more records. |
| `NOT EXISTS` | The `NOT EXISTS` operator returns TRUE if the underlying subquery returns no record.                                                                 |
| `IN`         | The `IN` operator is used to check whether a value matches any value in a list.                                                                    |
| `NOT IN`     | Retrieve all entries from the value list that don't match the required value.                                                                      |

**Example: Using the EXISTS operator, find all suppliers with products equal to the price of 22**

```sql
SELECT supplier_name
FROM suppliers
WHERE EXISTS
        (SELECT product_name
         FROM products
         WHERE products.supplier_id = suppliers.supplier_id AND price < 22);
```

**Example: Using the IN operator, return all the customers from Mannheim or London**

```sql
SELECT customer_name
FROM customers
WHERE customer_address in ('Mannheim','London');
```

**Example: Using correlated subquery to retrieve all the products that cost more than the avg(price)**

```sql
SELECT
    product_id,
    product_name,
    list_price
FROM
    products p
WHERE
    list_price > (
        SELECT
            AVG( list_price )
        FROM
            products
        WHERE
            category_id = p.category_id
    );
```

**Example: Using scalar boolean subquery to retrieve rows based on true/false condition**

```sql
SELECT * FROM products WHERE
(SELECT
   CASE WHEN min(list_price) > 100 THEN true
        ELSE false
   END
 FROM products);
```
