---
layout: default
title: Choosing an engine
description: Choosing an engine configuration based on your data type and query patterns.
nav_order: 2
parent: Working with engines
---

# Choosing an engine
{: .no_toc}

We recommend that you experiment and tune different engine configurations on pre-production data workflows before you deploy to production. Firebolt's decoupled compute and storage architecture makes that easy. You can play with configurations in pre-production with little effort and low cost. This topic provides guidelines for selecting engines based on your ingestion and query requirements.

* Topic Toc
{: toc}


## Understanding performance factors

The engine specification (the node type) and scale (the number of nodes) are the fundamental aspects of engine performance. Another configuration parameter, the warmup method, affects engine start times. For information about warmup choices, see [Warmup method](understanding-engine-fundamentals.md#warmup-method).

For ingestion engines, tuning considerations include the source data to be ingested, the complexity of the data structures, and the response time that your application demands. For analytics engines, considerations include the complexity of aggregations and joins that you use in your queries. We explore these performance aspects and how they affect your tuning adjustments in more detail below.

## Tuning ingestion engines

The first consideration for ingestion engines is the size of individual files and the entire file payload. Large files place different demands on an engine than small files. If your files are between 100 MB and 32 GB, the default ingestion engine specification and size is usually an excellent fit.

Consider tuning adjustments in any of the following situations:

* Individual files or your total ingestion payload are outside the 100 MB – 32 GB range.
* You ingest complex data structures such as arrays and semi-structured data.
* You ingest many files, especially small files.

### Choose RAM based on file and payload size

Firebolt caches files in RAM when processing them for ingestion. You want enough RAM available to each node, and to the entire engine, to accommodate caching. The more completely your engine can cache files during this process, the faster the engine performs.

{: .note}
The size of the ingestion payload should never exceed the total amount of RAM available to the engine. This may cause an out of memory condition and cause ingestion to fail.

### Adjust node RAM using the engine specification, and then use scale to increase overall engine RAM

For large files and payloads, choose an engine specification that provides each node with enough RAM for your largest individual file. Aim for RAM that is 1.5x to 2x the uncompressed size of the largest file. If node RAM can’t cover the size of the entire payload, adjust engine scale to add nodes. When you scale, aim for engine-wide RAM to exceed the size of the entire payload by the same 1.5x to 2x ratio. This same guidance to add nodes applies to a large file that exceeds any available node capacity.

If you ingest smaller files, a single node engine is often enough. Increase the engine specification so that node RAM can cover the payload using the 1.5x to 2x guidance from above. With small files, it’s often possible to decrease the engine specification without a significant impact to performance.

For improving the ingestion time of small files, it’s especially important to increase node RAM using the engine specification before you add nodes. Adding nodes may actually diminish performance. This is because additional nodes and many files will amplify the inherent overhead of establishing a connection to Amazon S3 and accessing objects. In addition, if you have many files with a single S3 prefix, AWS throttling limits might become a factor. More on that below.

### CPU can help relieve RAM demands, especially for complex data structures

Firebolt holds heavily compressed or complex data structures in RAM longer during ingestion processing than simple structures. Parquet files and nested JSON are examples of more complex file types with high processing demands.

For these file types and data structures, aim for the high end of the 2x RAM ratio mentioned above to begin with. You may even want to exceed it. Also, you may find that increasing the engine specification to improve the CPU or number of cores yields performance gains. This is because files are processed quicker, freeing up RAM for subsequent caching.

### With many files, file structure in S3 can help

Access time to Amazon S3 and the limits that AWS imposes on the number of requests allowed per second \(called throttling\) play a role in engine configuration. You can add nodes to make requests across your data set more quickly, but you want to be mindful that there is a limit of 3.5K requests per second, per S3 prefix \(folder\). AWS may update these values occasionally. If you need to scale out to improve ingestion performance for a large number of files, save files at the source in different folders. For more information, see [Performance Design Patterns for Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/userguide/optimizing-performance-design-patterns.html) in Amazon S3 documentation.

For example, if you have 10,000 files to ingest, and you specify a `URL` like `s3://samplecorp/sampledata` in your external table definition, avoid placing too many files in that folder \(or bucket\). Instead, divide the files into sub-folders like `s3://samplecorp/sampledata/trancheA`, `s3://samplecorp/sampledata/trancheB`, `s3://samplecorp/sampledata/trancheC`, and so on, so that requests to each folder remain under the S3 throttling limit.

## Tuning analytics engines

After data is ingested into Firebolt, your analytics engines process fact and dimension tables for insight. With analytics engines, the complexity of data structures and the queries that you perform are essential considerations. As with ingestion engines, the default configuration is a good place to begin as you seek to improve performance or lower cost. With simple queries that have limited joins and aggregations, you can often keep a single-node engine and use a less powerful engine specification than the default, and still maintain a performance standard to meet application requirements.

### Good indexes help engines

Indexes are to Firebolt analytics engines what the suspension and transmission are to a car engine. They help deliver the engine’s power efficiently for top performance. Developing excellent indexes can help to mitigate the demands on an engine, improving performance and lowering cost. Tuning indexes is a topic of its own. For more information, see [Using indexes](../using-indexes/using-indexes.md).

### Mix and match engines for different query types

You can run as many analytics engines on a database at the same time as you need, using different engines for different queries. Because analytics engines don’t write data, you don’t need to be concerned about issues with locked data or data inconsistency.

Queries that perform complex aggregations and multiple joins are likely to place greater demands on an analytics engine, requiring more processing power, RAM, or both. For these engines, consider modifying the engine specification to add RAM or increase the CPU of nodes according to the guidance below.

#### Queries with joins benefit from increased RAM

Queries joining multiple tables can be memory intensive, with large data sets cached in RAM during join operations. Try increasing the engine specification with more RAM per node. Aim for the memory of each node to be enough to contain all the join indexes fully in memory. Next, add nodes for additional RAM when running large and complex joins.

#### Aggregation queries benefit from increased CPU

Aggregation queries tend to be computationally intensive. Using an engine specification with more CPU power per node is likely to improve performance.
