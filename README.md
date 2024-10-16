# SQL Server Hospital Database

## About

This project was inspired by [sql-practice](https://www.sql-practice.com/), the key difference is that
I added an extra table for doctor specializations, created a table for allergies and a table for patient
allergies with an extra 'reaction' column. This project allows users to install the database and practice
writing SQL queries. It can be used to practice basic select, insert, update, and delete statements. You
can also practice joins, aggregates, subquries, creating views, triggers, functions, and stored procedures.

The data within the tables is completely fictional and does not represent any real person or persons.
The data for the patients and doctors came from [randomuser.me](https://randomuser.me/), a great site
for generating random information for user information. The patient and doctor data in the admissions
table is not meant to represent real data, so the doctors' specialties might not line up with the patients'
diagnosis, as this is meant for mere learning purposes only.

## Install and Use the Database

### Prerequisite

MS SQL Server - You have to download and install [Microsoft SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads),
once you download it, you can just follow the installation wizard.

SSMS - You have to download and install [SQL Server Management Studio](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16). You can follow this [guide](https://learn.microsoft.com/en-us/sql/ssms/quickstarts/ssms-connect-query-sql-server?view=sql-server-ver16) to learn how to connect to a database and how
to use SSMS.

### Cloning the Repo

Once you have MS SQL Server and SSMS installed on you computer, you have to clone this repo to your local machine.

```bash
git clone https://github.com/Manuel7806/sql-server-hospital-database.git
```

After you have cloned the repo open SSMS go `file` -> `open` and select `folder` and then open the cloned folder.
You will have the CSV file along with the script to create and seed the database. Inside the `create.sql`
script there is a variable named `DataSourceLocation`, you can rename that variable to the location of where
you have the cloned repo at or you can move the cloned repo into the same directory as it is in the script.

Once you have either changed the variable or moved the repo, make sure you have SQLCMD mode activated in SSMS.
You can do that by going to `query` and click on `SQLCMD Mode`. After you have enabled SQLCMD mode you can execute
the script and it will create the database objects and insert the data into the tables.

## Run Queries

To run queries against the database, in the object explorer pane right click on the databases folder and select `refresh`,
you should now see the newly created hospital_db database. You can right click on the hospital_db database and select
`New Query`, a new query window will open in the middle of the window, you can write and run your queries from there.
