/*
	Created: 20200309@Tiara
	Date: 20200309
	Task: Insert Winlimit_ProductOffer [Redmine: 128058]
	DB: DBCUST/CustDB
*/



USE [CustDB]
GO

DELETE W
FROM Winlimit_ProductOffer W WITH (ROWLOCK)
WHERE W.BettypeID IN (2401,3001)

INSERT INTO [dbo].[Winlimit_ProductOffer]([ProductID],[BettypeID],[isActive_SMA],[isActive_Company])
VALUES (41,2401,1,1)
INSERT INTO [dbo].[Winlimit_ProductOffer]([ProductID],[BettypeID],[isActive_SMA],[isActive_Company])
VALUES (41,3001,1,1)



