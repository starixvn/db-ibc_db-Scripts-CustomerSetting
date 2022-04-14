/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220413@Johnson
	Task: Dep- Virtual Games - Incorporate 6 new games of Mine & Tower scheme [#RedmineID:#169418]
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO

UPDATE Dep_ProductSettingDetail
SET SettingStatus = 0
WHERE ProductSettingID = 34
	AND bettype = 4605