/*
	Created: 20200321@Tiara
	Date: 20200321
	Task: Insert Winlimit_ProductOffer Sexy Gaming [Redmine: #130678]
	DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = 45 AND W.BetType = 3101)
	UPDATE W
	SET W.IsActive_SMA = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
ELSE
	INSERT INTO [dbo].[Winlimit_ProductOffer]([ProductID],[Bettype],[isActive_SMA],[isActive_Company])
	VALUES (45,3101,1,0)
