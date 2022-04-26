---
layout: default
title: Working with engines using the Firebolt Manager
description: Learn about using the Firebolt manager (web application) to work with Firebolt engines, which provide the compute power for Firebolt queries.
nav_order: 4
parent: Working with engines
---

# Working with engines using the Firebolt Manager

You can create, edit, and delete an engine using the Firebolt Manager. Keep in mind that an engine must be stopped for you to perform these tasks.

For more information about settings and their meanings, see [Understanding engine properties](understanding-engine-fundamentals.md#understanding-engine-properties).

## To create or edit an engine using the Firebolt Manager

1. If you are creating a new database, from the **Databases** list, choose **New database**.  
   **—or—**  
   If you are adding an engine to an existing database, choose the ellipses on the far right of the database row, and then choose **Edit database**.

2. To create a new engine, choose **Add new engine**.  
   **—or—**  
   To edit an existing engine, under **Database engines**, choose the engine to edit.  

3. Enter an **Engine name**. Engine names automatically begin with the name of the database they are attached to.  

4. Choose an **Engine type**.  

5. Under **Engine spec**, choose a Firebolt engine name from the list. **Total engine stats** and the engine list in the left pane update to reflect your selection.  

6. Under **Engine scale**, select a scale factor of 1 to 128.  
**Total engine stats** and the engine list in the left pane update to reflect your selection.  

7. Select a **Warmup method** and **Auto-stop** duration.  

8. Choose **Update database**.  
You return to the **Databases** list, and your database appears under **Database Engines**.

## To delete an engine using the Firebolt Manager
* From the **Databases** list, under **Database engines**, choose the delete icon for the database you want to delete.

## Starting and stopping engines

You can start and stop engines in the Firebolt Manager using any of the methods below.

* **From the SQL Workspace** – You can choose **Run Script**. If the selected engine isn’t running, you can choose to start it. You can also select an engine from the list at the bottom of the scripting tab and choose **Start** or **Stop**.
* **From the Databases list** – Choose the ellipses to the far right of the database row, choose **Edit database**, select the engine you want to stop, and then choose **Stop**.
* **From the Engines list** – Choose the ellipses to the far right of the engine row, and then choose **Start** or **Stop**.
