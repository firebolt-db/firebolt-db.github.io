---
layout: default
title: Metabase
nav_order: 1
parent: Business intelligence
grand_parent: Integrations
---

# Connecting to Metabase

Metabase is an open source business intelligence tool used for querying data sets and producing dashboards.

To get started with Metabase, please follow the [official guide](https://www.metabase.com/docs/latest/operations-guide/running-the-metabase-jar-file.html) to create an instance.

### Downloading Firebolt drivers for your Metabase instance

After setting up Metabase, you need to download the files listed below before you can connect to your Firebolt database.

* Download the [Firebolt JDBC driver JAR](https://docs.firebolt.io/integrations/connecting-via-jdbc).
* Download the [Firebolt Metabase driver](https://firebolt-publishing-public.s3.amazonaws.com/repo/metabase-driver/firebolt-metabase-driver.jar).

Both of these files should be placed in the Metabase `plugins` directory.

### Launching Metabase with Firebolt

You are now ready to run Metabase with your Firebolt databases.

1. Use a web browser to naviagate to the home page of your Metabase instance. You should see a screen like below:

    ![Metabase home page](../../assets/images/Metabase_home.png)

2. To connect to your Firebolt database, click on the Admin link under the settings menu (located on the top right):

    ![Metabase home page](../../assets/images/Metabase_admin_menu.png)

3. From the Admin page, select the "Databases" link at the top of the page. Then select "Add database".  

    ![Metabase home page](../../assets/images/Metabase_admin_menu2.png)

4. You should see Firebolt listed under the selections for "Database type". If you don't see Firebolt here, please revisit the previous steps and make sure you installed the Firebolt JDBC and Firebolt Metabase drivers in the correct folder.

5. Enter the rest of the parameters for your database:

    * **Database type**: Firebolt
    * **Name**: Use any name
    * **Host**: `api.app.firebolt.io`
    * **Port**: `8123`
    * **Database name**: the name of your database in Firebolt
    * **Username**: your Firebolt username
    * **Password**: your Firebolt password
    * **Additional JDBC parameters**: you can leave this one blank for now. If you need to pass additional parameters to Firebolt, you can add them here. For example, specifying a Firebolt account to use a specific engine would look like this: `account=my_account_name&engine=my_database_engine_1`

Be sure to select "Save" after entering all your information.

After saving, you should get a message saying your Firebolt database was successfully added. If this connection fails, please recheck the information entered for your database to ensure it is accurate.
