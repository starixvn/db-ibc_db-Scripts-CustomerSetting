/*<info serverAlias="DBAGE-bodb_Age"></info>*/
/*
	Created by: Helios
	Date: 2023/05/19
	Task: Alpha - Profile picture mismatch data DB053 & DB052 [redmine : #186502]
	DB: DBAGE/bodb_Age
*/

----- BEGIN STEP : RUN THIS SCRIPT AT DBAGE-bodb_Age -----
use bodb_Age

BEGIN

	SET NOCOUNT ON

	--Step 0: Compare Library ImageID from 2 DB with ImageId <= 1000000
	CREATE TABLE #tmp_Library_DB052   (ImageID INT PRIMARY KEY CLUSTERED , Image VARBINARY(MAX))

	INSERT INTO #tmp_Library_DB052 (ImageID , Image)
	SELECT ImageId , Image
	FROM DBEXT.bodb_Age.dbo.Age_ProfilePicture WITH (NOLOCK)
	WHERE ImageId < 1000001

	CREATE TABLE #tmp_Library_DB053   (ImageID INT PRIMARY KEY CLUSTERED , Image VARBINARY(MAX))

	INSERT INTO #tmp_Library_DB053 (ImageID , Image)
	SELECT ImageId , Image
	FROM Age_ProfilePicture WITH (NOLOCK)
	WHERE ImageId < 1000001

	IF EXISTS (
	SELECT 1 as Result
	FROM #tmp_Library_DB052 pp_052 WITH (NOLOCK)
	FULL JOIN #tmp_Library_DB053  pp_053 ON pp_052.ImageId = pp_053.ImageID AND pp_052.Image = pp_053.Image
	WHERE pp_052.ImageID IS NULL OR pp_053.ImageId IS NULL )
	BEGIN
		SELECT N'Data Image Library 2 DB Conflict!' AS 'Compare Library ImageID'
			RETURN;
	END
	ELse
	BEGIN
		SELECT N'Data Image Library 2 DB OK , Not Exists Case Miss Image Library In This Step' AS 'Compare Library ImageID'
	END

	DROP TABLE #tmp_Library_DB052
	DROP TABLE #tmp_Library_DB053
END












