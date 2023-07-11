
/*<info serverAlias="DBAGE-bodb_Age"></info>*/
/*
	Created by: Helios
	Date: 2023/05/25
	Task: Alpha - Profile picture mismatch data DB053 & DB052 [redmine : #186502]
	DB: Run this Script in DBAGE-bodb_Age and DBEXT-bodb_Age 
*/
----- BEGIN STEP : RUN THIS SCRIPT AT DBAGE-bodb_Age and DBEXT-bodb_Age  -----

BEGIN
	SET NOCOUNT ON

	CREATE TABLE #CustTemp (CustID INT PRIMARY KEY CLUSTERED )
	
	INSERT INTO #CustTemp (CustID)
	SELECT CPP.CustId
	FROM Age_CustProfilePicture CPP WITH (NOLOCK)
	LEFT JOIN bodb02.dbo.custInfo c WITH (NOLOCK) ON CPP.CustId = c.CustID
	WHERE c.CustID IS NULL OR c.Enabled = 0

	DECLARE @Batch						INT			  = 5000
	,		@msg_total					NVARCHAR(200) = 'Total of Cust Affected: %d.'
	,		@cnt_total					INT
	
	CREATE TABLE #Cust_Affected ( CustID INT PRIMARY KEY CLUSTERED) 

	---- DELETE Age_CustProfilePicture 
	SET @cnt_total = (SELECT COUNT(1) FROM #CustTemp)
	RAISERROR (@msg_total, 0, 1, @cnt_total) WITH NOWAIT
	
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Cust_Affected

		DELETE TOP (@Batch) c WITH (ROWLOCK)
		OUTPUT DELETED.CustID
			INTO #Cust_Affected (CustID)
		FROM #CustTemp c

		IF @@ROWCOUNT = 0 
			BREAK ;

		DELETE APP
		FROM Age_CustProfilePicture APP WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Cust_Affected c ON APP.CustId = c.CustID
	END

	---- DELETE Age_ProfilePicture 
	DECLARE		@msg_Imgtotal				NVARCHAR(200) = 'Total of Image Affected: %d.'
	,			@cnt_img_total				INT
	,			@Img						INT
	CREATE TABLE #Image_Affected ( ImageID INT PRIMARY KEY CLUSTERED)
	CREATE TABLE #Affected ( ImageID INT PRIMARY KEY CLUSTERED)

	SET @Img = (SELECT MAX(ImageID) FROM Age_ProfilePicture WITH (NOLOCK) )

	-- Just Del Age_ProfilePicture with ImageLOCAL User
	INSERT INTO #Image_Affected (ImageID)
	SELECT PP.ImageID
	FROM Age_ProfilePicture PP WITH(NOLOCK)
	LEFT JOIN Age_CustProfilePicture CPP WITH(NOLOCK) ON CPP.ImageId = PP.ImageId
	WHERE CPP.ImageId IS NULL AND PP.ImageId > 1000000
	AND PP.ImageId < @Img
	GROUP BY PP.ImageID

	SET @cnt_img_total = (SELECT COUNT(1) FROM #Image_Affected)
	RAISERROR (@msg_Imgtotal, 0, 1, @cnt_img_total) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #Affected 

		DELETE TOP (@Batch) c WITH (ROWLOCK)
		OUTPUT DELETED.ImageID
			INTO #Affected (ImageID)
		FROM #Image_Affected c
 
		IF @@ROWCOUNT = 0 
			BREAK ;

		DELETE APP
		FROM Age_ProfilePicture APP WITH (ROWLOCK, UPDLOCK)
		INNER JOIN #Affected c ON APP.ImageId = c.ImageId
	END

	DROP TABLE #CustTemp
	DROP TABLE #Image_Affected
	DROP TABLE #Affected
	DROP TABLE #Cust_Affected

END




