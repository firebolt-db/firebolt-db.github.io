---
layout: default
title: Integrations
nav_order: 6
has_children: true
has_toc: false
---

# Integrations

Firebolt is working with an expanding roster of services and applications to utilize our optimized performance speed.

The services listed below include tools that have been customized by our partners to connect with Firebolt. Many services not explicitly listed here can still operate with Firebolt's architecture through our [drivers and adapters](connecting-via-jdbc.md) for general connection use.

* [Apache Airflow](other-integrations/setting-up-airflow-jdbc-to-firebolt.md)
* [DBeaver](other-integrations/setting-up-dbeaver-jdbc-connection-to-firebolt.md)
* [dbt](data-integration-and-transformation/connecting-with-dbt.md)
* [Keboola](data-integration-and-transformation/connecting-to-keboola.md)
* [Looker](business-intelligence/connecting-to-looker.md)
* [Metabase](business-intelligence/connecting-to-metabase.md)
* [SQLAlchemy](../developing-with-firebolt/connecting-with-sqlalchemy.md)
* [Apache Superset / Preset](business-intelligence/connecting-to-apache-superset.html)
* [Tableau](business-intelligence/setting-up-tableau-desktop-jdbc-to-firebolt.md)

## Common connection parameters

Most integrated services require the same parameters from Firebolt to establish a connection. Unless otherwise noted, connection details for Firebolt can be found as indicated below.

* **Username**: The email address used to create your Firebolt account.
* **Password**: The password used to create your Firebolt account.
* **Database**: The name of your database. This appears on the **Databases** list of the Firebolt Manager as **Database Name**.
* **Engine**: The engine being used to query your database. Some services automatically use your default engine unless you specify otherwise. To view database engine names, on the **Databases** list, choose the number under **Engines** for your database.
