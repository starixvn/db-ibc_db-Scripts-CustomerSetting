/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: @Helios
	Date: 21/08/2024
	Task: Scale Out DBCUST - Move CustProfilePicture and ProfilePicture to DBcust - Migrate Data [Redmine:#209640]	
	DB: DBCUST/bodb_Credit
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


SELECT MAX(RepUpdateTime) AS Max_RepUpdateTime_ProfilePicture 
FROM ProfilePicture WITH (NOLOCK)

SELECT MAX(RepUpdateTime) AS Max_RepUpdateTime_CustProfilePicture
FROM CustProfilePicture WITH (NOLOCK)
