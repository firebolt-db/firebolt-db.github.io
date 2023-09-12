---
layout: default
title: URL_DECODE
description: Reference material for URL_DECODE function
parent: SQL functions
---

# URL\_DECODE

Decodes [percent-encoded](https://en.wikipedia.org/wiki/Percent-encoding) characters and replaces them with their binary value.

## Syntax
{: .no_toc}

```sql
URL_DECODE(<expression>)
```

## Parameters
{: .no_toc}

| Parameter | Description                |Supported input types |
| :--------- | :------------------------ | :--------------------|
| `<expression>` | The string to be decoded. | `TEXT`           |

## Return Type
{: .no_toc}

`TEXT`

## Example
{: .no_toc}

This example below decodes the percent-encoded parameters of an URL:

```sql
SELECT URL_DECODE('https://www.firebolt.io/?example_id%3D1%26hl%3Den');
```

**Returns**: https://www.firebolt.io/?example_id=1&hl=en

## Related

* [URL_ENCODE](url_encode.md)