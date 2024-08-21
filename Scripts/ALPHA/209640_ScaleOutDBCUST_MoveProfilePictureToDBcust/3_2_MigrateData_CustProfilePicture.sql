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

TRUNCATE TABLE CustProfilePicture

DECLARE 
	  @Max_RepUpdateTime_CustProfilePicture DATETIME2 
	, @Batch INT = 5000

SET @Max_RepUpdateTime_CustProfilePicture = 'xxx'

CREATE TABLE #tmp_CustPP
	(
		CustId	  INT
	    , ImageId	  INT
	    , Modified	  DATETIME
	    , RepUpdateTime DATETIME2
	    , IsDeleted	  BIT
	)

-- Init CustProfilePicture
INSERT INTO #tmp_CustPP 
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
WHERE RepUpdateTime <= @Max_RepUpdateTime_CustProfilePicture


WHILE (1=1)
BEGIN
	
	DELETE TOP (@Batch) temp
	OUTPUT DELETED.CustID, DELETED.ImageId, DELETED.Modified, DELETED.RepUpdateTime , DELETED.IsDeleted
	INTO CustProfilePicture(CustID,ImageId,Modified,RepUpdateTime,IsDeleted)
	FROM #tmp_CustPP temp WITH(ROWLOCK) 

	IF @@ROWCOUNT = 0
		BREAK;

END