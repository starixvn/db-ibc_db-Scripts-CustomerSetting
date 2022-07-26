/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220714
	Task:  Insert Game Group [PP Game] - Deposit RedmineID:#175454
	DB: DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  38 	
SET @sportType = 248
SET @betType = 4101 

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
			'Level 2',
			1
		)
	END	


