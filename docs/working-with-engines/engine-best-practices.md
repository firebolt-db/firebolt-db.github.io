# Guidelines and best practices for engine configuration

The guidelines and best practices in this section provide a foundation to begin configuring engines to achieve the right balance of performance and cost.

No two workloads are the same, so we recommend that you experiment with different engine configurations on pre-production data sets to compare cost and performance until you find a configuration that works for your production requirements.

Overall, your goal is to match the engine spec and scale to meet the performance demands of your workload with the lowest cost.

## Sizing general purpose engines for ingestion and ELT

Ingestion speeds scale linearly with the number of nodes in an engine. So, as a general rule, match the profile of your engine configuration to the profile of your source data as much as possible. If you are ingesting large data sets, adding nodes to an engine has the biggest impact on performance. Similarly, if you have small, incremental ingestion tasks, you can use very few nodes.

In addition, scale out the number of nodes in an engine as the number of files to ingest from your data store increases. In this case, scaling out has a more significant impact on performance than using nodes that individually have more RAM, SSD storage, and CPUs.

As the size of files to be ingested increases, however, choose nodes that have more RAM, storage, and CPUs. This helps ensure that each node can accommodate the computational and storage demands of ingesting large files.

Storage-optimized instance types are a good starting point for experimenting with general purpose engines for ingestion and ELT.

## Sizing analytics engines

For analytics engines, use the general guidelines below.

* **Aggregation queries benefit from increased CPU** - Aggregation queries tend to be computationally intensive. For this reason, choosing compute-optimized instance types, or instances that have a greater number of CPU cores, is likely to improve performance.
* **Join queries benefit from RAM** - Join queries tend to be memory intensive, with large data sets cached in RAM during join operations. To contain all join indexes fully in memory, we recommend that you select memory-optimized instance types or instances with more RAM. The goal is to have enough RAM in each node to contain all join indexes fully in memory. This avoids spilling to disk and the time-consuming disk I/O associated with it.

