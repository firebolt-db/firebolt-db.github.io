---
layout: default
title: Integrations
description: Learn about options for connecting data services and tools to Firebolt to build your data stack.
nav_order: 3.1
has_children: true
has_toc: false
---

# Integrations

Firebolt is working with an expanding roster of services and applications to utilize our optimized performance speed.

The services listed below include tools that have been customized by our partners to connect with Firebolt. Many services not explicitly listed here can still operate with Firebolt's architecture through our [drivers and adapters](connecting-via-jdbc.md) for general connection use.

* [Adverity](data-integration-and-transformation/connecting-to-adverity.md)
* [Apache Airflow](data-orchestration/airflow.md)
* [Cube.js](business-intelligence/connecting-to-cubejs.md)
* [Dataddo](data-integration-and-transformation/connecting-with-dataddo.md)
* [dbt](data-integration-and-transformation/connecting-with-dbt.md)
* [Estuary Flow](data-integration-and-transformation/connecting-with-estuary-flow.md)
* [Hevo](data-integration-and-transformation/connecting-with-hevo.md)
* [Hightouch](data-integration-and-transformation/connecting-to-hightouch.md)
* [Keboola](data-integration-and-transformation/connecting-to-keboola.md)
* [Looker](business-intelligence/connecting-to-looker.md)
* [Metabase](business-intelligence/connecting-to-metabase.md)
* [Prefect](data-orchestration/prefect.md)
* [Panintelligence](business-intelligence/connecting-to-panintelligence.md)
* [Rivery](data-integration-and-transformation/connecting-to-rivery.md)
* [SQLAlchemy](../developing-with-firebolt/connecting-with-sqlalchemy.md)
* [Apache Superset / Preset](business-intelligence/connecting-to-apache-superset.html)
* [Tableau](business-intelligence/setting-up-tableau-desktop-jdbc-to-firebolt.md)
* [Sifflet](data-observability/sifflet.md)

## Common connection parameters

Most integrated services require the same parameters from Firebolt to establish a connection. Unless otherwise noted, connection details for Firebolt can be found as indicated below.

* **Username**: The email address used to create your Firebolt account.
* **Password**: The password used to create your Firebolt account.
* **Database**: The name of your database. This appears on the **Databases** list of the Firebolt Manager as **Database Name**.
* **Engine**: The engine being used to query your database. Some services automatically use your default engine unless you specify otherwise. To view database engine names, on the **Databases** list, choose the number under **Engines** for your database.
