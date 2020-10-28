/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201028
	Task: Update prefix SU from ACCTEST [ RedmineID:#142239 ]
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE Acc_SuperPrefix 
SET AllowNewSuper = 1
WHERE GroupName  = 'ACCTEST' AND Prefix = 'SU'