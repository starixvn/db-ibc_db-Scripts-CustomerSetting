/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200805
	Task:  Insert Game Group [PG Game] - Credit RedmineID:#137763
	DB: DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  15 	
SET @sportType = 232
SET @betType = 6001 

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

