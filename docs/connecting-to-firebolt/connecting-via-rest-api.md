# Firebolt REST API

Firebolt provides several endpoints that enable you to interact with Firebolt programmatically. This topic contains an overview of the usage details when using the public REST endpoints to ingest data into Firebolt and run analytic queries.

## In this topic:

1. [Authentication](connecting-via-rest-api.md#authentication)
2. [Ingest data using the REST API](connecting-via-rest-api.md#ingesting-data-using-the-rest-api)
3. [Running queries using the REST API](connecting-via-rest-api.md#running-queries-using-the-rest-api)

## Authentication

Authenticating with Firebolt REST API requires to retrieve authentication token using the `auth` endpoint.

### Retrieve authentication token

The authentication token is a secret string that identifies your user. Perform the following request to get an authentication token:

```bash
curl --request POST 'https://api.app.firebolt.io/auth/v1/login' \
  --header 'Content-Type: application/json;charset=UTF-8' \
  --data-binary '{"username":"YOUR_USER_EMAIL","password":"YOUR_PASSWORD"}'
```

In response you will get a JSON with similar contents:

```javascript
{
  "access_token": "YOUR_ACCESS_TOKEN_VALUE",
  "expires_in": 86400,
  "refresh_token": "YOUR_REFRESH_TOKEN_VALUE",
  "scope": "offline_access",
  "token_type": "Bearer"
}
```

Extract the `access_token` value since it will be required in the following requests and will be used as your authentication token. The access token is valid for 24 hours.

### Refreshing access tokens

When the `access_token` expires and you start getting 401 HTTP errors from our API, you can either just repeat the login process or use `refresh-token` endpoint:

```bash
curl --request POST 'https://api.app.firebolt.io/auth/v1/refresh' \
  --header 'Content-Type: application/json;charset=UTF-8' \
  --data-binary '{"refresh_token":"YOUR_REFRESH_TOKEN_VALUE"}'
```

The response from this endpoint will be the same as from the login endpoint.

## Ingesting data using the REST API

Data ingestion into Firebolt using REST API requires the following steps:

1. [Get you engine's URL](connecting-via-rest-api.md#get-your-engines-url)
2. [Create an external table](connecting-via-rest-api.md#create-an-external-table)
3. [Create a fact table and import data](connecting-via-rest-api.md#create-fact-table-and-import-data)

### Get your engine's URL

When you create a database in Firebolt the next step is creating an engine and attach it to the database. The engine is composed of a physical cluster of machines that will serve requests for this database and a load balancer in front of this cluster. Each database can have many engines attached to it and one engine configured as a default engine. You need to query our API to retrieve the URL of the default engine.

**Retrieving the URL of the default engine in your database:**

```bash
curl --request GET 'https://api.app.firebolt.io/core/v1/account/engines:getURLByDatabaseName?database_name=YOUR_DATABASE_NAME' \
--header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE'
```

Which results with:

```javascript
{
    "engineUrl": "YOUR_ENGINE_URL"
}
```

**Retrieving the URL of your engine by its name:**

```bash
curl --request GET 'https://api.app.firebolt.io/core/v1/account/engines?filter.name_contains=YOUR_ENGINE_NAME' \
--header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE'
```

Which results with:

```sql
{
  "page": {
    ...
  },
  "edges": [
    {
      ...
        "endpoint": "YOUR_ENGINE_URL",
      ...
      }
    }
  ]
}
```

### Create an external table

Use the following request to create an external table:

```bash
echo "CREATE_EXTERNAL_TABLE_SCRIPT" | curl 'https://YOUR_ENGINE_URL/?database=YOUR_DATABASE_NAME' --header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE' --data-binary @-
```

Make sure to replace the following params:

`URL_TO_CONNECT` with the value of "engineUrl" in the result JSON of the query run in the "Exchange your database name to engine URL" section

`YOUR_DATABASE_NAME` with the name of the database

`CREATE_EXTERNAL_TABLE_SCRIPT` with the following SQL script:

```sql
CREATE EXTERNAL TABLE [ IF NOT EXISTS ] <external_table>
  ( <col_name> <col_type> [ , ... ])
  URL = 's3://<path_to_s3_objects>'
  [ CREDENTIALS = ( AWS_KEY_ID = '******' AWS_SECRET_KEY = '******' ) ]
  OBJECT_PATTERN = <pattern_regex>
  TYPE = ( { CSV | JSON | PARQUET } );
```

In the above script replace the following:

`<external_table>` with the desired external table name you would like to create

`<col_name>` `<col_type>` with the relevant column names and types

`<path_to_s3_objects>` with the path to the new files

`<pattern_regex>` with a pattern that identifies the files inside the bucket

For example - for the following file name: “filename.parquet” - the following should be used as `<pattern_regex>`: ‘\*.parquet’

### Create FACT Table and Import Data

**Create FACT table**

Use the following request to create a fact table:

```bash
echo "CREATE_FACT_TABLE_SCRIPT" | curl 'https://YOUR_ENGINE_URL/?database=YOUR_DATABASE_NAME' --header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE' --data-binary @-
```

Make sure to replace the following params:

`URL_TO_CONNECT` with the value of "engineUrl" in the result JSON of the query run in the “Exchange your database name to engine URL” section

`YOUR_DATABASE_NAME` with the name of the database

`CREATE_FACT_TABLE_SCRIPT` with the following SQL script:

```sql
CREATE FACT TABLE [IF NOT EXISTS] <fact_table>
(
    <column_name> <column_type>
    [ ,... ]  
)
PRIMARY INDEX <column_list>
```

In the above script, replace the following:

`<fact_table>` with the desired fact table name you would like to create

`<column_name>` `<column_type>` with the relevant column names and types

`<column_list>` with a list \(column names separated by commas, for example: column1, column2\) of columns which should be used as a primary index \(read more about primary indexes here\).

{: .note}
To boost performance even further, consider configuring an aggregating index before importing the data to the fact table. You can also add an aggregating index after data is ingested. For more information, see [Using aggregating indexes](../concepts/get-instant-query-response-time.md#get-sub-second-query-response-time-using-aggregating-indexes).


**Import Data into the FACT TABLE**

Use the following request to import data into your fact table:

```bash
echo "IMPORT_SCRIPT" | curl 'https://YOUR_ENGINE_URL/?database=YOUR_DATABASE_NAME' --header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE' --data-binary @-
```

Make sure to replace the following params:

`URL_TO_CONNECT` with the value of `"engineUrl"` in the result JSON of the query run in the “Exchange your database name to engine URL” section.

`YOUR_DATABASE_NAME` with the name of the database

`IMPORT_SCRIPT` with the following SQL script:

```sql
INSERT INTO <fact_table> SELECT * FROM <external_table>
```

In the above script, replace:

`<fact_table>` with your Firebolt table name

`<external_table>` with your external table name from which you’d like to ingest

## Running queries using the REST API

Running queries using REST API requires the following steps:

1. [Get your engine's URL](connecting-via-rest-api.md#get-your-engines-url-1)
2. [Run your queries](connecting-via-rest-api.md#run-your-queries)

### Get your engine's URL

When you create a database in Firebolt the next step is creating an engine and attach it to the database. The engine is composed of a physical cluster of machines that will serve requests for this database and a load balancer in front of this cluster. Each database can have many engines attached to it and one engine configured as a default engine. You need to query our API to retrieve the URL of the default engine.

**Retrieving the URL of the default engine in your database:**

```bash
curl --request GET 'https://api.app.firebolt.io/core/v1/account/engines:getURLByDatabaseName?database_name=YOUR_DATABASE_NAME' \
--header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE'
```

Which results with:

```javascript
{
    "engine_url": "YOUR_ENGINE_URL"
}
```

**Retrieving the URL of your engine by it's name:**

```bash
curl --request GET 'https://api.app.firebolt.io/core/v1/account/engines?filter.name_contains=YOUR_ENGINE_NAME' \
--header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE'
```

Which results with:

```sql
{
  "page": {
    ...
  },
  "edges": [
    {
      ...
        "endpoint": "YOUR_ENGINE_URL",
      ...
      }
    }
  ]
}
```

### Run your Queries

Use the following request to run your queries:

```bash
echo "SELECT_QUERY" | curl 'https://YOUR_ENGINE_URL/?database=YOUR_DATABASE_NAME' --header 'Authorization: Bearer YOUR_ACCESS_TOKEN_VALUE' --data-binary @-
```

Make sure to replace the following params:

`URL_TO_CONNECT` with the value of `"engineUrl"` in the result JSON of the query run in the “Exchange your database name to engine URL” section

`YOUR_DATABASE_NAME` with the name of the database

`SELECT_QUERY` with any select query, you would like to run. It is possible to have multiple queries run at the same time. Just add “;” after each query - for example, replace `SELECT_QUERY` with the following:

```sql
SELECT_QUERY_1;
SELECT_QUERY_2;
--more queries...
SELECT_QUERY_N;
```
