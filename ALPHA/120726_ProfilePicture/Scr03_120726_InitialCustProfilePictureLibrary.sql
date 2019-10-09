/*
	Created: 20191008@Elodie
	Task: Initial data for profile picture
	DB: DBCUST/CustDB
*/

USE CustDB
GO

ALTER PROCEDURE Acc_CustomerInfo_Execrep_19		
AS
BEGIN
	IF dbo.f_CheckRepTable('Age_CustProfilePicture') = 0 RETURN
	IF dbo.f_CheckRepTable('Age_ProfilePicture') = 0 RETURN

	DECLARE @MinId INT, @MaxId INT, @Batch INT = 5000

	SELECT @MinId = MIN(CustId) FROM dbo.custInfo WITH (NOLOCK)
	SELECT @MaxId = @MinId + @Batch

	SELECT custid INTO #CustList
	FROM dbo.Age_CustProfilePicture WITH (NOLOCK)

	WHILE (1=1)
	BEGIN
		INSERT INTO Age_CustProfilePicture (custid,ImageId,modified)
		SELECT custid, custid%200 + 1, NULL
		FROM dbo.custInfo ci WITH (NOLOCK)
		WHERE custid >=@MinId AND custid < @MaxId 
			AND roleid BETWEEN 2 AND 4
			AND NOT EXISTS (SELECT 1 FROM #CustList WHERE custid = ci.custid)

		IF @@ROWCOUNT = 0
			BREAK

		SELECT @MinId = @MaxId
		SELECT @MaxId = @MinId + @Batch
	END
	
END

