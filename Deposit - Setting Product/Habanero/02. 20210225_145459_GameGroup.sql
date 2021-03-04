/*
	Created: 20210224@Tina
	Task: Insert GameGroup for Habanero - DEPOSIT
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO

DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  22 	
SET @sportType = 238
SET @betType = 7001 

IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.GameGroup psd WITH(NOLOCK)
				WHERE 	psd.GameGroupID = @GameGroupID 
					AND RefSportType = @sportType 
					AND RefBetType  = @betType 		
			)
BEGIN
	INSERT INTO [GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName],[IsDeposit])
		   VALUES			(@GameGroupID , @sportType	  , @betType	, 'Level 1'	 , 1 )
END		

/*
SELECT *
FROM GameGroup GG WITH (NOLOCK)
WHERE GG.GameGroupID = 22
*/