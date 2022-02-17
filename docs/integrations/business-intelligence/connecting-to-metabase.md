---
layout: default
title: Metabase
description: Learn how to connect Metabase to Firebolt.
nav_order: 3
parent: Business intelligence
grand_parent: Integrations
---

# Connecting to Metabase
{: .no_toc}

Metabase is an open source business intelligence tool used for querying data sets and producing dashboards.

1. Topic ToC
{:toc}

### Install Metabase

For more information about creating an instance and getting started with Metabase, see [Metabase documentation](https://www.metabase.com/docs/latest/operations-guide/running-the-metabase-jar-file.html) to create an instance.

### Download required files

After setting up Metabase, download the following files and save them to the Metabase `plugins` directory on your host system. By default, `plugins` is a subdirectory of the directory where the `metabase.jar` file executes.

* Download the [Firebolt JDBC driver JAR](https://docs.firebolt.io/integrations/connecting-via-jdbc).
* Download the [Firebolt Metabase driver](https://firebolt-publishing-public.s3.amazonaws.com/repo/metabase-driver/firebolt-metabase-driver.jar).



### Creating a connection

You are now ready to run Metabase with your Firebolt databases.

1. Use a web browser to navigate to the home page of your Metabase instance.

    ![Metabase home page](../../assets/images/Metabase_home.png)

2. From the **Settings** menu, select the **Admin** link:

    ![Metabase home page](../../assets/images/Metabase_admin_menu.png)

3. From the Metabase **Admin** page, select the **Databases** link at the top of the page. Then select **Add database**.  

    ![Metabase home page](../../assets/images/Metabase_admin_menu2.png)

4. You should see **Firebolt** listed under the selections for **Database type**

5. Enter the rest of the parameters for your database:


| **Database type**              |  `Firebolt`                                                                                                                                                                                         |                                                        
| **Name**                       |  A title to refer to your database in Metabase. For simplicity, we recommend using the same name as your Firebolt database                                                                                                                                                      |                                                        
| **Host**                       |  `api.app.firebolt.io`                                                                                                                                                                            |                                                        
| **Port**                       |  `8123`                                                                                                                                                                                           |                                                        
| **Database name**              |  The name of your database in Firebolt                                                                                                                                                            |                                                        
| **Username**                   | The username of your Firebolt account with access privileges to the specified database                                                                                                                                                                          |                                                       
| **Password**                   |  The password associated with the username of your Firebolt account                                                                                                                                                                           |                                                       
| **Additional JDBC parameters** |  Can be left blank. Any additional parameters for Firebolt can be added here. For example, the following paramater specifies a Firebolt engine to use for queries from Metabase: `engine=<my_database_engine_1>` |

Be sure to select **Save** after entering all your information. After saving, you should get a message saying your Firebolt database was successfully added.
