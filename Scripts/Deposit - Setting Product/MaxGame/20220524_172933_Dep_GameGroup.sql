/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220524
	Task: Insert Game Group MaxGame - Deposit RedmineID:#172933
	DB: DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@BetType SMALLINT,@SportType SMALLINT
SET @GameGroupID =  37 	
SET @SportType = 237
SET @BetType = 5401 

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.GameGroup psd WITH(NOLOCK)
				WHERE 	psd.GameGroupID = @GameGroupID 
					AND RefSportType = @sportType 
					AND RefBetType  = @betType 		
			)
	BEGIN
		INSERT INTO [GameGroup]
           ([GameGroupID]
           ,[RefSportType]
           ,[RefBetType]
           ,[GroupName]
           ,[IsDeposit])
		VALUES
		(
			@GameGroupID,
			@SportType,
			@BetType,
			'Level 1',
			1
		)
	END		

