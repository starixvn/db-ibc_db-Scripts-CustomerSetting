/*
	Created by: Johnson
	Date: 2018-11-09
	Task: Add new columns MaxPerMatch164 for Happy 5
*/ 

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB			--
------------------------------------------------------------------

USE CUSTDB
GO

ALTER TABLE custinfo ADD maxpermatch164 MONEY NULL 
GO

ALTER TABLE custinfo ADD CONSTRAINT DF_CustInfo_maxpermatch164  DEFAULT ((0)) FOR [maxpermatch164]
GO

-- BEGIN STEP 2: DEPLOY THIS SCRIPT ON DB05/bodb_Customer		--
------------------------------------------------------------------

USE [bodb_Customer]
GO
  
ALTER TABLE custinfo_Old ADD maxpermatch164 MONEY NULL 
GO

ALTER TABLE custinfo_Old ADD CONSTRAINT DF_CustInfo_Old_maxpermatch164  DEFAULT ((0)) FOR [maxpermatch164]
GO

-- BEGIN STEP 3: DEPLOY THIS SCRIPT ON DBTP/bodb_CustHistory	--
------------------------------------------------------------------

USE [bodb_CustHistory]
GO
  
ALTER TABLE custinfo_History ADD maxpermatch164 MONEY NULL 
GO

ALTER TABLE custinfo_History ADD CONSTRAINT DF_CustInfo_History_maxpermatch164  DEFAULT ((0)) FOR [maxpermatch164]
GO
