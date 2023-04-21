/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20230418
	Task:  Insert Game Group Vgaming - Deposit RedmineID:#186800
	DB: DBCust/CustDB
*/
USE CustDB
GO

DECLARE @GameGroupID SMALLINT ,@BetType SMALLINT,@SportType SMALLINT
SET @GameGroupID =  44
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
			@sportType,
			@betType,
			'Level 2',
			1
		)
	END	


