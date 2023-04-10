---
layout: default
title: Using the CLI
description: Learn to install, configure, and use the Firebolt CLI.
nav_order: 4.1
---

# Using the Firebolt CLI  
{: .no_toc}

The Firebolt command line interface (CLI) is a tool for connecting to Firebolt, managing Firebolt resources, and executing queries from the command line. The CLI is particularly useful for scripting and automated jobs like those running inside a Docker container.

This topic covers installation, configuration, and running queries. For a list of available commands or command options, use the `--help` option with any command.

* Topic toC
{:toc}

## Prerequisites

* The CLI requires Python version 3.7 or later along with the pip package installer. For more information, see the [Python](https://www.python.org/downloads/) web page.

* You need a Firebolt account and login credentials.

## Installation and upgrade

* You can use `pip` to install the CLI from the command line as shown in the example below.  

  ```
  $ pip install firebolt-cli
  ```

* After you run `pip`, verify the installation by checking the `firebolt` version, as shown in the example below.  

  ```
  $ firebolt --version
  ```

  If successful, the command returns the current version of the CLI.

  ```
  firebolt, version 0.3.0
  ```

* Use `pip` occasionally to upgrade to the latest version as shown in the example below.  

  ```
  pip install firebolt-cli --upgrade
  ```

  You can check version history and release notes using the [GitHub repository for the Firebolt CLI](https://github.com/firebolt-db/firebolt-cli/tags).
  
* Firebolt provides tab completion for Bash (version 4.4 and later), Zsh, and Fish. Tab completion is based on the `Click` library. For more information, see [Click documentation](https://click.palletsprojects.com/en/8.1.x/shell-completion/#enabling-completion).

Use the following guidance to enable tab completion for the shell that you use.

  * **Bash**  
  Add the line shown below to `~/.bashrc`.  

  ```shell
  eval "$(_FIREBOLT_COMPLETE=bash_source firebolt)"
  ```

  * **Zsh**  
  Add the line shown below to `~/.zshrc`.

  ```shell
  eval "$(_FIREBOLT_COMPLETE=zsh_source firebolt)"
  ```
  * **Fish**  
  Add the line shown below to `~/.config/fish/completions/firebolt.fish`.

  ```shell
  eval (env _FIREBOLT_COMPLETE=fish_source firebolt)
  ```

## Configuring CLI parameters

CLI commands use the following configuration parameters for your Firebolt account when they run.

| `username`            | Required. The email address associated with your Firebolt user.           |
| `password`           |  Required. The password associated with the `username`. The CLI encrypts and securely stores passwords using the [Python keyring library](https://keyring.readthedocs.io/en/latest/) if encryption is enabled on your respective OS.              |
| `account-name`       |  The name of your Firebolt account in all lowercase characters. For help finding your account name, see [Firebolt account concepts and terminology](./managing-your-account/concepts-and-terminology.md#firebolt-account). |
| `database-name`      |  The name of the database to connect to.            |
| `engine-name` |  The name or URL of the engine to use for SQL queries.    |

You can establish and change configuration settings by:

* [Using the configure command](#using-the-configure-command). This saves configuration parameters as defaults for repeated CLI sessions.

* [Passing configuration parameters as command options](#passing-configuration-parameters-as-command-options). This makes one-time configuration changes for a specific command.

* [Using environment variables](#using-environment-variables). This adds flexibility and isolates credentials for additional security.


### Using the configure command

The `firebolt configure` command saves configuration parameters as defaults for repeated access across sessions. When you enter this command without options, the CLI prompts you to enter each configuration parameter in succession. Each prompt also shows the current parameter value in square brackets.

To update the defaults for individual parameters, you can pass them as `configure` options. This is shown in the example below for `username` and `account-name`.

```
$ firebolt configure --username my_other_user_name --account-name my_other_account
```

You can use the command below to delete all configuration parameter values.

```
firebolt configure reset
```

### Passing configuration parameters as command options

You can use options with CLI commands to specify parameter overrides. Parameter values specified this way apply only to that command. To see available configuration parameters for a command, use the `--help` option.

For example, the example command below opens interactive query mode with the database set to a different database and engine than the default configuration.

```
$ firebolt query --database-name my_other_database --engine-name my_other_database_Ingest
```

### Using environment variables

You can use operating system or Docker environment variables to specify configuration parameters for executing commands. Reserved environment variables allow you to set configuration parameter defaults for Docker. For more information, see [Using the CLI with docker](#using-the-cli-with-docker).

You can specify configuration values as operating system environment variables as shown in the example below.

First, define the variables.

```
$ export FB_DB2=my_other_database
$ export FB_ENG2=my_other_database_Ingest
```

{: .note}
Replace the `export` command with `set` on Windows.

Then CLI commands can then reference the variables as shown below.

```
$ firebolt query --database-name $FB_DB2 --engine-name $FB_ENG2
```

## Running queries

Use the `query` command to run query statements. You can run queries in interactive mode or submit a query script using the `--query` option. `SELECT` queries return results in ASCII table format as shown below.

```
+--------------+-------------+-------------+--------------+
|   l_orderkey |   l_partkey |   l_suppkey | l_shipdate   |
+==============+=============+=============+==============+
|      5300614 |       66754 |        4273 | 1993-02-06   |
+--------------+-------------+-------------+--------------+
|      5300614 |      131772 |        6799 | 1993-02-21   |
+--------------+-------------+-------------+--------------+
|      5300615 |      106001 |        8512 | 1997-12-10   |
+--------------+-------------+-------------+--------------+
|      5300615 |      157833 |        7834 | 1997-12-01   |
+--------------+-------------+-------------+--------------+
|      5300640 |       36106 |        8610 | 1994-09-10   |
+--------------+-------------+-------------+--------------+
```

Before you run queries, the default or specified engine must be on. The example CLI command below checks the status of an engine named `Tutorial_Ingest`.

```
$ firebolt engine status Tutorial_Ingest
```

The command returns an engine status:

```
Engine Tutorial_Ingest current status is: ENGINE_STATUS_SUMMARY_STOPPED
```

You can start a stopped engine by using the `start` CLI command. The `--wait` option in the example below delays the command response until the engine is done starting up.

```
$ firebolt engine start Tutorial_Ingest --wait
```

After the engine starts, Firebolt displays the message shown below.

```
Engine Tutorial_Ingest is successfully started
```

### Running queries interactively

Interactive mode allows you to enter SQL syntax and run a query directly on the command line. To start interactive mode, use the `query` command with no options, as shown below.

```
firebolt query
```

If the specified engine is on and ready to run scripts, the message `Connection succeeded` appears. The command prompt changes to `firebolt>`, as shown below.

```
firebolt>
```

Enter SQL statements at the `firebolt>` prompt. Pressing **Enter** starts a new line, and pressing **Enter** after a line that ends with a semicolon runs the query, as shown below.

```
firebolt> SELECT * FROM your_table
    ...> ORDER BY l_shipdate
    ...> LIMIT 5;
```

You can also write a query on a single line, as shown below.

```
firebolt> SELECT * FROM your_table ORDER BY l_shipdate LIMIT 5;
```

To exit interactive mode, use the `.exit` command .

```
firebolt> .exit
```

### Submitting a query script

You can use the `firebolt query` command with the `--sql` option to submit a SQL script. When submitting SQL this way, multiple query statements in a script can be executed in succession. Each command is terminated by a semi-colon. Enclose the script in quotation marks as shown in the example below. Linux line prompts are shown for clarity.

```bash
dataengineer@MYDESKTOP: ~/fb-jobs$ firebolt query --sql "CREATE FACT TABLE transactions
> (
>     transaction_id    BIGINT,
>     sale_date         DATETIME,
>     store_id          INT,
>     product_id        INT,
>     units_sold        INT
> )
> PRIMARY INDEX store_id, product_id;
>
> CREATE DIMENSION TABLE dim_store
> (
>     store_id      INT,
>     store_number  INT,
>     state         TEXT,
>     country       TEXT
> );
>
> CREATE DIMENSION TABLE dim_product
> (
>     product_id        INT,
>     product_name      TEXT,
>     product_category  TEXT,
>     brand             TEXT
> );"
```

## Using the CLI with Docker

To use the CLI with Docker, download and install it for your operating system. Use the command shown below to pull the latest Firebolt CLI package into a docker container.

```
docker pull ghcr.io/firebolt-db/firebolt-cli:latest
```

### Setting configuration parameters using Docker environment variables

You can set values for configuration parameters using Docker environment variables. For more information, see [Set environment variables](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file) in Docker docs.

The CLI has reserved environment variables that you use to set default values for commands that run in Docker, similar to using `firebolt configure` to establish defaults for your operating system. Reserved environment variables are listed below.

{: .note}
When using Docker, you must specify the username and password using the reserved environment variables `FIREBOLT_USERNAME` and `FIREBOLT_PASSWORD`.

**Reserved environment variables**

* `FIREBOLT_USERNAME` Required. The email address associated with your Firebolt user.
* `FIREBOLT_PASSWORD` Required. The password for the specified user.
* `FIREBOLT_DATABASE_NAME` The name of the Firebolt database to use.
* `FIREBOLT_ACCOUNT_NAME` The name of your Firebolt account in all lowercase characters.
* `FIREBOLT_ENGINE_NAME` The engine name. Alternatively, the URL of the engine in the form `https://api.app.firebolt.io/core/v1/account/engines/<engine_id>`.
* `FIREBOLT_ACCESS_TOKEN` For more information, see [Use tokens for authentication](developing-with-firebolt/firebolt-rest-api.md#use-tokens-for-authentication).

In the example below, Docker runs the CLI command `engine list` in a container using the latest firebolt-cli package. The command returns a table with the `name`, `status`, and `region` of all engines in an account.

```
docker run -e FIREBOLT_USERNAME="your_username"\
           -e FIREBOLT_PASSWORD="your_password"\
           ghcr.io/firebolt-db/firebolt-cli:latest engine list
```
