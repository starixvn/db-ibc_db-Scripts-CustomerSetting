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

DECLARE @Max_RepUpdateTime_CustProfilePicture DATETIME2 

SET @Max_RepUpdateTime_CustProfilePicture = 'xxx'


-- New User Login & Init Picture Profile
INSERT INTO CustProfilePicture 
	(
		CustId
	    , ImageId
	    , Modified
	    , RepUpdateTime
	    , IsDeleted
	)
SELECT  
		CustId
	    , ImageId
	    , Modified
	    , RepUpdateTime
	    , IsDeleted
FROM bodb_Credit.dbo.CustProfilePicture WITH (NOLOCK)
WHERE RepUpdateTime > @Max_RepUpdateTime_CustProfilePicture
AND Modified IS NULL
	

-- User Login & Adjust Picture Profile
UPDATE cpp
	SET
		cpp.Modified		= cpp_db_Credit.Modified ,
		cpp.ImageId			= cpp_db_Credit.ImageId ,
		cpp.RepUpdateTime		= cpp_db_Credit.RepUpdateTime ,
		cpp.IsDeleted		= cpp_db_Credit.IsDeleted
FROM CustProfilePicture cpp WITH (ROWLOCK ,UPDLOCK) 
INNER JOIN bodb_Credit.dbo.CustProfilePicture cpp_db_Credit WITH (NOLOCK) ON cpp.CustId = cpp_db_Credit.CustId
WHERE cpp_db_Credit.RepUpdateTime > @Max_RepUpdateTime_CustProfilePicture
AND cpp.RepUpdateTime < cpp_db_Credit.RepUpdateTime
AND cpp_db_Credit.Modified IS NOT NULL