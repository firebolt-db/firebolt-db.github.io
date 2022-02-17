---
layout: default
title: SQLAlchemy
description: Learn about using the Firebolt adapter for the SQLAlchemy Python SQL toolkit.
nav_order: 4
parent: Developing with Firebolt
---

# Connecting with SQLAlchemy

SQLAlchemy is an open-source SQL toolkit and object-relational mapper for the Python programming language.

Firebolt’s adapter for SQLAlchemy acts as an interface for other supported third-party applications including Superset and Redash. When the SQLAlchemy adapter is successfully connected, these applications are able to communicate with Firebolt databases through the REST API.

The adapter is written in Python using the SQLAlchemy toolkit. It is built according to the application standards detailed in [PEP 249 - Python Database API Specification v2.0.](https://www.python.org/dev/peps/pep-0249/)

### To get started

We recommend you follow the guidelines for SQLAlchemy integration in our [Github repository](https://github.com/firebolt-db/firebolt-sqlalchemy).
