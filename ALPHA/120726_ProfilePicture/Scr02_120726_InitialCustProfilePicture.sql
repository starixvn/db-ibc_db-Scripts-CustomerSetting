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

	UPDATE cp 
	SET cp.ImageId = p.ImageId
	FROM dbo.Age_CustProfilePicture cp WITH (ROWLOCK)
		INNER JOIN dbo.Age_ProfilePicture p WITH (NOLOCK) ON p.Image = cp.image
END

