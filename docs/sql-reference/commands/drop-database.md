---
layout: default
title: DROP DATABASE
description: Reference and syntax for the DROP DATABASE command.
parent:  SQL commands
---

{: .note}
This documentation is related to an older version of Firebolt. For the most current documentation, see [Firebolt documentation](https://docs.firebolt.io/godocs/).

# DROP DATABASE
Deletes a database.

## Syntax
{: .no_toc}

Deletes the database and all of its tables and attached engines.

```DROP DATABASE [IF EXISTS] <database_name>```

## Parameters
{: .no_toc}

| Parameter         | Description                            |
| :----------------- | :-------------------------------------- |
| `<database_name>` | The name of the database to be deleted |
