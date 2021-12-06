# Setting up Tableau \(Desktop\) JDBC to Firebolt

This topic describes the steps for setting up the Tableau \(Desktop\) JDBC connection to Firebolt.

## Step 1: Install the latest Firebolt JDBC Driver

Download Firebolt’s JDBC driver for Tableau from [here](connecting-via-jdbc.md#downloading-the-driver).

Put the JDBC jar file in the Tableau JDBC driver folder:

* Windows: `C:\Program Files\Tableau\Drivers`
* Mac: `~/Library/Tableau/Drivers`

## Step 2: Setup the JDBC connection in Tableau

### Pre-requisites

1. Make a note of the database name you would like to connect to in Firebolt. Also, make sure the Database has an up and running engine before you configure the connection in Looker.
2. Make a note of the username and password used to log into Firebolt.

### Configuring the Connection

1. In Tableau's UI under connections click on 'Other Databases \(JDBC\)’ ![](../.gitbook/assets/tableau_connection_config.png)  
2. The following popup appears:    ![](../.gitbook/assets/tableau_config_popup.png) 
3. Fill in the following parameters:

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
         <td style="text-align:left"><code>URL</code>
         </td>
         <td style="text-align:left">The connection string URL</td>
         <td style="text-align:left">
           <p><code>jdbc:firebolt://api.app.firebolt.io/&lt;db name&gt;</code> This enables
             you to query the database using its default engine. If you wish to use
             another engine, use the following URL:</p>
           <p><code>jdbc:firebolt://api.app.firebolt.io/&lt;db_name&gt;?engine=engineName</code>Replace
             engineName with the name of the engine you would like to use.</p>
         </td>
       </tr>
       <tr>
         <td style="text-align:left"><code>Dialect</code>
         </td>
         <td style="text-align:left">The SQL Dialect</td>
         <td style="text-align:left">PostgreSQL</td>
       </tr>
       <tr>
         <td style="text-align:left"><code>Username</code>
         </td>
         <td style="text-align:left">The username used for connecting to FIrbolt</td>
         <td style="text-align:left">Your Firebolt username</td>
       </tr>
       <tr>
         <td style="text-align:left"><code>Password</code>
         </td>
         <td style="text-align:left">The password used for connecting to Firebolt</td>
         <td style="text-align:left">Your Firebolt password</td>
       </tr>
       <tr>
         <td style="text-align:left"><code>Properties File</code>
         </td>
         <td style="text-align:left">Configures additional Tableau properties. If you wish to change any of
           these properties, edit the jdbc-firebolt.tdc file in your favorite text
           editor before uploading it (not needed in most cases)</td>
         <td style="text-align:left"><a href="https://firebolt-publishing-public.s3.amazonaws.com/repo/jdbc/jdbc-firebolt.tdc">jdbc-firebolt.tdc</a>
         </td>
       </tr>
     </tbody>
   </table>

