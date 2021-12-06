# Connecting to your database programmatically

This section explains how to connect to your database programmatically. If you are using an application like DBeaver that manages your client connections for you, then you can skip this section and move directly to this [guide](../integrations/other-integrations/setting-up-dbeaver-jdbc-connection-to-firebolt.md).

## Connecting a database by using Python

Connecting to your database in Firebolt requires authentication. Following is an example that demonstrates how to connect to your database using Python.

**Prepare in advance:**

* Firebolt username
* Firebolt password
* Database name
* Engine name (optional)

### Example: connect to a database by using Python

**Requirements:**

1. The [JayDeBeApi module](https://pypi.org/project/JayDeBeApi/) should be installed.
2. Use Python 3.0 and above.
3. Download Firebolt's latest JDBC driver from [here](../integrations/connecting-via-jdbc.md#downloading-the-driver).
4. Fill in the relevant params in lines 15 - 25.

```python
import time
import pprint
try:
    import jaydebeapi  
except:
    raise Exception("Failed to import jaydebeapi, try the following: sudo pip3 install JayDeBeApi")

# A list of queries to run. Each query wrapped by ""
queries = ["""
provide the first query
""",
"""
provide the second query
"""]

# Username, e.g: 'user@company.com'
username = 'provide the user name'

# Password, e.g: 'mypassword'
password = 'provide the password'

# Database, e.g: 'my_db'
database = 'provide the database name'

# Jar path, e.g: /users/john/jar/firebolt-jdbc-1.07-jar-with-dependencies.jar'
jar_path = "provide the path to Firebolt's jar"

# Printing the results
def type_code_repr(type_code: jaydebeapi.DBAPITypeObject) -> str:
    SHORTER_REPRS = dict(
        [
            (jaydebeapi.BINARY, "BINARY"),
            (jaydebeapi.DATE, "DATE"),
            (jaydebeapi.DATETIME, "DATETIME"),
            (jaydebeapi.DECIMAL, "DECIMAL"),
            (jaydebeapi.FLOAT, "FLOAT"),
            (jaydebeapi.NUMBER, "NUMBER"),
            (jaydebeapi.ROWID, "ROWID"),
            (jaydebeapi.STRING, "STRING"),
            (jaydebeapi.TEXT, "TEXT"),
            (jaydebeapi.TIME, "TIME"),
        ]
    )
    return SHORTER_REPRS.get(type_code, repr(type_code))

def value_repr(val):
    if str(type(val)) == "<java class 'java.math.BigInteger'>":
        return str(val)
    return repr(val)

# Connect via Firebolt's JDBC driver
def connect_jdbc():
    jdbc_url = "jdbc:firebolt://api.app.firebolt.io/{database}".format(database=database)
    jdbc_jar = (jar_path)
    try:
        # connect to Firebolt and load driver
        conn = jaydebeapi.connect("com.firebolt.FireboltDriver", jdbc_url, [username, password], jdbc_jar)
        return conn.cursor()
    except:
        raise Exception("Failed to connect via JDBC, error info can be found in logs/firebolt-jdbc.log in the directory you saved the script")

cursor = connect_jdbc()

# Run the queries
for q in queries:
    print(time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime()) + " - Executing: " + q)
    cursor.execute(q)

    # print the query results
    print('Results: ')
    fetched = cursor.fetchall() if cursor.description else []
    if cursor.description and fetched:
        # This line outputs the names of the output fields
        actual_result = ",".join([repr(x[0]) for x in cursor.description]) + "\n"
        # This line outputs the types of the output fields
        actual_result += ",".join([type_code_repr(x[1]) for x in cursor.description]) + "\n"
        # This line outputs the data themselves
        actual_result += "\n".join(map(lambda line: ",".join(map(value_repr, line)), fetched))
    else:
        actual_result = "none"

    print(actual_result)
```

{: .note}
The JayDeBeApi Python library may require specific data formatting before input. This includes:

* Datetime objects should be converted to string format

More information about potential driver issues can be found on [JayDeBeApi Github page](https://github.com/baztian/jaydebeapi).
