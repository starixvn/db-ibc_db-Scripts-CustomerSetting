/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created:	Winfred
	Date:		20210324
	Task:		Insert Game Group [Creative Gaming] - Credit RedmineID:#146016
	DB:			DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  23 	
SET @sportType = 167
SET @betType = 7301 

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
			@sportType,
			@betType,
			'Level 1',
			0
		)
	END		

