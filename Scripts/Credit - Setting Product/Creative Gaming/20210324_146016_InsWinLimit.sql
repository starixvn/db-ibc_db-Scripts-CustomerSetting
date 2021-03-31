/*<info serverAlias="DBTRANS-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20210324
	Task:  Add WinLimit_ProductOffer for Creative Gaming RedmineID:#146016
	DB: DBTRANS/bodb02
*/
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.WinLimit_ProductOffer psd WITH(NOLOCK)
				WHERE 	psd.BetType = 4001
				AND ProductID = 62			
			)
	BEGIN
		 INSERT INTO [WinLimit_ProductOffer]
           ([ProductID]
           ,[BetType]
           ,[IsActive_SMA]
           ,[IsActive_Company])
         VALUES
         (
			 62, --	ProductID
			 4001, -- BetType
			 1, -- IsActive_SMA
			 0   -- IsActive_Company
         )  
	END
ELSE
	BEGIN
	   UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	   SET	IsActive_SMA = 1
	   WHERE BetType = 4001 AND ProductID = 62
	END	