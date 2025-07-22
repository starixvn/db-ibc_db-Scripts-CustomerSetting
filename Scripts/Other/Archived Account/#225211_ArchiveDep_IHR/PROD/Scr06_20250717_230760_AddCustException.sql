/*<info serverAlias="DBSID-bodb02"></info>*/
/*
        Created: 20250717@Tacy
        Task: Add cust Exception [RedmineID: #230760]
        DB: DBSITEC1-bodb02
*/
-- Run on SiteDB1

USE bodb02
GO

INSERT INTO dbo.Task_Cust_CheckBalance_Exception(custid, remark) values(249736413, 'WGsportsINH02ClearBal')
GO