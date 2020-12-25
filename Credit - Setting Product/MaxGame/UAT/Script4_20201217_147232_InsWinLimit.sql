/*<info serverAlias="DBTRANS-bodb02"></info>*/
/*
	Created: Eden@20201216
	Task: Add WinLimit_ProductOffer for Max Game [RM:#147232]
	DB: DBTRANS/bodb02
*/
DECLARE @ProductID TINYINT = 60, @Bettype INT =  4001

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.WinLimit_ProductOffer psd WITH(NOLOCK)
				WHERE 	psd.BetType = @Bettype
				AND ProductID = @ProductID			
			)
BEGIN
		INSERT INTO [WinLimit_ProductOffer]
        ([ProductID]
        ,[BetType]
        ,[IsActive_SMA]
        ,[IsActive_Company])
        VALUES
        (
			@ProductID, --	ProductID
			@Bettype, -- BetType
			1, -- IsActive_SMA
			0   -- IsActive_Company
        )  
END
ELSE
BEGIN
	UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	SET	IsActive_SMA = 1
	WHERE 	BetType = @Bettype
			AND ProductID = @ProductID
END	