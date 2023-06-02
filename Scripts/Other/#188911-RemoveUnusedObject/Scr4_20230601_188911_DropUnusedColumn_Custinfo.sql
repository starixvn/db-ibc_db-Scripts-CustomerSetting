/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20230601@Eden
	Task: DROP unsused columns on Custinfo tables [#188911]
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
--Drop Constraint of unused Columns
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_DisableNumber --DisableNumber
GO
ALTER TABLE dbo.custInfo DROP CONSTRAINT DF_custInfo_HideKeno --HideKeno
GO
--Drop unused Columns
ALTER TABLE dbo.custinfo DROP COLUMN DisableNumber          
									,HideKeno       

GO


