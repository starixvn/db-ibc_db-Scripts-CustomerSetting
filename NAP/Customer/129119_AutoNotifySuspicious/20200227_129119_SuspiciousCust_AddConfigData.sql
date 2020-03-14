/*
	Created: 20200309@Elodie	
	Task: Add config
	DB: DBACC/bodb02
*/
USE bodb02
GO

DECLARE @MaxID BIGINT

SELECT @MaxID = MAX(transid) FROM bettrans WITH (NOLOCK)

SET IDENTITY_INSERT SystemSettings ON

INSERT INTO SystemSettings (VID, VName, VValue)
VALUES (25,'SuspiciousCust_MaxId', CAST(@MaxID AS VARCHAR(200)))

SET IDENTITY_INSERT SystemSettings OFF
--DELETE SystemSettings WHERE VName = 'SuspiciousCust_MaxId'