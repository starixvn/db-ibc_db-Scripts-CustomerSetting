/*	
	Creator: Elodie
	Date: 20180828
	Task: Delete all data of functionID = 118 in revelant table
	DB: DBEAS/bodb_EAS
*/
USE bodb_EAS
GO

DECLARE @FunctionId INT = 118

--1 row
DELETE FROM dbo.eaFunction WHERE FuncID = @FunctionId

--138 rows
DELETE FROM dbo.eaUserPolicy WHERE FuncID = @FunctionId

--42 rows
DELETE FROM dbo.eaGroupPolicy WHERE FuncID = @FunctionId