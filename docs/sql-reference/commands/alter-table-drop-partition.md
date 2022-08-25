---
layout: default
title: ALTER TABLE...DROP PARTITION
description: Reference and syntax for the ALTER TABLE...DROP PARTITION command.
parent: SQL commands
---

# ALTER TABLE...DROP PARTITION

Use `ALTER TABLE...DROP PARTITION` to delete a partition from a fact or dimension table.

{: .warning}
Dropping a partition deletes the partition and the data stored in that partition.

## Syntax

```sql
ALTER TABLE <table_name> DROP PARTITION <part_key_val1>[,...<part_key_valN>]
```

| Parameter          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | Mandatory? Y/N |
| :------------------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------- |
| `<table_name>`     | Name of the fact table from which to drop the partition.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | Y              |
| `<part_key_val1>[,...<part_key_valN>]` | An ordered set of one or more values corresponding to the partition key definition. This specifies the partition to drop. When dropping partitions with composite keys (more than one key value), specify all key values in the same order as they were defined. Only partitions with values that match the entire composite key are dropped. | Y              |

## Examples

See the examples in [Working with partitions](../../working-with-partitions.md#examples).
