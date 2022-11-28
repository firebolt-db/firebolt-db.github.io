---
layout: default
title: RBAC (Alpha)
nav_exclude: true
search_exclude: true
toc_exclude: true
description: Learn about managing database level roles for Firebolt users.
parent: Account and user management
---

# Role-based access control (Alpha)
{: .no_toc}

Database-level, role-based access control provides the ability to control privileges and determine who can access and perform operations on specific objects in Firebolt. Access privileges are assigned to roles that are, in turn, assigned to users. 

A user interacting with Firebolt must have the appropriate privileges to use an object. Privileges from all roles assigned to a user are considered in each interaction with a secured object. 

The key concepts to understanding access control in Firebolt with DB-level RBAC are:

  **Secured object:** an entity to which access can be granted: database, engine subscription.

  **Role:** An entity to which privileges can be granted. Roles are assigned to users.

  **Privilege:** a defined level of access to an object.

  **User:** A user identity recognized by Firebolt. It can be associated with a person or a program. Each user can be assigned multiple roles.

{: .caution}
>**Alpha Release** 
>
>As we learn more from you, we may change the behavior and add new features. We will communicate any such changes. Your engagement and feedback are vital.

## Role types
Roles are entities to which privileges on securable objects are assigned. Roles are assigned to users to allow them to achieve the required tasks on the relevant objects to fulfill their business needs.

Firebolt comes out of the box with system-defined roles per each account. Those roles cannot be deleted from your account, the same as the privileges granted to the system-defined roles, which cannot be revoked.

Users granted the account admin role can create custom roles to meet specific needs. Moreover, users granted the account admin role can grant roles to other users.

## Privileges
There is a set of privileges that can be granted for every securable object.
### Database

| Privilege          | Description |
| :---------------   | :---------- |
| READ               | Enables running SELECT on the database’s tables, views, and ATTACH engines. |
| WRITE              | Enables:<br>Running CREATE/DROP tables, views, and indexes on a database’s tables.<br>Running INSERT data into a database’s tables.<br>Altering the properties of a database.<br>Dropping a database. |
| CREATE              | Enables creating new databases in the account. |

### Engine

| Privilege          | Description |
| :---------------   | :---------- |
| USAGE              | Enables using an engine and, therefore, executing queries on it. |
| OPERATE            | Enables changing the state of an engine (stop, start). |
| CREATE             | Enables creating new engines in the account. |
| DROP               | Enable executing drop engine on a specific engine. |
| MODIFY             | Enables altering any properties of an engine. |


## System-defined roles
**Account Admin**<br>
A role that has the privileges to manage users, billing, and roles alongside all database and engine privileges to existing and future objects in the account.

**DB Admin**<br>
A role with all database and engine privileges in the account.

**Viewer**<br>
A role that has READ privilege on all existing and future databases in the account alongside USAGE privilege on all existing and future engines.

**Custom roles**<br>
A user granted the Account Admin role can create custom roles. 

## Working with roles
### Create a custom role using SQL
`CREATE ROLE <role>`

**Example**
`CREATE ROLE my_role`

Creates a custom role.

| Property           | Description |
| :---------------   | :---------- |
| role               | The name of the role. |

### Create a custom role using the UI
1. In the Firebolt manager, choose the Admin icon in the navigation pane, then choose Role Management.
2. Under Role Name, enter the name of the role.

### Add Database and Engine privileges:
1. Under Role Privileges, choose the secured object you want to manage access for: choose either Databases or Engines respectively.
2. Select the required privileges on the relevant secured object. You can either choose to enable the privilege for a specific object for all existing objects or bulk enable a privilege on all secured objects (this applies to all existing and future objects).

### Delete custom role using SQL
`DROP ROLE <role>`

**Example**
`DROP ROLE my_role`

Deletes a custom role.

| Property           | Description |
| :---------------   | :---------- |
| role               | The name of the role. |


### Delete a custom role using the UI
1. In the Firebolt manager, choose the Admin icon in the navigation pane, then choose Role Management.
2. Locate the custom role you would like to delete, then choose Delete role.

### Managing users' roles
Roles can be granted to users upon creation or after a user is created. Granting roles to new users is done when the user is invited to your account using the UI.

### Manage user’s roles using SQL
`GRANT role to user`
`GRANT ROLE <role> TO USER <user_name>`

**Example**
`GRANT ROLE my_role TO USER “john@acme.com”`

Grants a role to a user.

| Property           | Description |
| :---------------   | :---------- |
| role               | The name of the role. |
| user_name          | The username (email - i.e: john@acme.com) | 


`REVOKE role from user`
`REVOKE ROLE <role> FROM USER <user_name>`

**Example:**
`REVOKE ROLE my_role FROM USER “john@acme.com”`

Revokes a role from a user.

| Property           | Description |
| :---------------   | :---------- |
| role               | The name of the role. |
| user_name          | The username (email - i.e: john@acme.com) | 

### Manage user’s roles using the UI
Managing roles for existing users is performed as follows:
1. In the Firebolt manager, choose the Admin icon in the navigation pane, then choose User Management.
2. Locate the relevant user, then on the right, choose the options icon, then choose Edit user details.
3. Select roles that need to be granted to the user and de-select roles that need to be revoked.
4. Choose Update user details to save the changes.

### Role management
Roles are managed using SQL or on the role management page in Firebolt manager. To get to this page in the Firebolt manager, choose the Admin icon in the navigation pane, then choose Role Management.

### Grant privilege to a role using SQL
`GRANT <privilege> ON { <object_type> <object_name> | ALL FUTURE <object_type_in_plural>} TO ROLE <role>`

**Example**
`GRANT READ ON DATABASE my_db TO ROLE my_role`

Grant a privilege to a role.

| Property              | Description |
| :---------------      | :---------- |
| privilege             | The privilege. | 
| role                  | The name of the role. |
| object_type           | The type of the secured object (database/engine). | 
| object_name           | The name of the secured object (database/engine). | 
| object_type_in_plural | The type of the secured object in plural(databases/engines). | 

### Grant privilege to a role using the UI
1. Under Role Privileges, choose the secured object you want to manage access for: choose either Databases or Engines respectively.
2. Select the required privileges on the relevant secured object. You can either choose to enable the privilege for a specific object for all existing objects or bulk enable a privilege on all secured objects (this applies to all existing and future objects).

### Revoke privilege from role using SQL
`REVOKE <privilege> ON { <object_type> <object_name> | ALL FUTURE <object_type_in_plural>} FROM ROLE <role>`

**Example**
`REVOKE READ ON DATABASE my_db FROM ROLE my_role`

Revokes a privilege from a role.

| Property              | Description |
| :---------------      | :---------- |
| privilege             | The privilege. | 
| role                  | The name of the role. |
| object_type           | The type of the secured object (database/engine). | 
| object_name           | The name of the secured object (database/engine). | 
| object_type_in_plural | The type of the secured object in plural(databases/engines). | 


### Revoke privilege from role using the UI
1. Under Role Privileges, choose the secured object you want to manage access for: choose either Databases or Engines respectively.
2. De-Select the privileges that must be revoked on the relevant secured object. 

## Known limitations and future release plans

**Support RBAC for more objects**

Currently, RBAC is supported on the DB and engine level only. Support for managing access on the table and view levels will be supported in future releases.
