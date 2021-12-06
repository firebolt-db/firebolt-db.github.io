# Setting up Looker JDBC to Firebolt

This topic describes the steps for setting up the Looker JDBC connection to Firebolt.

## Step 1: Add Firebolt’s JDBC driver to Looker

In order to make looker work with Firebolt, follow the instructions in [https://docs.looker.com/setup-and-management/database-config/custom\_jdbc\_drivers](https://docs.looker.com/setup-and-management/database-config/custom_jdbc_drivers) while paying attention to the following:

1. Download Firebolt’s JDBC driver for Looker from [here](connecting-via-jdbc.md#downloading-the-driver) \(make sure you download the Firebolt JDBC driver for Looker\).
2. Put FItebolt’s JDBC driver for Looker here: /home/looker/looker/custom\_jdbc\_drivers/athena/. If you have any other Firebolt driver there, just remove it, and replace it with the one you’ve just downloaded.
3. Create the following file under:/home/looker/looker/custom\_jdbc\_config.yml \(if you already have this file with the following settings, move on to the next step\) and paste the following into it:  
   _Make sure to replace &lt;version&gt; with the JDBC version number. For example - in the following JDBC: "firebolt-jdbc-1.03-jar-looker-with-dependencies.jar" &lt;version&gt; needs to be replaced with 1.03._

   ```yaml
   - name: athena
     file_name: athena/firebolt-jdbc-<version>-jar-looker-with-dependencies.jar
     module_path: com.firebolt.FireboltDriver
     override_jdbc_url_subprotocol: firebolt
   ```

4. Restart looker with the following parameter:

   ```text
   LOOKERARGS="--use-custom-jdbc-config"
   ```

## Step 2: Configure a Connection to Firebolt

### Pre-requisites

1. Make a note of the database name you would like to connect to in Firebolt. Also, make sure the Database has an up and running engine before you configure the connection in Looker.
2. Make a note of the username and password used to log into Firebolt.

### Configuring the Connection

1. In Looker’s UI, Select **Admin** &gt; **Connections** \(under **Database**\). On the Connections page, click **New Connection**.
2. Click on **Existing Database**
3. The following popup appears:

   ![](../.gitbook/assets/looker-connection.png)

Fill in the following parameters:

<table>
  <thead>
    <tr>
      <th style="text-align:left">Parameter</th>
      <th style="text-align:left">Description</th>
      <th style="text-align:left">Value</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>Name</code>
      </td>
      <td style="text-align:left">the connection name in Looker</td>
      <td style="text-align:left">For example: Connection</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Dialect</code>
      </td>
      <td style="text-align:left">The SQL Dialect</td>
      <td style="text-align:left"><code>Amazon Athena</code>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Host:Port</code>
      </td>
      <td style="text-align:left">The username used for connecting to FIrbolt</td>
      <td style="text-align:left"><code>api.app.firebolt.io:443</code>
      </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Database</code>
      </td>
      <td style="text-align:left">The database name in Firebolt.</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Username</code>
      </td>
      <td style="text-align:left">The username used for connecting to FIrebolt</td>
      <td style="text-align:left">Your Firebolt username</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Password</code>
      </td>
      <td style="text-align:left">The password used for connecting to Firebolt</td>
      <td style="text-align:left">Your FIrebolt password</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>Additional Params</code>
      </td>
      <td style="text-align:left">
        <p>Leave blank to query the database using its default engine. If you wish
          to use another engine, set the following parameter:<code>engine=engineName</code>
        </p>
        <p>Replace <code>engineName</code> with the name of the engine you would like
          to use.</p>
      </td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

1. Click on the ‘Test These Settings’ button. A successful connection test results in a success message, similar to this:  ![](../.gitbook/assets/looker_test__1_.png) 

