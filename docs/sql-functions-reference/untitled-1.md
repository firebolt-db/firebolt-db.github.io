# Numeric functions

This page describes the numeric functions supported in Firebolt.

## ACOS

Calculates the arc cosine.

**Syntax**

```sql
ACOS(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## ASIN

Calculates the arc sinus.

**Syntax**

```sql
ASIN(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## COS

Calculates the cosine.

**Syntax**

```sql
COS(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## SIN

Calculates the sinus.

**Syntax**

```sql
SIN(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## TAN

Calculates the tangent.

**Syntax**

```sql
TAN(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## ATAN

Calculates the arctangent.

**Syntax**

```sql
ATAN(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## MOD

Calculates the remainder after division.

**Syntax**

```sql
MOD(a,b)
```

| Parameter | Description |
| :--- | :--- |
| `a` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `b` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## RADIANS

Converts degrees to radians PI\(\) Returns the π \(Float\).

**Syntax**

```sql
​​RADIANS(x) ​​
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## PI

Calculates the π \(Float\).

**Syntax**

```sql
​​PI() ​​
```

## EXP

Accepts a numeric argument and returns its exponent \(FLOAT\).

**Syntax**

```sql
EXP(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## LOG

Returns the natural logarithm of a numeric expression based on the desired base.

**Syntax**

```sql
LOG([base,] numeric);
```

| Parameter | Description |
| :--- | :--- |
| `base` | The base for the log \(optional\). The default base is 10. |
| `numeric` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

**Usage example**

```sql
SELECT LOG(2, 64.0)
```

This que**r**y returns the log of 64.0 with base 2 \(6\).

```sql
SELECT LOG(64.0)
```

This que**r**y returns the log of 64.0 with the default, base 10 \(1.806 \).

## SQRT

Returns the square root of a non-negative numeric expression.

**Syntax**

```sql
SQRT(x);
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## CBRT

Returns the cubic-root of a non-negative numeric expression.

**Syntax**

```sql
CBRT(x);
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## POW, POWER

Returns a number \(x\) raised to the specified power \(y\).

**Syntax**

```sql
POW(x,y)​;
POWER(x,y)​;
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `y` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

## FLOOR

Returns the largest round number that is less than or equal to x. A round number is a multiple of 1/10N, or the nearest number of the appropriate data type if 1 / 10N isn’t exact.

**Syntax**

```sql
FLOOR(x[, N])
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `N` | An INTEGER constant \(optional parameter\).  By default, it is zero, which means to round to an integer. May also be negative. |

## CEIL, CEILING

Returns the smallest round number that is greater than or equal to x.

**Syntax**

```sql
CEIL(x[, N]);
CEILING(x[, N]);
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `N` | An INTEGER constant \(optional parameter\).  By default, it is zero, which means to round to an integer. May also be negative. |

## TRUNC

Returns the round number with the largest absolute value that has an absolute value less than or equal to x‘s.

**Syntax**

```sql
TRUNC(x[, N])
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `N` | An INTEGER constant \(optional parameter\).  By default, it is zero, which means to round to an integer. May also be negative. |

## ROUND

Rounds a value to a specified number of decimal places.

**Syntax**

```sql
ROUND(x[, N])
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |
| `N` | An INTEGER constant \(optional parameter\).  By default, it is zero, which means to round to an integer. May also be negative. |

## ABS

Rounds a value to a specified number of decimal places.

**Syntax**

```sql
ABS(x)
```

| Parameter | Description |
| :--- | :--- |
| `x` | Valid values include column names, functions that return a column with numeric values, and constant numeric values. |

