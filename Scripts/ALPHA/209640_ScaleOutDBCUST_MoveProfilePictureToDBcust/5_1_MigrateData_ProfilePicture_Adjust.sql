/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: @Helios
	Date: 21/08/2024
	Task: Scale Out DBCUST - Move CustProfilePicture and ProfilePicture to DBcust - Migrate Data [Redmine:#209640]	
	DB: DBCUST/CustDB
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DECLARE @Max_RepUpdateTime_ProfilePicture DATETIME2 

SET @Max_RepUpdateTime_ProfilePicture = 'xxx'

-- User Update Picture
UPDATE pp
	SET
		pp.Image		= pp_db_Credit.Image ,
		pp.IsDeleted	= pp_db_Credit.IsDeleted ,
		pp.RepUpdateTime	= pp_db_Credit.RepUpdateTime
FROM ProfilePicture  pp WITH (ROWLOCK ,UPDLOCK) 
INNER JOIN bodb_Credit.dbo.ProfilePicture pp_db_Credit WITH (NOLOCK) ON pp.ImageId = pp_db_Credit.ImageId
WHERE pp_db_Credit.RepUpdateTime > @Max_RepUpdateTime_ProfilePicture 
AND pp.RepUpdateTime < pp_db_Credit.RepUpdateTime