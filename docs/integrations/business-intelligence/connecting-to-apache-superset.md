---
layout: default
title: Apache Superset / Preset
description: Learn about connecting Apache Superset/Preset to Firebolt.
parent: Business intelligence
grand_parent: Integrations
---

# Connecting to Apache Superset / Preset

[Apache Superset](https://superset.apache.org) is a business intelligence web application that makes it easy for users of all skill sets to explore and visualize their data, from simple pie charts to highly detailed deck.gl geospatial charts.&#x20;

Superset is open-source software and can be downloaded and hosted on your own servers for free. To avoid the complexity of hosting it yourself, we recommend using [Preset](https://preset.io), a managed SaaS service on top of Superset.

## To get started

### Install the driver

If you self-host Superset, you must install the Firebolt driver. If you use Preset, you can skip this section and go to Set up the connection below.&#x20;

To install the driver, see [Adding New Database Drivers in Docker](https://superset.apache.org/docs/databases/docker-add-drivers) in Superset documentation. Use `firebolt-sqlalchemy` as the driver name in `requirements-local.txt`.

### Set up the connection

In the Superset UI, go to **Data** > **Databases** > **Add Database**.&#x20;

The connection expects a SQLAlchemy connection string of the form:

```
firebolt://{username}:{password}@{database}/{engine_name}
```

This is currently available in the latest `master` branch in Superset and will also be included in the Superset v1.4 stable release when it is available.
