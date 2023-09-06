---
layout: default
title: URL_ENCODE
description: Reference material for URL_ENCODE function
parent: SQL functions
---

# URL\_ENCODE

Encodes all characters that are not unreserved using [percent-encoding](https://en.wikipedia.org/wiki/Percent-encoding).

Unreserved characters are defined according to [W3C RFC 3986](https://www.rfc-editor.org/rfc/rfc3986.html).

```
unreserved  = ALPHA / DIGIT / "-" / "." / "_" / "~"
```

## Syntax
{: .no_toc}

```sql
URL_ENCODE(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                |Supported input types |
| :--------- | :------------------------ | :--------------------|
| `<expression>` | The string to be encoded. | `TEXT` |

## Return Type
{: .no_toc}

`TEXT`

## Example
{: .no_toc}

This example below uses the function converts not _unreserved characters_ that appear in the parameter section of the URL

```sql
SELECT CONCAT('https://www.firebolt.io/?', URL_ENCODE('example_id=1&hl=en'));
```

**Returns**: https://www.firebolt.io/?example_id%3D1%26hl%3Den

This example below encodes all not _unreserved characters_ between Ox20 and Ox7E

```sql
SELECT URL_ENCODE(` !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\`abcdefghijklmnopqrstuvwxyz{|}~`) AS res;
```

**Returns**: %20%21%22%23%24%25%26%27%28%29%2A%2B%2C-.%2F0123456789%3A%3B%3C%3D%3E%3F%40ABCDEFGHIJKLMNOPQRSTUVWXYZ%5B%5C%5D%5E_%60abcdefghijklmnopqrstuvwxyz%7B%7C%7D~

## Related

* [URL_DECODE](url_decode.md)