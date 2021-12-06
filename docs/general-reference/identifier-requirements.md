# Identifier requirements

Firebolt identifiers can refer to the following items:

* Columns
* Tables
* Indexes
* Databases
* Views
* Engines

Identifiers must be at least one character and at most 255 characters. Firebolt evaluates unquoted identifiers such as table and column names entirely in lowercase. The following queries:

```text
SELECT my_column FROM my_table
SELECT MY_COLUMN FROM MY_TABLE
SELECT mY_cOlUmn FROM mY_tAbLe
```

are all equivalent to:

```text
SELECT my_column FROM my_table
```

{: .note}
Unquoted identifiers in some early Firebolt accounts may be case sensitive.


You can keep uppercase identifiers by enclosing them in double-quotes. For example, the following identifiers are unique:

```text
"COLUMN_NAME"
"column_name"
"CoLuMn_NaMe"
```
