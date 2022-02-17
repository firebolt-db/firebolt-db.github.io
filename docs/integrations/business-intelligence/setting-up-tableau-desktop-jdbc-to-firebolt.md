---
layout: default
title: Tableau
description: Learn how to connect Tableau desktop to Firebolt using the Firebolt JDBC driver.
nav_order: 5
parent: Business intelligence
grand_parent: Integrations
---

# Connecting to Tableau (desktop)
{: .no_toc}

This topic describes the steps for setting up the Tableau (desktop) connection to Firebolt.

1. Topic ToC
{:toc}

## Install the latest Firebolt JDBC Driver

Download Firebolt’s JDBC driver for Tableau from [here](../connecting-via-jdbc.md).

Put the JDBC jar file in the Tableau JDBC driver folder:

* Windows: `C:\Program Files\Tableau\Drivers`
* Mac: `~/Library/Tableau/Drivers`

## Install the latest Firebolt TACO file

Download Firebolt’s packaged connector file for Tableau (with a .taco filename extension) from [here](https://firebolt-publishing-public.s3.amazonaws.com/repo/Tableau/firebolt_connector.taco).

Copy the packaged connector file into your `My Tableau Repository/Connectors directory`:

* Windows:_`C:\Users\[your-user]\Documents\My Tableau Repository\Connectors`_
* Mac:_`~/Documents/My Tableau Repository/Connectors`_

## Set up the connection to Firebolt in Tableau

### Pre-requisites

1. Make a note of the database name you would like to connect to in Firebolt. Also, make sure the database has an up-and-running engine before you configure the connection in Tableau.  

2. Make a note of the username and password used to log into Firebolt.  

3. Start Tableau and disable signature validation for the TACO file. For more information, see "Disabling signature verification" in [Run Your Connector](https://tableau.github.io/connector-plugin-sdk/docs/run-taco) in Tableau Connector SDK documentation.

### Configuring the Connection

1. In Tableau, under **Connect**, choose **More**.  

2. Search for **Connector by Firebolt** in the list of connectors and select it.

3. In the form that appears, fill in parameters according to the guidelines below, and then choose **Sign in**.

    | Parameter  | Description                                                                                                  | Value                  |
    | ---------- | ------------------------------------------------------------------------------------------------------------ | ---------------------- |
    | `Server`   | The URL of Firebolt's API server                                                                             | `api.app.firebolt.io`  |
    | `Database` | The name of the database you would like to connect to                                                        | Database name          |
    | `Engine`   | The name of the engine you would like to use (optional). If not specified - the default engine will be used. | Engine name            |
    | `Username` | The username used for connecting to Firebolt                                                                 | Your Firebolt username |
    | `Password` | The password used for connecting to Firebolt                                                                 | Your Firebolt password |
