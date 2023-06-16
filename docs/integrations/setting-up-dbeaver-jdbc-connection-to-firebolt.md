---
layout: default
title: DBeaver
nav_exclude: true
---

# Connecting to DBeaver
{: .no_toc}

DBeaver is a free open-source administration tool used to simplify working across a range of different database types. DBeaver can connect to Firebolt databases using our JDBC driver.

1. Topic ToC
{:toc}

## Adding driver configuration in DBeaver

1. Download the [Firebolt JDBC driver](../developing-with-firebolt/connecting-with-jdbc.md#downloading-the-jdbc-driver).

2. From the top navigation menu choose **Database** > **Driver Manager**.

3. In **Driver Manager**, choose **New**.

![](../../assets/images/dbeaver_322_DriverManager.png)

5. Enter parameters according to the following guidelines:
   * Driver Name: `Firebolt`.
   * Class Name: `com.firebolt.FireboltDriver`.
   * ![](../../assets/images/dbeaver_322_DriverManager_2.png)
   * Under **Libraries**, choose **Add File**, and then choose the JDBC driver you downloaded in step 1.
   * ![](../../assets/images/dbeaver_322_DriverManager_3.png)

6. Choose **OK**.
   * ![](../../assets/images/dbeaver_322_DriverManager_4.png)

## Adding a database in DBeaver

1. From the top navigation menu, choose **Database** > **New Database Connection**.  

2. Type `Firebolt` in the search box, and then select it from the list of databases.  
![](../../assets/images/dbeaver_322_NewConnection.png)

3. Choose **Next**.  

4. Enter parameters according to the following guidelines:

| Parameter    |Description|
| :----------- |:--------- |
| **JDBC URL** | Use the following URL: `jdbc:firebolt://api.app.firebolt.io/<db_name>` <br> <br> In the path above, be sure to replace `<db_name>` with the name of your Firebolt database. This enables you to query the database using its default engine. <br> <br> If you wish to use a different engine than your default, use the following URL: `jdbc:firebolt://api.app.firebolt.io/<db_name>?engine=<engineName>` <br> <br>In the path above, replace `<engineName>` with the name of the engine you would like to use. |
| **Username** | Your Firebolt username.|
| **Password** | Your Firebolt password.|
| **account**  | If the user has access to multiple accounts, set the account setting under Driver Properties to the account name to which the engine belongs.|


![](../../assets/images/dbeaver_322_NewConnection_2.png)
![](../../assets/images/dbeaver_322_NewConnection_3.png)

5. Choose **Test Connection**. Make sure to start your database before you start the test and confirm the status is **Connected** as shown below.  
![](../../assets/images/dbeaver_322_NewConnection_4.png)

6. Choose **Finish**.

## Querying your Firebolt database

1. In the database navigator, right-click the database connection and choose **SQL Editor**. If a pop-up window appears, choose **New Script**.  
![](../../assets/images/dbeaver_322_SQL_Script.png)

2. The SQL editor opens where you can run queries.
![](../../assets/images/dbeaver_322_SQL_Script_2.png)
