/*
	Created: 20210224@Tina
	Task: Insert GameGroup for Habanero
	Redmine: https://nexdev.net/issues/145459
	DB: DBCUST/CustDB
*/

/*
DELETE FROM GameGroup WITH(ROWLOCK) WHERE GameGroupID = 21
*/

DECLARE @GameGroupID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
SET @GameGroupID =  21 	
SET @sportType = 238
SET @betType = 7001 

--Insert GameGroup
IF NOT EXISTS(	SELECT TOP 1 1 
				FROM dbo.GameGroup GG WITH(NOLOCK)
				WHERE 	GG.GameGroupID = @GameGroupID 
			)
BEGIN
	INSERT INTO [GameGroup] ([GameGroupID], [RefSportType], [RefBetType], [GroupName], [IsDeposit])
					 VALUES (@GameGroupID, @sportType, @betType, 'Level 1', 0)
END		