/*<info serverAlias="DBAGE-bodb_Age"></info>*/
/*
	Created by: Helios
	Date: 2023/05/22
	Task: Alpha - Profile picture mismatch data DB053 & DB052 [redmine : #186502]
	DB: DBAGE/bodb_Age
*/
----- BEGIN STEP : RUN THIS SCRIPT AT DBAGE-bodb_Age -----
use bodb_Age

BEGIN
	SET NOCOUNT ON


	-- Colect Data From DB052
	CREATE TABLE #tmp_CustProfilePicture_DB052   (CustID INT  PRIMARY KEY CLUSTERED , ImageID INT  , Modified DATETIME )
	CREATE TABLE #tmp_ProfilePicture_DB052   (ImageID INT  PRIMARY KEY CLUSTERED , Image VARBINARY(MAX))

	INSERT INTO #tmp_CustProfilePicture_DB052 (CustID , ImageID , Modified)
	SELECT CustID , ImageID , Modified
	FROM DBEXT.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)

	INSERT INTO #tmp_ProfilePicture_DB052 (ImageID , Image)
	SELECT ImageId , Image
	FROM DBEXT.bodb_Age.dbo.Age_ProfilePicture WITH (NOLOCK)


	CREATE TABLE #CustProfilePicture_DB052   (CustID INT  PRIMARY KEY CLUSTERED , ImageID INT  , Modified DATETIME , Image VARBINARY(MAX))

	INSERT INTO #CustProfilePicture_DB052 (CustID , ImageID , Modified , Image)
	SELECT CPP.CustId  , CPP.ImageId , CPP.Modified , APP.Image
	FROM #tmp_CustProfilePicture_DB052 CPP
	INNER JOIN #tmp_ProfilePicture_DB052 APP ON CPP.ImageID = APP.ImageID
	INNER JOIN bodb02.dbo.Customer C WITH (NOLOCK) ON CPP.CustId = C.custid
	WHERE C.currency <> 20


	-- DB053
	CREATE TABLE #CustProfilePicture_DB053   (CustID INT  PRIMARY KEY CLUSTERED , ImageID INT  , Modified DATETIME , Image VARBINARY(MAX))

	INSERT INTO #CustProfilePicture_DB053 (CustID , ImageID , Modified , Image)
	SELECT CPP.CustId  , CPP.ImageId , CPP.Modified , APP.Image
	FROM Age_CustProfilePicture  CPP WITH (NOLOCK)
	INNER JOIN Age_ProfilePicture APP WITH (NOLOCK) ON CPP.ImageId = APP.ImageId
	INNER JOIN bodb02.dbo.Customer C WITH (NOLOCK) ON CPP.CustId = C.custid
	WHERE C.currency <> 20


	-- Collect Data
	CREATE TABLE #tmp_COL_CustProfilePicture   (CustID INT	, ImageID INT  , Modified DATETIME , Image VARBINARY(MAX) , Result VARCHAR(30) , PRIMARY KEY CLUSTERED (CustID , ImageID))
	
	INSERT INTO #tmp_COL_CustProfilePicture (CustID , ImageID , Modified , Image , Result)
	SELECT 
		des_DB.CustID ,
		des_DB.ImageID ,
		des_DB.Modified ,
		des_DB.Image,
		CASE 
			WHEN source_DB.CustID IS NULL THEN 'DB053 Miss Image' 
			ELSE 'DB053 Not Match Image' 
		END AS Result
	FROM #CustProfilePicture_DB053 source_DB
	FULL JOIN #CustProfilePicture_DB052 des_DB ON source_DB.CustID = des_DB.CustID
	WHERE 
	(source_DB.CustID IS NOT NULL AND des_DB.CustID IS NOT NULL AND CAST(des_DB.Modified AS DATE) > CAST(source_DB.Modified AS DATE))
	OR
	(source_DB.CustID IS NULL)

	-- For Deployed Info
	DECLARE @Batch							INT			  = 3000
	,		@msg_missIMG_Lir				NVARCHAR(200) = 'Total of Miss Image Library Affected: %d.'
	,		@msg_notmatchIMG_Lir			NVARCHAR(200) = 'Total of Not Match Image Library Affected: %d.'
	,		@msg_missIMG_Loc				NVARCHAR(200) = 'Total of Miss Image Local Affected: %d.'
	,		@msg_notmatchIMG_Loc			NVARCHAR(200) = 'Total of Not Match Image Local Affected: %d.'
	,		@cnt_total_missIMG_Lir			INT
	,		@cnt_total_notmatchIMG_Lir		INT
	,		@cnt_total_missIMG_Loc			INT
	,		@cnt_total_notmatchIMG_Loc		INT
	,		@Max_ImgID						INT

	CREATE TABLE #CustAffected (
		CustID			INT ,
		ImageID			INT ,
		Modified		DATETIME  )
	

	-- Part 1 : Affected for case "DB053 Miss Image" and "DB053 Not Match Image" with Image Library

	-- Part 1.1: Run for DB053 Not Match Image
	SET @cnt_total_notmatchIMG_Lir  =	 (SELECT COUNT(1) FROM #tmp_COL_CustProfilePicture WHERE ImageID < 1000001 AND Result='DB053 Not Match Image'  )
	RAISERROR (@msg_notmatchIMG_Lir, 0, 1, @cnt_total_notmatchIMG_Lir) WITH NOWAIT
	
	-- Part 1.2: Run for DB053 Miss Image
	SET @cnt_total_missIMG_Lir		=	 (SELECT COUNT(1) FROM #tmp_COL_CustProfilePicture WHERE ImageID < 1000001 AND Result='DB053 Miss Image' )
	RAISERROR (@msg_missIMG_Lir, 0, 1, @cnt_total_missIMG_Lir) WITH NOWAIT

	-- Part 2 : Affected for case "DB053 Miss Image" and "DB053 Not Match Image" with Image Local
	CREATE TABLE #tmp_Ins_CustProfilePicture   (CustID INT , ImageID INT  , Modified DATETIME , Image VARBINARY(MAX) , Result VARCHAR(30) , PRIMARY KEY CLUSTERED (CustID , ImageID) )

	SET @Max_ImgID = (SELECT MAX (ImageId) FROM Age_ProfilePicture WITH (NOLOCK))

	INSERT INTO #tmp_Ins_CustProfilePicture (CustID , ImageID , Modified , Image , Result)
	SELECT CustID , @Max_ImgID + ROW_NUMBER() OVER(ORDER BY CustID) AS ImageID , Modified , Image , Result
	FROM #tmp_COL_CustProfilePicture
	WHERE ImageID > 1000000 

	SELECT * 
	FROM #tmp_COL_CustProfilePicture

	-- Part 2.1: Run for DB053 Not Match Image
	SET @cnt_total_notmatchIMG_Loc	=	 (SELECT COUNT(1) FROM #tmp_COL_CustProfilePicture WHERE ImageID > 1000000 AND Result='DB053 Not Match Image'  )
	RAISERROR (@msg_notmatchIMG_Loc, 0, 1, @cnt_total_notmatchIMG_Loc) WITH NOWAIT
	
	-- Part 2.2: Run for DB053 Miss Image
	SET @cnt_total_missIMG_Loc		=	 (SELECT COUNT(1) FROM #tmp_COL_CustProfilePicture WHERE ImageID > 1000000 AND Result='DB053 Miss Image' )
	RAISERROR (@msg_missIMG_Loc, 0, 1, @cnt_total_missIMG_Loc) WITH NOWAIT


	DROP TABLE #tmp_CustProfilePicture_DB052
	DROP TABLE #tmp_ProfilePicture_DB052
	DROP TABLE #CustProfilePicture_DB052
	DROP TABLE #CustProfilePicture_DB053
	DROP TABLE #tmp_COL_CustProfilePicture
	DROP TABLE #tmp_Ins_CustProfilePicture
	DROP TABLE #CustAffected
	
	
END