/*<info serverAlias="DBTRANS-bodb02"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  add WinLimit_ProductOffer for Joker RedmineID:#131603
	DB: DBTRANS/bodb02
*/
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.WinLimit_ProductOffer psd WITH(NOLOCK)
				WHERE 	psd.BetType = 4001
				AND ProductID = 56			
			)
	BEGIN
		 INSERT INTO [WinLimit_ProductOffer]
           ([ProductID]
           ,[BetType]
           ,[IsActive_SMA]
           ,[IsActive_Company])
         VALUES
         (
			 56, --	ProductID
			 4001, -- BetType
			 1, -- IsActive_SMA
			 0   -- IsActive_Company
         )  
	END
ELSE
	BEGIN
	   UPDATE WinLimit_ProductOffer WITH(ROWLOCK)
	   SET	IsActive_SMA = 1
	   WHERE 	BetType = 4001
				AND ProductID = 56
	END	