/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: Helios
	Date: 23/05/2023
	Task: Initial data from DBAGE to DBCUST-bodb_Credit [Redmine:#186502]	
	DB: DBCUST/bodb_Credit  
*/
 
----- BEGIN STEP : RUN THIS SCRIPT AT DBCUST-bodb_Credit -----

BEGIN
	
	SET NOCOUNT ON

	DECLARE @Batch						INT				= 5000
	,		@msg_total_Img				NVARCHAR(200)	= 'Total of Image Profile Affected: %d.'
	,		@msg_total_CustImg			NVARCHAR(200)	= 'Total of Cust Affected: %d.'
	,		@cnt_total_Img				INT
	,		@cnt_total_CustImg			INT
	,		@max_CustID					INT

	SET @max_CustID = xxx

	-- Collect data Age_CustProfilePicture , Age_ProfilePicture
		CREATE TABLE #tmp_CustProfileImage   (CustID INT  PRIMARY KEY CLUSTERED , ImageID INT , Modified DATETIME)

		INSERT INTO #tmp_CustProfileImage (CustID , ImageID , Modified)
		SELECT CustID , ImageID , Modified
		FROM DB053.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)
		WHERE CustID <= @max_CustID

		CREATE TABLE #tmp_ProfileImage   (ImageID INT  PRIMARY KEY CLUSTERED , Image VARBINARY(MAX))

		INSERT INTO #tmp_ProfileImage (ImageId , Image)
		SELECT app.ImageId , app.Image
		FROM #tmp_CustProfileImage cpi 
		INNER JOIN DB053.bodb_Age.dbo.Age_ProfilePicture app WITH (NOLOCK) ON cpi.ImageID = app.ImageId
		GROUP BY app.ImageId , app.Image
	--- END Collect


	-- For Deployed Info
		SET @cnt_total_Img = (SELECT COUNT(1) FROM #tmp_ProfileImage)
		RAISERROR (@msg_total_Img, 0, 1, @cnt_total_Img) WITH NOWAIT

	-- INS: ProfilePicture 
		WHILE (1=1)
		BEGIN
			DELETE TOP (@Batch) P WITH (ROWLOCK)
			OUTPUT DELETED.ImageID , DELETED.Image , SYSDATETIME() 
				INTO ProfilePicture (ImageID , Image , RepUpdateTime)
			FROM #tmp_ProfileImage P

			IF @@ROWCOUNT = 0 
				BREAK ;
		END

	-- For Deployed Info
		SET @cnt_total_CustImg = (SELECT COUNT(1) FROM #tmp_CustProfileImage)
		RAISERROR (@msg_total_CustImg, 0, 1, @cnt_total_CustImg) WITH NOWAIT

	-- INS: CustProfilePicture 
		WHILE (1=1)
		BEGIN
			DELETE TOP (@Batch) P WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.ImageID , DELETED.Modified , SYSDATETIME() 
				INTO CustProfilePicture (CustID , ImageID , Modified , RepUpdateTime)
			FROM #tmp_CustProfileImage P

			IF @@ROWCOUNT = 0 
				BREAK ;
		END

	DROP TABLE #tmp_ProfileImage
	DROP TABLE #tmp_CustProfileImage
END