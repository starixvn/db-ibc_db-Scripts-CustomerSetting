/*<info serverAlias="DBCUST-bodb_Credit"></info>*/
/*
	Created by: Helios
	Date: 08/06/2023
	Task: Cover User Change Image when migrate data [Redmine:#186502]	
	DB: DBCUST/bodb_Credit 
*/
 
----- BEGIN STEP : RUN THIS SCRIPT AT DBCUST-bodb_Credit -----

BEGIN
	
	SET NOCOUNT ON  

	DECLARE @Batch					INT = 3000
	,		@max_CustID				INT
	,		@Curr_Date				DATE
	
	SET @Curr_Date = CAST(GETDATE() AS DATE)
	SET @max_CustID = xxx 

	CREATE TABLE #tmp_CustProfileImage   (CustID INT PRIMARY KEY CLUSTERED , ImageID INT , Modified DATETIME)

	-- Case1 : Ins for case New Cust created and Login Firsttime, default apply for library image
					INSERT #tmp_CustProfileImage (CustID , ImageID , Modified)
					SELECT CustID , ImageID , Modified
					FROM DB053.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)
					WHERE CustID > @max_CustID AND ImageID < 1000001

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
	-- END Case 1
	
	TRUNCATE TABLE #tmp_CustProfileImage

	-- Case2 : Exists user and Login change image
		-- Collect Data for Case 2
					INSERT #tmp_CustProfileImage (CustID , ImageID , Modified)
					SELECT CustID , ImageID , Modified
					FROM DB053.bodb_Age.dbo.Age_CustProfilePicture WITH (NOLOCK)
					WHERE CAST(Modified AS DATE) = @Curr_Date

				CREATE TABLE #Collect_CustProfileImage   (CustId INT  PRIMARY KEY CLUSTERED , NewImageID INT , NewModified DATETIME , OldImageID INT , Result INT)

					INSERT INTO #Collect_CustProfileImage (CustId , NewImageID , NewModified , OldImageID , Result)
					SELECT 
						cpp.CustId , 
						cpi.ImageID as NewImageID, 
						cpi.Modified as NewModified, 
						cpp.ImageId as OldImageID,
						CASE 
							WHEN cpi.ImageID > 1000000 AND  cpp.ImageId > 1000000 THEN 1				-- CHANGE NEW IMAGE IS LOCAL IMAGE & OLD IMAGE IS LOCAL
							WHEN cpi.ImageID > 1000000 AND  cpp.ImageId < 1000001 THEN 2				-- CHANGE NEW IMAGE IS LOCAL IMAGE & OLD IMAGE IS LIBRARY
							WHEN cpi.ImageID < 1000001 AND  cpp.ImageId > 1000000 THEN 3				-- CHANGE NEW IMAGE IS LIBRARY IMAGE & OLD IMAGE IS LOCAL
							WHEN cpi.ImageID < 1000001 AND  cpp.ImageId < 1000001 THEN 4				-- CHANGE NEW IMAGE IS LIBRARY IMAGE & OLD IMAGE IS LIBRARY
						END AS Result
					FROM #tmp_CustProfileImage cpi
					INNER JOIN CustProfilePicture cpp WITH (NOLOCK) ON cpi.CustID = cpp.CustId
					WHERE cpi.ImageID <> cpp.ImageId OR (cpi.ImageID = cpp.ImageId AND cpi.Modified <> cpp.Modified)

		-- CHANGE NEW IMAGE IS LOCAL IMAGE
			-- OLD IMAGE IS LOCAL
				CREATE TABLE #OldImageIsLocal  (CustId INT  PRIMARY KEY CLUSTERED , OldImageID INT  , NewModified DATETIME , Image VARBINARY(MAX) )

					INSERT INTO #OldImageIsLocal (CustId , OldImageID , NewModified , Image)
					SELECT CustId , OldImageID , NewModified , Image
					FROM #Collect_CustProfileImage cpi
					INNER JOIN DB053.bodb_Age.dbo.Age_ProfilePicture cpp WITH (NOLOCK) ON cpi.OldImageID = cpp.ImageID
					WHERE Result = 1

					UPDATE PP
						SET PP.Image			= img.Image
						,	PP.RepUpdateTime	= SYSDATETIME()
					FROM ProfilePicture PP WITH (ROWLOCK)
					INNER JOIN #OldImageIsLocal img ON PP.ImageId = img.OldImageID
	
					UPDATE CPP
						SET CPP.Modified		= NewModified
						,	CPP.RepUpdateTime	= SYSDATETIME()
					FROM CustProfilePicture CPP WITH (ROWLOCK)
					INNER JOIN #OldImageIsLocal img ON CPP.CustId = img.CustId


			-- OLD IMAGE IS LIBRARY
				CREATE TABLE #OldImageIsLibrary   (CustId INT  PRIMARY KEY CLUSTERED , NewImageID INT  , NewModified DATETIME , Image VARBINARY(MAX) )

					INSERT INTO #OldImageIsLibrary (CustId , NewImageID , NewModified , Image)
					SELECT cpi.CustId , cpi.NewImageID , cpi.NewModified , cpp.Image
					FROM #Collect_CustProfileImage cpi
					INNER JOIN DB053.bodb_Age.dbo.Age_ProfilePicture cpp WITH (NOLOCK) ON cpi.NewImageID = cpp.ImageID
					WHERE Result = 2
		
					INSERT INTO ProfilePicture (ImageId , Image)
					SELECT NewImageID , Image FROM #OldImageIsLibrary

					UPDATE CPP
						SET CPP.ImageId			= img.NewImageID
						,	CPP.Modified		= img.NewModified
						,	CPP.RepUpdateTime	= SYSDATETIME()
					FROM CustProfilePicture CPP WITH (ROWLOCK)
					INNER JOIN #OldImageIsLibrary img ON CPP.CustId = img.CustId


		-- CHANGE NEW IMAGE IS LIBRARY IMAGE
			-- OLD IMAGE IS LOCAL
					
					UPDATE PP
						SET PP.IsDeleted = 1
						,	PP.RepUpdateTime = SYSDATETIME()
					FROM ProfilePicture PP  WITH (ROWLOCK, UPDLOCK)
					INNER JOIN #Collect_CustProfileImage cpi ON PP.ImageId = cpi.OldImageID
					WHERE Result = 3

					UPDATE CPP
						SET CPP.ImageId			= cpi.NewImageID
						, CPP.Modified			= cpi.NewModified
						, CPP.RepUpdateTime		= SYSDATETIME()
					FROM CustProfilePicture CPP WITH (ROWLOCK)
					INNER JOIN #Collect_CustProfileImage cpi ON CPP.CustId = cpi.CustId
					WHERE Result = 3

			-- OLD IMAGE IS LIBRARY
					
					UPDATE CPP
						SET CPP.ImageId			= cpi.NewImageID
						, CPP.Modified			= cpi.NewModified
						, CPP.RepUpdateTime		= SYSDATETIME()
					FROM CustProfilePicture CPP WITH (ROWLOCK)
					INNER JOIN #Collect_CustProfileImage cpi ON CPP.CustId = cpi.CustId
					WHERE Result = 4



	-- END CASE 2

	DROP TABLE #tmp_CustProfileImage
	DROP TABLE #Collect_CustProfileImage
	DROP TABLE #OldImageIsLibrary
	DROP TABLE #OldImageIsLocal


END