---
layout: default
title: Connect to Firebolt with the JDBC driver
description: How to connect to Firebolt with the JDBC driver
nav_order: 5
parent: Developing with Firebolt
---

# Connect to Firebolt with the JDBC driver
{:.no_toc}

Firebolt provides a JDBC driver [(Type 4)](https://en.wikipedia.org/wiki/JDBC_driver#Type_4_driver_%E2%80%93_Database-Protocol_driver/Thin_Driver(Pure_Java_driver)){:target="_blank"} to connect to Firebolt from Java applications. This topic describes how to connect to Firebolt with the JDBC driver.

* Topic toC
{:toc}

## Step 1: Download the JDBC driver

The Firebolt JDBC driver is provided as a JAR file and requires [Java 1.8](https://java.com/en/download/manual.jsp){:target="_blank"} or later. You can use this driver to connect Firebolt to [Tableau](https://docs.firebolt.io/integrations/business-intelligence/setting-up-tableau-desktop-jdbc-to-firebolt.html){:target="_blank"}, [DBeaver](https://docs.firebolt.io/integrations/setting-up-dbeaver-jdbc-connection-to-firebolt.html){:target="_blank"} and other services that support JDBC connections.

**To download the Firebolt JDBC driver**

1.  Review the [Firebolt JDBC license terms](https://firebolt-publishing-public.s3.amazonaws.com/repo/jdbc/License.pdf){:target="_blank"}.
2.  Download the latest version of the [Firebolt JDBC driver](https://firebolt-publishing-public.s3.amazonaws.com/repo/jdbc/firebolt-jdbc-latest.jar){:target="_blank"}.

## Step 2: Connect using the URL

To connect to Firebolt resources with the JDBC driver, use the following connection URL syntax:

    jdbc:firebolt://api.app.firebolt.io/<database>?user=<username>&password=<password>&engine=<engine>

The substrings in the URL are defined as follows:

| Substring    | Description                                                  |
| ------------ | ------------------------------------------------------------ |
| \<database\> | The name of  the Firebolt database to connect to. Required, except when used with parameter **use_path_as_db=false** |
| \<user\>     | The email address associated with your Firebolt user. Required |
| \<password\> | The password used for connecting to Firebolt. Required       |
| \<engine\>   | The name of the engine to use for SQL queries. If omitted, the default engine for the specified <database> is used. |

## Optional JDBC properties

The Firebolt JDBC driver accepts additional properties to configure connections. You add these properties to a JDBC URL using parameter keys, as shown in the example below for buffer_size and connection_timeout.  

    jdbc:firebolt://api.app.firebolt.io/my_database?user=my_name&password=my_password&engine=my_engine&buffer_size=1000000&connection_timeout=10000

The table below lists the available parameter keys. All parameter keys are case-sensitive.

| **Parameter key**     | **Allowed values** | **Default value** | **Description**                                              | **Range**                                                    |
| --------------------- | ------------------ | ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| apache_buffer_size    | INT                | 65536             | Specifies the maximum amount of RAM in bytes that Firebolt uses to cache HTTP messages.<br/>The default value is acceptable for a broad range of applications. You might try reducing this value if your engine has issues related to inadequate memory. A buffer that is too small will create a bottleneck. A larger buffer is unlikely to improve throughput performance.. <br/>Max value is 2147483645. | 1 to 214748365 (although the max value is theoretical, and greatly depends on the machine) |
| buffer_size           | INT                | 65536             | Specifies the buffer used by the driver to read the response from the Firebolt API, in bytes.  The maximum value is 2147483645. | 1 to 214748365 (same as above)                               |
| connection_timeout    | INT                | -1                | Specifies the amount of time in milliseconds to wait to establish a connection before the connection is considered failed. <br/>A timeout value of zero is interpreted as an infinite timeout. A negative value is interpreted as undefined (system default if applicable). | From INTEGER.MIN (-2147483648) to INTEGER.MAX  (2147483647)  |
| defaultMaxPerRoute    | INT                | 500               | Specifies the maximum number of connections per route.       | From 1 to INTEGER.MAX                                        |
| keepAliveTimeout      | INT                | 0                 | Specifies how long, in milliseconds, a connection can safely remain idle before being reused.  A value of 0 or less leaves this parameter undefined (which means that the connection can be kept alive indefinitely). | From INTEGER.MIN (-2147483648) to INTEGER.MAX  (2147483647)  (But any value of 0 or less = undefined)  See keepAliveStrategy |
| maxTotal              | INT                | 10000             | Specifies the maximum total number of connections.           | From 1 to INTEGER.MAX                                        |
| socket_timeout        | INT                | -1                | Specifies the socket timeout in milliseconds. This is the timeout for waiting for data -- the maximum period of inactivity between two consecutive data packets. A timeout value of zero is interpreted as an infinite timeout. A negative value is interpreted as undefined (system default if applicable). | From INTEGER.MIN (-2147483648) to INTEGER.MAX  (2147483647)  |
| ssl                   | BOOLEAN            | true              | When set to true, connections use SSL / TLS certificates. This parameter also determines the port used by the JDBC. If true, it uses port 443. If false, it uses port 80. | true or false                                                |
| sslmode               | STRING             | strict            | When set to strict, the certificate is validated to ensure it is correct. If set to none, no certificate verification is used. | strict or none                                               |
| sslrootcert           | STRING             | No default value  | The absolute file path for the SSL root certificate.         |                                                              |
| timeToLiveMillis      | INT                | 60000             | Specifies the maximum lifespan of connections, in milliseconds, regardless of their **keepAliveTimeout** value.  A value of 0 or less leaves this parameter undefined (which means that the connection can be kept alive indefinitely). | From INTEGER.MIN (-2147483648) to INTEGER.MAX  (2147483647)  |
| use_connection_pool   | BOOLEAN            | 0 (false)         | When set to true (1), a connection pool is used.             | 0 or 1                                                       |
| use_objects_in_arrays | BOOLEAN            | false             | When set to true, object arrays **(Object[])** are used to store data types instead of primitive arrays. | true or false                                                |
| use_path_as_db        | BOOLEAN            | true              | When set to true (the default) or not specified, the path parameter **<database>** from the URL is used as the database name. For example, the URL, `jdbc:firebolt://api.dev.firebolt.io/database_example?compress=1`, would use the database name, **database_example**. However, when set to false, an alternate database parameter from the URL is used instead. The alternate database identifier can be added to a URL with the following syntax: `jdbc:firebolt://api.app.firebolt.io/path?database=<database>?use_path_as_db=false`. For example, the URL, `jdbc:firebolt://[api.dev.firebolt.io/database_example?database=myDbName&compress=1&use_path_as_db=false`, would use the database identifier **myDbName**. | true or false  |

### SET Parameters

In addition to the parameters specified above, any `SET` settings can also be passed as JDBC parameters.

`SET` statements can be executed in multiples as long as they follow one after another, as shown in the following example.

![Multiple SET statements example](../../assets/images/jdbc-multi-set-example.png)

## Configure the JDBC driver as a Maven dependency

If you are using Apache Maven, you can configure your projects to use the Firebolt JDBC driver to connect to your Firebolt resources. To do this, add the JDBC driver as a dependency in your project **pom.xml** file by including a link to the [Firebolt Maven repository](https://repo.repsy.io/mvn/firebolt/maven/){:target="_blank"}.

See below for an example pom.xml file:

  {: .note}
  Be sure to replace `<version>0.00</version>` with the latest (highest) version number. You can identify the latest version by viewing the version history in the [Firebolt Maven repository](https://repo.repsy.io/mvn/firebolt/maven/com/firebolt/firebolt-jdbc/){:target="_blank"}.
    
    <!-- pom.xml  -->
    
    <project ...>
        ...
        <repositories>
        		...
        		<repository>
      	    		<id>repsy</id>
      	    		<name>Firebolt Private Maven Repository on Repsy</name>
      	    		<url>https://repo.repsy.io/mvn/firebolt/maven</url>
    	    	</repository>
    	    	...
      	</repositories>
      	...
    <dependency>
                	<groupId>com.firebolt</groupId>
                	<artifactId>firebolt-jdbc</artifactId>
                	<version>0.00</version>
           </dependency>
    </project>
