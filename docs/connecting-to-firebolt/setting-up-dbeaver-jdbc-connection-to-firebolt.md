# Setting up DBeaver JDBC connection to Firebolt

## Adding driver configuration in DBeaver

1. Download Firebolt JDBC driver from [here](connecting-via-jdbc.md#downloading-the-driver).
2. Open the driver manager dialog: From the top navigation menu click on **Database** &gt; **Driver Manager**.
3. Click on **New** to add a new driver:  ![](../.gitbook/assets/dbeaver_add_new_driver.png) 
4. In order to add the driver, fill in the following parameters:

   * Driver Name: `Firebolt`.
   * Class Name: `com.firebolt.FireboltDriver`.
   * Under **Libraries**, click **Add File** and choose the driver downloaded in section 1 above.

   Click **OK** for completing adding the driver.

## Adding a database in DBeaver

1. From the top navigation menu click on **Database** &gt; **New Database Connection**.
2. Type Firebolt in the search box.
3. Select Firebolt from the list of databases.
4. Click **Next**.
5. Fill in the following parameters:
   * JDBC URL: `jdbc:firebolt://api.app.firebolt.io/<db_name>`

     Where `<db_name>` should be replaced with the name of your database in Firebolt.  
     This enables you to query the database using its default engine. If you wish to use another engine, use the following URL:

     `jdbc:firebolt://api.app.firebolt.io/<db_name>?engine=engineName`  
     Replace engineName with the name of the engine you would like to use.

   * Username: your FIrebolt username.
   * Password: your Firebolt password.
6. Click on **Test Connection** \(make sure to start your database before you start the test\). A successful connection test looks as follows:  ![](../.gitbook/assets/dbeaver_connection_test.png) 
7. Click **Finish**.

## Querying your Firebolt database

1. In the database navigator, right-click on the database connection and click on **SQL Editor**. In-case a pop-up appears click on **New Script**:  ![](../.gitbook/assets/dbeaver_new_script.png) 
2. The SQL editor is being opened and you can run your queries.

