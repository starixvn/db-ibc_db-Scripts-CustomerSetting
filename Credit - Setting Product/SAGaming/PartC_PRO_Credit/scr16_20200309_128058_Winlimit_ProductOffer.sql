/*
	Created: 20200309@Tiara
	Date: 20200309
	Task: Insert Winlimit_ProductOffer [Redmine: 128058]
	DB: DBTRANS/bodb02
*/

USE [bodb02]
GO

IF EXISTS (SELECT 1 FROM Winlimit_ProductOffer W WITH (NOLOCK) WHERE W.ProductID = 39 AND W.BetType = 3001)
	UPDATE W
	SET W.IsActive_SMA = 1
	FROM Winlimit_ProductOffer W WITH (ROWLOCK, UPDLOCK)
	WHERE W.ProductID = 39 AND W.BetType = 3001
ELSE
	INSERT INTO [dbo].[Winlimit_ProductOffer]([ProductID],[Bettype],[isActive_SMA],[isActive_Company])
	VALUES (39,3001,1,0)





