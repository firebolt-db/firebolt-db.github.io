---
layout: default
title: System settings
description: Lists Firebolt system settings that you can configure using SQL.
nav_order: 6
parent: General reference
---

# Firebolt system settings
{: .no_toc}

Contact Firebolt Support through the Help menu support form if you are interested in enabling the following setting for your Firebolt instance. 


## Enable exact COUNT (DISTINCT)

When not enabled, the [COUNT (DISTINCT)](../sql-reference/functions-reference/count.md) function returns approximate results, using an estimation algorithm with an average deviation under 2%. This is the default to optimize query performance. When enabled, the function returns an exact count, which can slow query performance.

