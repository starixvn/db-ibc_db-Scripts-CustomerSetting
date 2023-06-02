/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*	
	Created: 20230601@Eden
	Task: Drop unsused Columns of custinfo_history table [#188911]
	DB: DBTP-bodb_CustHistory
*/
USE bodb_CustHistory
GO

--Drop Constraint of unused Columns
ALTER TABLE dbo.custinfo_history DROP CONSTRAINT DF__CustInfo___Disab__00551192 --DisableNumber
GO
ALTER TABLE dbo.custinfo_history DROP CONSTRAINT DF_custInfo_HideKeno --HideKeno
GO

--Drop unused Columns
ALTER TABLE dbo.custinfo_history DROP COLUMN DisableNumber          
											,HideKeno       

GO