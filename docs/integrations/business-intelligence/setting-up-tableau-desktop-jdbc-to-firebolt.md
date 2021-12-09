---
layout: default
title: Tableau
nav_order: 3
parent: Business intelligence
grand_parent: Integrations
---

# Connecting to Tableau (Desktop)

This topic describes the steps for setting up the Tableau (Desktop) connection to Firebolt.

## Step 1: Install the latest Firebolt JDBC Driver

Download Firebolt’s JDBC driver for Tableau from [here](../connecting-via-jdbc.md).

Put the JDBC jar file in the Tableau JDBC driver folder:

* Windows: `C:\Program Files\Tableau\Drivers`
* Mac: `~/Library/Tableau/Drivers`

## Step 2: Install the latest Firebolt TACO file

Download Firebolt’s packaged connector file for Tableau (with a .taco filename extension) from [here](https://firebolt-publishing-public.s3.amazonaws.com/repo/Tableau/firebolt_connector.taco).

Copy the packaged connector file into your `My Tableau Repository/Connectors directory`:

* Windows:_`C:\Users\[your-user]\Documents\My Tableau Repository\Connectors`_
* Mac:_`~/Documents/My Tableau Repository/Connectors`_

## Step 3: Set up the connection to Firebolt in Tableau

### Pre-requisites

1. Make a note of the database name you would like to connect to in Firebolt. Also, make sure the database has an up-and-running engine before you configure the connection in Tableau.
2. Make a note of the username and password used to log into Firebolt.
3. Start Tableau and disable the signature validation for the TACO file - read more in [Tableau's docs](https://tableau.github.io/connector-plugin-sdk/docs/run-taco) under the "Disabling signature verification" topic.

### Configuring the Connection

1. In Tableau's UI under connections click **More:** ![](../assets/images/screen-shot-2021-03-22-at-16.53.10.png)
2. Search for "Connector by Firebolt" in the list of connectors and click on it. The following popup appears: ![](../assets/images/screen-shot-2021-03-22-at-16.55.34.png)
3.  Fill in the following parameters and click sign-in:

    | Parameter  | Description                                                                                                  | Value                  |
    | ---------- | ------------------------------------------------------------------------------------------------------------ | ---------------------- |
    | `Server`   | The URL of Firebolt's API server                                                                             | `api.app.firebolt.io`  |
    | `Database` | The name of the database you would like to connect to                                                        | Database name          |
    | `Engine`   | The name of the engine you would like to use (optional). If not specified - the default engine will be used. | Engine name            |
    | `Username` | The username used for connecting to Firebolt                                                                 | Your Firebolt username |
    | `Password` | The password used for connecting to Firebolt                                                                 | Your Firebolt password |
