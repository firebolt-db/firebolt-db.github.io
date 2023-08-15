---
layout: default
title: URL_DECODE
description: Reference material for URL_DECODE function
parent: SQL functions
---

# URL\_DECODE

Decodes percent-encoded characters and replaces them with their binary value.

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

This example below decodes the percent-encoded parameters of an URL

```sql
select URL_DECODE('https://www.firebolt.io/?example_id%3D1%26hl%3Den');
```

**Returns**: https://www.firebolt.io/?example_id=1&hl=en

This example below uses the function to decode all characters between Ox20 and Ox7E

```sql
SELECT URL_DECODE('%20%21%22%23%24%25%26%27%28%29%2A%2B%2C%2D%2E%2F%30%31%32%33%34%35%36%37%38%39%3A%3B%3C%3D%3E%3F%40%41%42%43%44%45%46%47%48%49%4A%4B%4C%4D%4E%4F%50%51%52%53%54%55%56%57%58%59%5A%5B%5C%5D%5E%5F%60%61%62%63%64%65%66%67%68%69%6A%6B%6C%6D%6E%6F%70%71%72%73%74%75%76%77%78%79%7A%7B%7C%7D%7E') AS res;
```

**Returns**: !"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~

## Related

* [URL_ENCODE](url_encode.md)