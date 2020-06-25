/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200222
	Task:  Insert ProductStatusProfile [SabaGameSetting] RedmineID:#136210
	DB: DBCust/CustDB
*/
DECLARE @betType SMALLINT,@sportType SMALLINT
-- Saba Virtual Sports : 98
SET @betType = 1 -- Handicap
SET @sportType = 98

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.ProductStatusProfile psp WITH(NOLOCK)
				WHERE SportType =@sportType
					AND BetType = @betType			
			)
	BEGIN
		INSERT INTO [CustDB].[dbo].[ProductStatusProfile]
           ([Sporttype]
           ,[Bettype]
           ,[bitmapOrder])
		-- Saba Virtual Sports
		VALUES
		(
			@sportType,
			@betType,
			28
		)  	
	END		

