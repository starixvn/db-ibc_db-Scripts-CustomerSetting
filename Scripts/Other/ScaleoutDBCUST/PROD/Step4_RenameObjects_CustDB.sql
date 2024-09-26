/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 2024-09-26
	Task: Rename object CustInfoMini | CustSubMini at CustDB database [Redmine: #206823]  
	DB: DBCUST-CustDB
*/

USE CustDB

IF OBJECT_ID ('CustInfoMini', 'U') IS NOT NULL  
	EXEC sp_rename 'CustInfoMini','CustInfoMini_DEL'

IF OBJECT_ID ('CustSubMini', 'U') IS NOT NULL  
	EXEC sp_rename 'CustSubMini','CustSubMini_DEL'