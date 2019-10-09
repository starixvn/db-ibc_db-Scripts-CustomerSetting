/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBCUST/CustDB
*/

USE CustDB
GO

CREATE TABLE #ProfileCustomer (ImageId INT IDENTITY(1001,1), Image VARBINARY(MAX))
DECLARE @MinId INT = 1001, @MaxId INT, @Batch INT = 1000
SELECT @MaxId = @MinId + @Batch

INSERT INTO #ProfileCustomer (Image)
SELECT DISTINCT image
FROM dbo.Age_CustProfilePicture WITH (NOLOCK)

WHILE (1=1)
BEGIN
	INSERT INTO dbo.Age_ProfilePicture (ImageId, Image) 
	SELECT ImageId, Image
	FROM #ProfileCustomer
	WHERE ImageId >=@MinId AND ImageId < @MaxId

	IF @@ROWCOUNT = 0
		BREAK

	SELECT @MinId = @MaxId
	SELECT @MaxId = @MinId + @Batch

	WAITFOR DELAY '00:00:0.100'
END
