---
layout: default
title: Tableau
description: Learn how to connect Tableau to Firebolt.
parent: Business intelligence
grand_parent: Integrations
---

# Connecting Tableau to Firebolt

Tableau is a leading data visualization and business intelligence platform that allows anyone to see and understand their data. When connected to Firebolt, Tableau delivers sub-second query speeds on live connections, thus enabling truly interactive analytics experiences without needing to compromise on data volume, freshness, or latency.
  
## Getting started
  
### Installation

To connect to Firebolt from Tableau Desktop, Tableau Server, or Tableau Prep, you must install the Firebolt connector. The instructions to do so can be found in the Tableau Exchange [here](https://exchange.tableau.com/products/650).
  
### Creating a connection

Once the connector is installed, you can create a new connection to Firebolt from Tableau via **Connect** > **More** > **Firebolt Connector by Firebolt**. The following fields are used to establish the connection.

#### Connection Fields

| Field       | Required | Description                                                                                        |
|-------------|----------|----------------------------------------------------------------------------------------------------|
| Server      | Yes      | The host to connect to, which is api.app.firebolt.io.                                              |
| Engine      | No       | The name (not the URL) of the Firebolt engine to use. If omitted, the default engine will be used. |
| Account     | No       | Your Firebolt account.                                                                             |
| Database    | Yes      | The name of your Firebolt database.                                                                |
| Username    | Yes      | Your Firebolt username.                                                                            |
| Password    | Yes      | Your Firebolt password.                                                                            |


## Supported Features

The Firebolt Connector for Tableau currently supports Tableau Desktop, Tableau Server, and Tableau Prep. Support for Tableau Online is planned but not yet available.
