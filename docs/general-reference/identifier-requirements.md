---
layout: default
title: Identifier requirements
description: Provides requirements and guidance for using SQL identifiers with Firebolt.
nav_order: 2
parent: General reference
---

# Identifier requirements

Firebolt identifiers can refer to the following items:

* Columns
* Tables
* Indexes
* Databases
* Views
* Engines

## Syntax

Identifiers must adhere to the following syntax:

1. Contain at least one character, and no more than 255.
2. The first character must be a letter (a-z) or underscore (_).
3. After the first character, subsequent characters can be letters, underscores, digits (0-9), or dollar signs ($).

## Unquoted identifiers

Firebolt evaluates unquoted identifiers such as table and column names entirely in lowercase. The following queries:

```
SELECT my_column FROM my_table
SELECT MY_COLUMN FROM MY_TABLE
SELECT mY_cOlUmn FROM mY_tAbLe
```

are all equivalent to:

```
SELECT my_column FROM my_table
```

{: .note}
Unquoted identifiers in some early Firebolt accounts may be case sensitive.


You can keep uppercase identifiers by enclosing them in double-quotes. For example, the following identifiers are unique:

```
"COLUMN_NAME"
"column_name"
"CoLuMn_NaMe"
```
