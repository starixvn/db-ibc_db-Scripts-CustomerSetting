/*
	Created: 20200901@Johnson
	Task: add new column Custinfo.CustomerClass
*/

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DB05/bodb_Customer		--
------------------------------------------------------------------

USE [bodb_Customer]
GO
  
ALTER TABLE custinfo_Old ADD CustomerClass SMALLINT NULL 
GO

ALTER TABLE custinfo_Old ADD CONSTRAINT DF_CustInfo_Old_CustomerClass  DEFAULT ((0)) FOR [CustomerClass]
GO

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DBTP/bodb_CustHistory	--
------------------------------------------------------------------

USE [bodb_CustHistory]
GO
  
ALTER TABLE custinfo_History ADD CustomerClass SMALLINT NULL 
GO

ALTER TABLE custinfo_History ADD CONSTRAINT DF_CustInfo_History_CustomerClass  DEFAULT ((0)) FOR [CustomerClass]
GO