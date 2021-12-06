# Window Functions

This page describes the window functions supported in Firebolt.

A window function performs an aggregate-like operation on a set of query rows, whereas unlike aggregate operation, it doesn't require 'group by' operation and it produces a result for each query row.

Syntax:

```sql
FUNCTION_NAME() OVER ([PARTITION BY <expr1>] [ORDER BY <expr2> [ASC|DESC]])
```

| Function name | Description | Comment |
| :--- | :--- | :--- |
| RANK\(\) | Rank the current row within its partition with gaps | Must include `ORDER BY` |
| DENSE\_RANK\(\) | Rank the current row within its partition without gaps | Must include `ORDER BY` |
| MIN\(\) | Calculate the minimum value within its partition | Must not include  `ORDER BY` |
| MAX\(\) | Calculate the maximum value within its partition | Must not include `ORDER BY` |
| SUM\(\) | Calculate the sum of the values within its partition. The SUM function works with numeric values and ignores NULL values. | Must not include  `ORDER BY` |
| COUNT\(\) | Count the number of values within its partition. | Must not include  `ORDER BY` |

**Usage example**

Consider the following WF table:

| id | purchase\_date | amount | username |
| :--- | :--- | :--- | :--- |
| 1 | 2020-10-18 | 45 | Joy |
| 2 | 2020-10-17 | 343 | Adam |
| 3 | 2020-10-16 | 65.87 | Ruth |
| 4 | 2020-10-10 | 65.90 | Emma |
| 5 | 2020-12-18 | 655 | Adam |

```sql
SELECT DENSE_RANK() OVER (PARTITION BY username ORDER BY purchase_date ASC) from WF; 

SELECT RANK() OVER (PARTITION BY username ORDER BY purchase_date DESC) from WF; 

SELECT MIN(purchase_date) OVER (PARTITION BY username) from WF; 

SELECT MAX(amount) OVER (PARTITION BY username) from WF;

SELECT SUM(amount) OVER (PARTITION BY username) from WF;

SELECT COUNT(amount) OVER (PARTITION BY username) from WF;
```

