# Identifier Requirements

Firebolt evaluates unquoted identifiers such as table and column names entirely in lowercase. Therefore the following queries:

```text
SELECT my_column FROM my_table
SELECT MY_COLUMN FROM MY_TABLE
SELECT mY_cOlUmn FROM mY_tAbLe
```

are all equivalent to:

```text
SELECT my_column FROM my_table
```

Uppercase identifiers can be retained by enclosing in double-quotes. For example, all of these identifiers are unique:

```text
"COLUMN_NAME"
"column_name"
"CoLuMn_NaMe"
```

{: .note}
Unquoted identifiers in some early Firebolt accounts may be case sensitive. 

Each identifier name must be at least 1 character long at minimum and at most 255 characters maximum.  

Firebolt identifiers can refer to the following items:

* Columns
* Tables
* Indexes
* Databases
* Views
* Engines
