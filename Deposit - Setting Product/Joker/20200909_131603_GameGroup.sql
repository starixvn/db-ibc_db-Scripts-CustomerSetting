/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20200909
	Task:  Insert Game Group  [Joker] - deposit RedmineID:#131603
	DB: DBCust/CustDB
*/
DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  18 	
SET @sportType = 234
SET @betType = 6401 

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
			1
		)
	END		

