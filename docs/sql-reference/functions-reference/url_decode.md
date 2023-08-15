---
layout: default
title: URL_DECODE
description: Reference material for URL_DECODE function
parent: SQL functions
---

# URL\_DECODE

Decodes percent-encoded characters.

## Syntax
{: .no_toc}

```sql
URL_DECODE(<string>)
```

| Parameter  | Description               |
| :--------- | :------------------------ |
| `<string>` | The string to be decoded. |

## Example
{: .no_toc}

This example below decodes an URL that was encoded according to RFC 3986

```sql
select URL_DECODE('https://www.firebolt.io/?example_id%3D1%26hl%3Den');
```

**Returns**: `https://www.firebolt.io/?example_id=1&hl=en`

This example below uses the function to decode all not Unreserved Characters according to RFC 3986 section 2.3 between Ox20 and Ox7Ek

```sql
SELECT URL_ENCODE(`%20%21%22%23%24%25%26%27%28%29%2A%2B%2C-.%2F0123456789%3A%3B%3C%3D%3E%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%5E_%60abcdefghijklmnopqrstuvwxyz%7B%7C%7D~`) AS res;
```

**Returns**: !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_\`abcdefghijklmnopqrstuvwxyz{|}~
