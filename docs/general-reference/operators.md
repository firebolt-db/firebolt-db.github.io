---
layout: default
title: Operators
description: Reference for SQL operators available in Firebolt.
nav_order: 3
parent: General reference
---

# Operators
{: .no_toc}

* Topic ToC
{:toc}

## Arithmetic

| Operator | Operator description                             | Example             | Result |
| :-------- | :------------------------------------------------ | :------------------- | :------ |
| +        | addition                                         | `SELECT 2 + 3;`     | 5      |
| -        | subtraction                                      | `SELECT 2 - 3;`     | -1     |
| \*       | multiplication                                   | `SELECT 2 * 3;`     | 6      |
| /        | division (integer division truncates the result) | `SELECT 4 / 2;`     | 2      |
| %        | modulo (remainder)                               | `SELECT 5 % 4;`     | 1      |
| ^        | exponentiation                                   | `SELECT 2.0 ^ 3.0;` | 8      |

{: .note}
> Precision means that the representation of a number is accurate up to a certain number of digits. In Firebolt, `FLOAT` data types have 6-digit precision and `DOUBLE PRECISION` have 16-digit precision. This means that calculations have a precision of 6 or 16 respectively, and numbers are truncated to that precision. For example, if a number is stored as 1.234567, it is automatically truncated to 1.23456 for `FLOAT`.
>
> When performing arithmetic, the number of leading digits in the output is the product of the leading digits in both inputs. This means that if either or both of the input numbers are larger than 6, those numbers are the first truncated, and then the arithmetic is performed.

## Comparison

| Operator | Syntax              | Explanation                      |
| :-------- | :------------------- | :-------------------------------- |
| =        | `a=b`               | a is equal to b.                 |
| !=       | `a!=b`              | a is not equal to b.             |
| <>       | `a<>b`              | a is not equal to b.             |
| <=       | `a<=b`              | a is less than or equal to b.    |
| >        | `a>b`               | a is greater than b.             |
| >=       | `a>=b`              | a is greater than or equal to b. |
| <        | `a<b`               | a is less than b.                |
| BETWEEN  | `a BETWEEN b AND c` | equivalent to b <= a <= c        |

Example of using comparison operator in `WHERE` clause

```sql
SELECT
  *
FROM
  Table
WHERE
  Price >= 100;
```


## String

To concatenate strings, you can use the `CONCAT` function.

```sql
SELECT concat('This', ' is', ' a', ' parenthetical', 'concantenation.') AS concatenated_String
```

Alternatively, you can use the double pipe `||` operator.

```sql
SELECT 'This' || ' is' || ' a' || ' double pipe' || ' concantenation.' AS concatenated_String
```

## Boolean

Boolean operators return the result of a Boolean operation between one or more expressions.

| Operator | Example   | Explanation                   |
| :-------- | :--------- | :----------------------------- |
| `AND`      | `x AND y` | True if both x and y are true |
| `NOT`      | `NOT x`   | True if x is false            |
|  `OR`   | `x OR y`  | True if either x or y is true |

## INTERVAL for date and time

Use the `INTERVAL` operator to add to or subtract from a period of time in `DATE`, `TIME`, or `TIMESTAMP` data types.

### Syntax
{: .no_toc}

```sql
{ +|- } INTERVAL '<quantity> [ <date_unit> ] [ ...]'
```

| Component     | Description|
|:------------  | :----------|
| `<quantity>`  | An integer. Multiple `<quantities>` and `<date_units>` can be used in the same `INTERVAL` command if they are separated by spaces.|
| `<date_unit>` | A date measurement including any of the following: `millennium`, `century`, `decade`, `year`, `month`, `week`, `day`, `hour`, `minute`, `second`, `millisecond`, `microsecond `or their plural forms.  If unspecified, `<date_unit>` defaults to `second`.  |

### Example
{: .no_toc}

```sql
<date_column> + INTERVAL '1 year 2 months 3 days'
<date_column> - INTERVAL '2 weeks'
<date_column> - INTERVAL '1 year 3 hours 20 minutes'
```

## :: operator for CAST

Use can use the `::` operator instead of the [CAST](../sql-reference/functions-reference/cast.md) function to convert one [data type](./data-types.md) to another.

### Syntax
{: .no_toc}

```sql
 -- CAST function
 CAST(<value> AS <type>)
 -- :: operator
 <value>::<type>
```

| Component |Description|
|:----------|:----------|
| `<value>` | The value to convert or an expression that results in a value to convert. Can be a column name,  a function applied to a column or another function, or a literal value. |
| `<type>`  | The target [data type](./data-types.md) (case-insensitive).|

### Example
{: .no_toc}

```sql
SELECT '2021-12-31'::DATE;
SELECT 8.5::FLOAT;
SELECT col_a::BIGINT;
```

## Subquery operators

Subqueries are queries contained within other queries. They are typically used as part of a `WHERE` clause to return entries based on the existence or absence of a condition.

| Operator     | Explanation                                                                                                                                        |
| :------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------- |
| `EXISTS`     | The `EXISTS` operator is used to check for the existence of any record in a subquery. It returns TRUE if the subquery returns one or more records. |
| `NOT EXISTS` | The `NOT EXISTS` operator returns TRUE if the underlying subquery returns no record.                                                                 |
| `IN`         | The `IN` operator is used to check whether a value matches any value in a list.                                                                    |
| `NOT IN`     | Retrieve all entries from the value list that don't match the required value.                                                                      |

### Example&ndash;using EXISTS to find all suppliers with products equal to the price of 22
{: .no_toc}

```sql
SELECT supplier_name
FROM suppliers
WHERE EXISTS (
  SELECT
    product_name
  FROM
    products
  WHERE
    products.supplier_id = suppliers.supplier_id
  AND
    price = 22);
```

### Example&ndash;using the IN operator to return all customers from Mannheim or London
{: .no_toc}

```sql
SELECT
  customer_name
FROM
  customers
WHERE
  customer_address IN ('Mannheim','London');
```

### Example&ndash;using a correlated subquery to retrieve all the products that cost more than the avg(price)
{: .no_toc}

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
      category_id = p.category_id);
```

### Example&ndash;using a scalar boolean subquery to retrieve rows based on true/false condition
{: .no_toc}

```sql
SELECT
  *
FROM
  products
WHERE (
  SELECT CASE WHEN
    min(list_price) > 100
  THEN
    true
  ELSE
    false
  END
  FROM
    products);
```
