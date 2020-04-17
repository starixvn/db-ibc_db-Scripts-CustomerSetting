/*
	Created: 20200417@Tiara
	Date: 20200417
	Task: Add column MaxChoice for ProductSettingDetail [Redmine: #131853]
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

ALTER TABLE ProductSettingDetail
ADD MaxChoice TINYINT;
