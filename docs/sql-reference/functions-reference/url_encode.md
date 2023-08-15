---
layout: default
title: URL_ENCODE
description: Reference material for URL_ENCODE function
parent: SQL functions
---

# URL\_ENCODE

Encodes all characters that are not Unreserved Characters according to RFC 3986 section 2.3 as percent-encoding.

## Syntax
{: .no_toc}

```sql
URL_ENCODE(<string>)
```

| Parameter  | Description               |
| :--------- | :------------------------ |
| `<string>` | The string to be encoded. |

## Example
{: .no_toc}

This example below converts reserved characters according to RFC 3986 that appear in the parameter section of the URL

```sql
select CONCAT('https://www.firebolt.io/?', URL_ENCODE('example_id=1&hl=en'));
```

**Returns**: `https://www.firebolt.io/?example_id%3D1%26hl%3Den`

This example below uses the function to encode all ascii characters between Ox20 and Ox7E

```sql
SELECT URL_ENCODE(` !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\`abcdefghijklmnopqrstuvwxyz{|}~`) AS res;
```

**Returns**: `%20%21%22%23%24%25%26%27%28%29%2A%2B%2C-.%2F0123456789%3A%3B%3C%3D%3E%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%5E_%60abcdefghijklmnopqrstuvwxyz%7B%7C%7D~`
