/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20210409
	Task: Insert Game Group Vgaming - Deposit RedmineID:#151583
	DB: DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@BetType SMALLINT,@SportType SMALLINT
SET @GameGroupID =  26 	
SET @SportType = 171
SET @BetType = 3801 

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

