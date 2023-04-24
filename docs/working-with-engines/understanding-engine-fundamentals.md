---
layout: default
title: Understanding engine fundamentals
description: Learn how Firebolt compute engines are decoupled from database storage for maximum flexibility and performance.
nav_order: 1
parent: Working with engines
---

# Understanding engine fundamentals
{: .no_toc}

Firebolt engines are attached to databases. Each engine provides isolated and assured compute and storage capacity that you can use for different workloads and queries.

Engines are configurable and efficient. You can quickly set them up with the capabilities that you need, start them only when you need them, and configure them to stop automatically when not in use. Engine costs accrue only while an engine is running, so you can create as many engines as you like to compare cost and performance and to handle different aspects of your workload.

* Topic Toc
{: toc}

## How engines, databases, and scripts work together

You can attach as many engines as you need to a database. One common database setup is to have two engines attached: one general purpose engine for data ingestion, and one analytics engine to execute queries. For more information, see [Engine type](#engine-type) below.

A running engine is committed to executing SQL scripts, so an engine must be stopped for you to perform any action on it. You can create, edit, attach, start, stop, and delete stopped engines at any time during the life of a database.

When you run a SQL script, you select the engine to use. For databases with multiple engines, you can select one as the default engine. You can run a script on one engine and then switch to a different engine to compare performance and cost. You can also write business logic in your applications outside Firebolt to start engines programmatically.

## Understanding engine properties

Before you create or edit an engine, it’s helpful to understand the details of the engine properties listed below.

### Engine name

The engine name is how you identify the engine. DDL operations use it to identify the engine to act on. The engine name must be unique throughout your Firebolt account. Keep this in mind when creating an engine using DDL. When you create an engine using the Firebolt Manager, the database name is prepended automatically to the engine name to help ensure uniqueness.

Engine names can be no longer than 63 characters and can contain letters, numbers, and the underscore character. Firebolt replaces underscores with dashes when the engine URL is formulated \(see below\). Other special characters and spaces are not supported.

### Region

This is the AWS Region in which Firebolt creates the engine. After you create an engine, you can’t change its Region. An engine must be in the same Region as its database. When you create an engine using the Firebolt Manager, Firebolt automatically creates the engine in the same Region as the database. When you create an engine using DDL, make sure that you create it in the same Region as the database you will attach it to.

### Engine endpoint

Each engine has an endpoint that you use when submitting operations to an engine using the Firebolt REST API. For example, you can use a `POST` command to submit a script to the engine's https URL to run the script. Each engine endpoint uses the engine name, your account name, and the AWS Region ID according to the pattern shown in the https example below.

* `your-engine-name` is the name of your engine, with dashes replacing any underscore characters. For example, the engine name `YourDatabase_YourEngine` is represented as `yourdatabase-yourengine` in the URL.
* `firebolt-account-name` is the name of your Firebolt account. For example, `YourAccount` is represented as `youraccount`.
* `region-id` is the AWS Region identifier where the engine lives. For example, `us-east-1`.

```bash
https://your-engine-name.firebolt-account-name.region-id.app.firebolt.io
```

The example below shows an endpoint for an engine named `maindb_engine1` in the Region `us-east-1` within the Firebolt account `AnyCompany.`

```bash
https://maindb-engine1.anycompany.us-east-1.app.firebolt.io
```

### Engine type

Engines can be one of two _types_:

* **General purpose engines** can do everything analytics engines do, but can also write data to Firebolt tables. They are designed for database creation, data ingestion, and extract, load, and transform \(ELT\) operations. A database can have only one general purpose engine running at a time.

* **Analytics engines** are read-only and are designed for queries that do not ingest data. They can't write values. You can run as many analytics engines as you need at the same time.

### Engine spec

When you choose an _engine spec_, you choose the foundation of an engine’s compute capabilities. Each engine spec has CPU, RAM, and cache characteristics. The engine spec determines the cost per hour \(billed per second\) for each engine node (the total engine cost per hour is also a function of scale). You can choose engine specs for characteristics that are best suited for your Firebolt workload. For details, see [Available engine specs](../general-reference/available-engine-specs.md).

### Scale

_Scale_ determines the number of nodes that the engine uses and can be an integer ranging from 1 to 128. Firebolt monitors the health of nodes on a continuous basis and automatically repairs nodes that report an unhealthy status. To help ensure uninterrupted operation of engines if a node becomes unhealthy, we recommend a scale of two or more for each engine.

### Warmup method

This determines the behavior of the engine on startup. You have three options:

* **Minimal –** The engine loads only join indexes at startup. Other indexes and data are loaded from Firebolt when a query that uses them first runs. This results in faster engine start times, but slower first queries.
* **Preload indexes –** Default. The engine loads primary indexes and join indexes at startup, before the first queries run. First queries are faster than they are with minimal warmup, but engines take longer to start.
* **Preload all data** – The engine loads all indexes and data at startup, before the first queries run. This results in the fastest queries with the slowest engine start times. Only use this option if the size of the database \(as shown using the `SHOW TABLES` SQL statement or in the Firebolt Manager\) will not exceed the total amount of SSD storage available on the engine.

### Auto-stop duration

The period of inactivity, in minutes, after which an engine shuts down automatically to save cost. The default is 20 minutes. Using `CREATE ENGINE` and `ALTER ENGINE` SQL statements, you can specify auto-stop duration in one-minute increments. For more information, see [CREATE ENGINE](../sql-reference/commands/create-engine.md) and [ALTER ENGINE](../sql-reference/commands/alter-engine.md). Using the Firebolt Manager, you can set the auto-stop duration to always on, 20 minutes, or 60 minutes.

## Viewing and understanding engine status

You can execute a [SHOW ENGINES](../sql-reference/commands/show-engines.md) statement to list all engines in your Firebolt account and view engine status. You can also use the **Databases** list or the **Engines** list in the Firebolt Manager.

The table below lists the statuses returned by the `SHOW ENGINES` command and the corresponding status enumeration that the Firebolt API returns.

| `SHOW ENGINES` and UI | API Enum                         | Description                     |
| :-------------------- | :------------------------------- | :------------------------------ |
| Started         | `ENGINE_STATUS_SUMMARY_STARTING` | The engine was started. It is provisioning resources, warming up, and will be ready to use soon. |
| Running               | `ENGINE_STATUS_SUMMARY_RUNNING`  | The engine is running queries or available to run queries. You cannot edit, delete, or attach a running engine. |
| Stopping              | `ENGINE_STATUS_SUMMARY_STOPPING` | The engine is shutting down. It is finishing query tasks in process and is not available for new queries. |
| Stopped               | `ENGINE_STATUS_SUMMARY_STOPPED`  | The engine is stopped. It is not available to run queries. You are able to edit, delete, or attach engines in this state. |
| Dropping              | `ENGINE_STATUS_DELETING`         | The engine configuration is being permanently deleted. |
| Repairing             | `ENGINE_STATUS_REPAIRING`        | At least one node is out of service because of an infrastructure or software failure. Firebolt is working on replacing nodes. The engine is not available to run queries, and any query actions in progress have stopped.|
