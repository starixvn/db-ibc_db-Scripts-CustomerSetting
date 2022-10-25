/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20221025
	Task:	 Add new column [#RM:174513]
	DB:		 DBCUST/CUSTDB 
*/

USE CUSTDB
GO
ALTER TABLE ProductSettingDetail ADD ChildDisplayOrder INT
GO