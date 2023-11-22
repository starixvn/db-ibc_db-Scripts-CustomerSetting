/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20231101
	Task: Drop unused table - Age_DomainList [Redmine:#194024] 
	DB:	DBCUST-CustDB
*/
USE CustDB
GO

--Unused SPs
DROP PROCEDURE Acc_DomainListIns_xtest
GO
DROP PROCEDURE Acc_DomainListUpd_xtest
GO
DROP PROCEDURE Acc_DomainListDel_xtest 
GO
DROP PROCEDURE Age_DomainListSel_xtest
GO

DROP PROCEDURE Acc_DomainListIns 
GO
DROP PROCEDURE Acc_DomainListUpd 
GO
DROP PROCEDURE Acc_DomainListDel 
GO
DROP PROCEDURE Age_DomainListSel 
GO

--Unused table
DROP TABLE [dbo].[Age_DomainList];
GO