/*
	Created: 20181011@Winnie
	Task: Update product profile for Esports Deposit PRO
	DB: DBCUST/CustDB
*/

USE [CustDB]
Go

UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
	SET SettingStatus=0
WHERE ProductSettingID IN (24,25)