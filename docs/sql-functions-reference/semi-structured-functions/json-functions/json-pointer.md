# JSON Pointer

This page describes the syntax and semantics of JSON Pointer, a way to access specific elements in a JSON document. For a formal specification see [RFC6901](https://tools.ietf.org/html/rfc6901).

A JSON Pointer is a string starting with `/` \(slash\) denoting the root of the JSON document, followed by a sequence of property names \(keys\) or zero-based ordinal numbers, separated but slashes. It treats the JSON document as a typical filesystem. In the case of ordinal number, they can be used to address the n-th property, or the n-th an element of an array.

The tilde `~` and slash `/` characters have special meanings, therefore if a property name contains those characters they should be escaped.

For a literal tilde `~` use `~0`

For a literal slash `/` use `~1`

Let's consider the following JSON document:

```javascript
{
    "key": 123,
    "key~with~tilde": 2,
    "key/with/slash": 3,
    "value": {
      "dyid": 987,
      "keywords" : ["insanely","fast","analytics"]
    }
}
```

Here's is a list of JSON Pointers and the results of their evaluation

<table>
  <thead>
    <tr>
      <th style="text-align:left">Pointer</th>
      <th style="text-align:left">Result</th>
      <th style="text-align:left">Notes</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>/</code>
      </td>
      <td style="text-align:left">
        <p>{</p>
        <p>&quot;key&quot;: 123,</p>
        <p>&quot;key~with~tilde&quot;: 2,</p>
        <p>&quot;key/with/slash&quot;: 3,</p>
        <p>&quot;value&quot;: {</p>
        <p>&quot;dyid&quot;: 987,
          <br />&quot;keywords&quot; : [&quot;insanely&quot;,&quot;fast&quot;,&quot;analytics&quot;]</p>
        <p>}</p>
        <p>}</p>
      </td>
      <td style="text-align:left">The whole document</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>/key</code>
      </td>
      <td style="text-align:left">123</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>/key~0with~0tilde</code>
      </td>
      <td style="text-align:left">2</td>
      <td style="text-align:left">Note the use of escaping</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>/key~1with~1slash</code>
      </td>
      <td style="text-align:left">3</td>
      <td style="text-align:left">Note the use of escaping</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>/2</code>
      </td>
      <td style="text-align:left">3</td>
      <td style="text-align:left">Access by position</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>/value/keywords/1</code>
      </td>
      <td style="text-align:left">&quot;fast&quot;</td>
      <td style="text-align:left">Accessing an array element</td>
    </tr>
  </tbody>
</table>

