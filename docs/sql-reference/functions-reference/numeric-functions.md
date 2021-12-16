---
layout: default
title: Numeric functions
nav_order: 4
parent: SQL functions reference
---

# Numeric functions
{: .no_toc}

* Topic ToC
{:toc}

## ABS

Calculates the absolute value of a number `<val>`.&#x20;

### Syntax
{: .no_toc}

```sql
ABS(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    ABS(-200.50)
```

**Returns:** s`200.5`

## ACOS

Calculates the arc cosine of a value `<val>`. `ACOS` returns `NULL` if `<val>` is higher than 1.&#x20;

### Syntax
{: .no_toc}

```sql
ACOS(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    ACOS(0.5)
```

**Returns:** `1.0471975511965979`

## ASIN

Calculates the arc sinus. `ASIN` returns `NULL` if `<val>` is higher than 1.

### Syntax
{: .no_toc}

```sql
ASIN(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    ASIN(1.0)
```

**Returns:** `1.5707963267948966`

## ATAN

Calculates the arctangent.

### Syntax
{: .no_toc}

```sql
ATAN(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    ATAN(90)
```

**Returns**: `1.5596856728972892`

## CBRT

Returns the cubic-root of a non-negative numeric expression.

### Syntax
{: .no_toc}

```sql
CBRT(<val>);
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    CBRT(8);
```

**Returns**: `2`

## CEIL, CEILING

Returns the smallest number that is greater than or equal to a specified value `<val>`. The value is rounded to a decimal range defined by `<dec>`.&#x20;

### Syntax
{: .no_toc}

```sql
CEIL(<val>[, <dec>]);
CEILING(<val>[, <dec>]);
```

| Parameter | Description                                                                                                                               |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.                       |
| `<dec>`   | Optional. An `INT` constant that defines the decimal range of the returned value. By default, `CEIL `and `CEILING` return whole numbers.  |

### Example
{: .no_toc}

```sql
SELECT
    CEIL(2.5549900, 3);
```

**Returns**: `2.555`

## COS

Calculates the cosine.

### Syntax
{: .no_toc}

```sql
COS(<exp>)
```

| Parameter | Description                                           |
| :--------- | :----------------------------------------------------- |
| `<exp>`   | Any expression that evaluates to a numeric data type. |

### Example
{: .no_toc}

```sql
SELECT
    COS(180);
```

**Returns:** `-0.5984600690578581`

## COT

Calculates the cotangent.

### Syntax
{: .no_toc}

```sql
COT(<exp>)
```

| Parameter | Description                                           |
| :--------- | :----------------------------------------------------- |
| `<exp>`   | Any expression that evaluates to a numeric data type. |

### Example
{: .no_toc}

```sql
SELECT
    COT(180)
```

**Returns:** `0.7469988144140444`

## DEGREES

Converts a value in radians to degrees.

### Syntax
{: .no_toc}

```sql
DEGREES(<exp>)
```

| Parameter | Description                                           |
| :--------- | :----------------------------------------------------- |
| `<exp>`   | Any expression that evaluates to a numeric data type. |

### Example
{: .no_toc}

```sql
SELECT
    DEGREES(3);
```

**Returns**: `171.88733853924697`

## EXP

Returns the FLOAT value of the constant _e_ raised to the power of a specified number.

### Syntax
{: .no_toc}

```sql
EXP(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    EXP(2)
```

**Returns:** `7.389056098924109`

## FLOOR

Returns the largest round number that is less than or equal to `<val>`. The value is rounded to a decimal range defined by `<dec>`.&#x20;

### Syntax
{: .no_toc}

```sql
FLOOR(<val>[, <dec>])
```

| Parameter | Description                                                                                                                   |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.           |
| `<dec>`   | Optional. An `INT` constant that defines the decimal range of the returned value. By default, `FLOOR` returns whole numbers.  |

### Example
{: .no_toc}

```sql
SELECT
    FLOOR(2.19, 1)
```

**Returns:** `2.1`

## LOG

Returns the natural logarithm of a numeric expression based on the desired base.

### Syntax
{: .no_toc}

```sql
LOG([<base>,] <num>);
```

| Parameter   | Description                                                                                                         |
| :----------- | :------------------------------------------------------------------------------------------------------------------- |
| `<base>`    | Optional. The base for the logarithm. The default base is 10.                                                       |
| `<numeric>` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

This example below returns the logarithm of 64.0 with base 2.&#x20;

```sql
SELECT LOG(2, 64.0)
```

**Returns:** `6`

This example below returns the logarithm of 64.0 with the default base 10.

```sql
SELECT LOG(64.0)
```

**Returns**: `1.8061799739838869`

## MOD

Calculates the remainder after dividing two values, `<num>` / `<den>.`

### Syntax
{: .no_toc}

```sql
MOD(<num>,<den>)
```

| Parameter | Description                               |
| :--------- | :----------------------------------------- |
| `<num>`   | The numerator of the division equation.   |
| `<den>`   | The denominator of the division equation. |

### Example
{: .no_toc}

```sql
SELECT
    MOD(45, 7)
```

**Returns**: `3`

## PI

Calculates π as a FLOAT value.

### Syntax
{: .no_toc}

```sql
​​PI() ​​
```

### Example
{: .no_toc}

```
SELECT
    PI()
```

**Returns:** `3.141592653589793`

## POW, POWER

Returns a number `<val>` raised to the specified power `<exp>`.

### Syntax
{: .no_toc}

```sql
POW(<val>, <exp>)​;
POWER(<val>, <exp>)​;
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `<exp>`   | The exponent value used to raise `<val>`                                                                            |

### Example
{: .no_toc}

```sql
SELECT
    POW(2, 5)
```

**Returns:** `32`

## RADIANS

Converts degrees to radians as a `FLOAT` value.

### Syntax
{: .no_toc}

```sql
​​RADIANS(<val>) ​​
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    RADIANS(180)
```

**Returns:** `3.141592653589793`

## RANDOM

Returns a pseudo-random unsigned value greater than 0 and less than 1 of type `DOUBLE`.&#x20;

### Syntax
{: .no_toc}

```sql
RANDOM()
```

### Example
{: .no_toc}

The example below demonstrates using `RANDOM` without any other numeric functions. This generates a `DOUBLE` value less than 1.

```sql
SELECT RANDOM()
```

**Returns:** `0.8544004706537051`

####Example&ndash;using RANDOM for range of values**

To create a random integer number between two values, you can use `RANDOM` with the `FLOOR` function as demonstrated below. `a` is the lesser value and `b` is the greater value. &#x20;

```sql
SELECT FLOOR( RANDOM() * ( b - a + 1)) + a;
```

For example, the formula below generates a random integer between 50 and 100:&#x20;

```sql
SELECT FLOOR( RANDOM() * (100 - 50 + 1)) + 50;
```

**Returns:** `61`

## ROUND

Rounds a value to a specified number of decimal places.

### Syntax
{: .no_toc}

```sql
ROUND(<val> [, <dec>])
```

| Parameter | Description                                                                                                                   |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.           |
| `<dec>`   | Optional. An `INT` constant that defines the decimal range of the returned value. By default, `ROUND` returns whole numbers.  |

### Example
{: .no_toc}

```sql
SELECT
    ROUND(5.4)
```

**Returns:** `5`

```
SELECT
    ROUND(5.6930, 1)
```

**Returns:** `5.7`

## SIN

Calculates the sinus.

### Syntax
{: .no_toc}

```sql
SIN(<val>)
```

| Parameter | Description                                                                                                         |
| :--------- | :------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

### Example
{: .no_toc}

```sql
SELECT
    SIN(90)
```

**Returns:** `0.8939966636005579`

## SQRT

Returns the square root of a non-negative numeric expression.

### Syntax
{: .no_toc}

```sql
SQRT(<val>);
```

| Parameter | Description                                                                                                                                                       |
| :--------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values. Returns `NULL `if a negative value is given.  |

### Example
{: .no_toc}

```sql
SELECT
    SQRT(64)
```

**Returns:** `8`

## TAN

Calculates the tangent.

### Syntax
{: .no_toc}

```sql
TAN(<val>)
```

| Parameter | Description                                                                                                          |
| :--------- | :-------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.  |

### Example
{: .no_toc}

```sql
SELECT
    TAN(90)
```

**Returns:** -1.995200412208242

## TRUNC

Returns the rounded absolute value of a numeric value. The returned value will always be rounded to less than the original value.&#x20;

### Syntax
{: .no_toc}

```sql
TRUNC(<val>[, <dec>])
```

| Parameter | Description                                                                                                                  |
| :--------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `<val>`   | Valid values include column names, functions that return a column with numeric values, and constant numeric values.          |
| `<dec>`   | Optional. An `INT` constant that defines the decimal range of the returned value. By default, `TRUNC` returns whole numbers. |

### Example
{: .no_toc}

```sql
SELECT
    TRUNC(-20.5)
```

**Returns:** `-20`

```sql
SELECT
    TRUNC(-99.999999, 3)
```

**Returns:** `-99.999`
