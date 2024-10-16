/*
*
* ===============================================================================
*
* This file is used to create the database objects needed to for this project.
* It creates the database, tables, indexes, and inserts data into the tables.
* The data for the patients and doctors are fictional and not meant to represent
* any real person or persons. The data used for the patients and doctors came
* from https://randomuser.me, it is a good site for producing mock data for users
* or people.
*
* ================================================================================
*
*
* ================================================================================
*
* To run this script:
*
* 1. Save this script along with the CSV files in C:\hospital_db or you can
*    rename the DataSourceLocation to where you have this script located. If
*    you save it in your C drive, you can delete it after the script is ran.
*
* 2. Open this script in SSMS and ensure that you have SQLCMD mode turned on.
*
* 3. Execute the script inside of SSMS.
*
* ================================================================================
*
*/

:SETVAR DataSourceLocation "C:\hospital_db\"

SET NOCOUNT OFF

GO

USE master

GO

PRINT ''
PRINT '==============================='
PRINT '                               '
PRINT ' Dropping hospital_db Database '
PRINT '                               '
PRINT '==============================='

IF EXISTS (SELECT [name] FROM master.sys.databases WHERE [name] = N'hospital_db')
   DROP DATABASE hospital_db

GO

PRINT ''
PRINT '==============================='
PRINT '                               '
PRINT ' Creating hospital_db Database '
PRINT '                               '
PRINT '==============================='

CREATE DATABASE hospital_db

GO

PRINT ''
PRINT '=========================='
PRINT '                          '
PRINT ' Switching to hospital_db '
PRINT '                          '
PRINT '=========================='

USE hospital_db

GO

PRINT ''
PRINT '================='
PRINT '                 '
PRINT ' Creating tables '
PRINT '                 '
PRINT '================='

CREATE TABLE allergies (
   allergy_id INT PRIMARY KEY IDENTITY(1, 1),
   allergy_name NVARCHAR(20) NOT NULL,
   CONSTRAINT UN_allergies_allergy_name UNIQUE(allergy_name)
)

GO

CREATE TABLE patients (
   patient_id INT PRIMARY KEY IDENTITY(1, 1),
   first_name NVARCHAR(25) NOT NULL,
   last_name NVARCHAR(25) NOT  NULL,
   gender CHAR(1) NOT NULL,
   birth_date DATE NOT NULL,
   height INT NOT NULL,
   weight DECIMAL(5, 2) NOT NULL
)

GO

CREATE TABLE patient_allergies (
   allergy_id INT NOT NULL,
   patient_id INT NOT NULL,
   reaction VARCHAR(30) NOT NULL,
   CONSTRAINT PK_patient_allergies PRIMARY KEY (allergy_id, patient_id),
   CONSTRAINT FK_patient_allergies_allergy FOREIGN KEY (allergy_id)
       REFERENCES allergies (allergy_id),
   CONSTRAINT FK_patient_allergies_patient FOREIGN KEY (patient_id)
       REFERENCES patients (patient_id)
)

GO

CREATE TABLE specialty (
   specialty_id INT PRIMARY KEY IDENTITY(1, 1),
   specialty_name VARCHAR(50) NOT NULL,
   CONSTRAINT UN_specialty_name UNIQUE(specialty_name)
)

GO

CREATE TABLE doctors (
   doctor_id INT PRIMARY KEY IDENTITY(1, 1),
   first_name VARCHAR(25) NOT NULL,
   last_name VARCHAR(25) NOT NULL,
   specialty_id INT NOT NULL,
   CONSTRAINT FK_doctors_specialty FOREIGN KEY (specialty_id)
       REFERENCES specialty (specialty_id)
)

GO

CREATE TABLE admissions (
   admission_id INT PRIMARY KEY IDENTITY(1, 1),
   admission_date DATE NOT NULL,
   discharge_date DATE NOT NULL,
   diagnosis VARCHAR(50) NOT NULL,
   patient_id INT NOT NULL,
   doctor_id INT NOT  NULL,
   CONSTRAINT CK_admissions_discharge_date CHECK(discharge_date >= admission_date),
   CONSTRAINT FK_admissions_patient FOREIGN KEY (patient_id)
       REFERENCES patients (patient_id),
   CONSTRAINT FK_admissions_doctor FOREIGN KEY (doctor_id)
       REFERENCES doctors (doctor_id)
)

GO

PRINT ''
PRINT '=================='
PRINT '                  '
PRINT ' Creating indexes '
PRINT '                  '
PRINT '=================='

CREATE INDEX IX_patients_first_name ON patients (first_name)
CREATE INDEX IX_patients_last_name ON patients (last_name)
CREATE INDEX IX_patients_birth_date ON patients (birth_date)

CREATE INDEX IX_specialty_name ON specialty (specialty_name)

CREATE INDEX IX_doctors_last_name ON doctors (last_name)
CREATE INDEX IX_doctors_specialty ON doctors (specialty_id)

CREATE INDEX IX_admissions_admission_date ON admissions (admission_date)
CREATE INDEX IX_admissions_discharge_date ON admissions (discharge_date)
CREATE INDEX IX_admissions_patients ON admissions (patient_id)
CREATE INDEX IX_admissions_doctor ON admissions (doctor_id)

GO

PRINT ''
PRINT '====================================='
PRINT '                                     '
PRINT ' Inserting data into allergies table '
PRINT '                                     '
PRINT '====================================='

BULK INSERT allergies FROM '$(DataSourceLocation)allergies.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)

PRINT ''
PRINT '===================================='
PRINT '                                    '
PRINT ' Inserting data into patients table '
PRINT '                                    '
PRINT '===================================='

BULK INSERT patients FROM '$(DataSourceLocation)patients.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)

PRINT ''
PRINT '=========================================='
PRINT '                                          '
PRINT ' Insert data into patient_allergies table '
PRINT '                                          '
PRINT '=========================================='

BULK INSERT patient_allergies FROM '$(DataSourceLocation)patient_allergies.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)

PRINT''
PRINT '====================================='
PRINT '                                     '
PRINT ' Inserting data into specialty table '
PRINT '                                     '
PRINT '====================================='

BULK INSERT specialty FROM '$(DataSourceLocation)specialty.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)

PRINT ''
PRINT '==================================='
PRINT '                                   '
PRINT ' Inserting data into doctors table '
PRINT '                                   '
PRINT '==================================='

BULK INSERT doctors FROM '$(DataSourceLocation)doctors.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)

PRINT ''
PRINT '======================================'
PRINT '                                      '
PRINT ' Inserting data into admissions table '
PRINT '                                      '
PRINT '======================================'

BULK INSERT admissions FROM '$(DataSourceLocation)admissions.csv'
WITH (
   CHECK_CONSTRAINTS,
   DATAFILETYPE = 'char',
   FIELDTERMINATOR = ',',
   ROWTERMINATOR = '\n',
   KEEPIDENTITY,
   TABLOCK
)