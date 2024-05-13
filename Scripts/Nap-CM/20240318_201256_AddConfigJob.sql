/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240320@Winfred
	DB: DBCUST/CustDB
	Task:  Add Config Job 
	Revisions:
		- 20240320@Winfred:  CCMgt - Update SP to call loop for updating policies [RedmineID: #201256]
*/
INSERT INTO SystemSettings (VName, VValue)
SELECT 'CustomerClass_Status','0'