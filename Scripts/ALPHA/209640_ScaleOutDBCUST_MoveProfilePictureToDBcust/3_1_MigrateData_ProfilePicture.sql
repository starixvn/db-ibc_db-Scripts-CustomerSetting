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

TRUNCATE TABLE ProfilePicture

-- Init ProfilePicture 
INSERT INTO ProfilePicture 
	(
		ImageId
	    , Image
	    , RepUpdateTime
	    , IsDeleted
	)
SELECT  
		ImageId
	    , Image
	    , RepUpdateTime
	    , IsDeleted
FROM bodb_Credit.dbo.ProfilePicture WITH (NOLOCK) 
