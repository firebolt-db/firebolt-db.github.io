---
layout: default
title: Using the JDBC driver
description: Download the JDBC driver for Firebolt to connect services and applications to your Firebolt data warehouse.
nav_order: 4
parent: Integrations
---

# Connecting apps and services using the JDBC driver

Firebolt provides a JDBC driver (Type 4) that can be used with most applications and tools that support JDBC for connecting to a database server. The driver is provided as a JAR file and requires Java 1.8 or later.

## Download the latest JDBC driver

* Read the [Firebolt JDBC license terms](https://firebolt-publishing-public.s3.amazonaws.com/repo/jdbc/License.pdf) before downloading the [Firebolt generic JDBC driver](https://firebolt-publishing-public.s3.amazonaws.com/repo/jdbc/firebolt-jdbc-1.25-jar-with-dependencies.jar).

You can use this driver to connect Firebolt to [Airflow](data-orchestration/setting-up-airflow-jdbc-to-firebolt.md), [Tableau](business-intelligence/setting-up-tableau-desktop-jdbc-to-firebolt.md), [DBeaver](setting-up-dbeaver-jdbc-connection-to-firebolt.md), and other services that support JDBC driver connections.
