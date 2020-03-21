/*
	Created: 20200321@Tiara
	Date: 20200321
	Task: Insert Winlimit_ProductOffer Sexy Gaming [Redmine: #130678]
	DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

DELETE W
FROM Winlimit_ProductOffer W WITH (ROWLOCK)
WHERE W.ProductID = 45

INSERT INTO [dbo].[Winlimit_ProductOffer]([ProductID],[Bettype],[isActive_SMA],[isActive_Company])
VALUES (45,3001,1,1)