/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20220811@Eden
	Task: Drop unsused tables/ Columns
	Redmine: https://nexdev.net/issues/167898
	DB: DBCUST/CUSTDB and ALL REPLICATIONS
*/
--Drop unused Tables
DROP TABLE DEL_CustWinLimit
DROP TABLE DEL_Dep_CustSetting 
DROP TABLE DEL_Dep_CustSetting3rd
DROP TABLE DEL_Dep_CustBetLimitGameType_Special 

--Drop Constraint of unused Columns
GO
ALTER TABLE dbo.custSetting DROP CONSTRAINT DF_custSetting_minbet
GO
ALTER TABLE dbo.custSetting DROP CONSTRAINT DF_custSetting_maxbet
GO
ALTER TABLE dbo.custsetting3rd DROP CONSTRAINT DF_custSetting3rd_minbet
GO
ALTER TABLE dbo.custsetting3rd DROP CONSTRAINT DF_custSetting3rd_maxbet
GO

--Drop unused Columns
ALTER TABLE dbo.custSetting DROP COLUMN DEL_minbet
GO
ALTER TABLE dbo.custSetting DROP COLUMN DEL_maxbet
GO
ALTER TABLE dbo.CustSetting3rd DROP COLUMN DEL_minbet
GO
ALTER TABLE dbo.CustSetting3rd DROP COLUMN DEL_maxbet
GO

