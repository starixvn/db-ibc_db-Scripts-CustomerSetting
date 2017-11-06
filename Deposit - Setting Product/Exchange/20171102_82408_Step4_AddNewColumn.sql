/*
	Created by: Winnie
	Date: 2017-11-02
	Task: Exchange Product - [Redmine: #66797]
	alter table Dep_ProductSettingDetail
	add the column MinDefaultValue 

*/ 

-- BEGIN STEP 1: DEPLOY THIS SCRIPT ON DBCUST/CustDB			--
------------------------------------------------------------------

USE [CustDB]
GO
  
ALTER TABLE [dbo].Dep_ProductSettingDetail ADD MinDefaultValue DECIMAL(19,8)

GO
