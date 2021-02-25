/*
	Created: 20210224@Tina
	Task: Insert WinLimit ProductOffer for Habanero
	Redmine: https://nexdev.net/issues/145459
	DB: DBTRANS/bodb02
*/
USE [bodb02]
GO

DECLARE @ProductID INT, @betType SMALLINT,@sportType SMALLINT
SELECT @ProductID = 61
SET @sportType = 238
SET @betType = 7001 

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.WinLimit_ProductOffer psd WITH(NOLOCK)
				WHERE 	psd.BetType = @betType
				AND ProductID = @ProductID			
			)
BEGIN
		INSERT INTO [WinLimit_ProductOffer] ([ProductID], [BetType], [IsActive_SMA], [IsActive_Company])
									VALUES (@ProductID , @betType , 1				, 0)  
END
ELSE
BEGIN
	UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	SET	IsActive_SMA = 1
	WHERE 	BetType = @betType
			AND ProductID = @ProductID
END	