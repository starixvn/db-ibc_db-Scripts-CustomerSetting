/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200222
	Task:  Insert ProductStatusSiteCurrency [SabaGameSetting] - UUS RedmineID:#136210
	DB: DBCust/CustDB
*/
DECLARE @betType SMALLINT,@siteID SMALLINT,@sportType SMALLINT
-- Saba Virtual Sports : 98
SET @betType = 1 -- Handicap
SET @siteID = 487 --IBCIndo
SET @sportType = 98

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductStatusSiteCurrency psp WITH(NOLOCK)
				WHERE SportType =@sportType
					AND BetType = @betType
					AND SiteID = 487
					AND Currency in (20,72)		
			)
	BEGIN
		INSERT INTO [CustDB].[dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
		-- Saba Virtual Sports
		VALUES 
		(
			@sportType,
			@betType,
			20,-- Currency
			487,-- SiteID
			0,-- IsHidden
			1,-- IsDisabled
			1-- HasSynced) 
		 )
		 INSERT INTO [CustDB].[dbo].[ProductStatusSiteCurrency]
           ([SportType]
           ,[BetType]
           ,[Currency]
           ,[SiteID]
           ,[IsHidden]
           ,[IsDisabled]
           ,[HasSynced])
		-- Saba Virtual Sports
		VALUES 
		(
			@sportType,
			@betType,
			72,-- Currency
			487,-- SiteID
			0,-- IsHidden
			1,-- IsDisabled
			1-- HasSynced) 
		 )
		 
	END		

