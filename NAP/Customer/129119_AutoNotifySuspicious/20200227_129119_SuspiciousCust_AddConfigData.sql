/*
	Created: 20200309@Elodie	
	Task: Add config
	DB: DBACC/bodb02
*/
USE bodb02
GO

DECLARE @MaxID BIGINT

SELECT @MaxID = MAX(transid) FROM bettrans WITH (NOLOCK)

INSERT INTO SystemSettings (VName, VValue)
VALUES ('SuspiciousCust_MaxId', CAST(@MaxID AS VARCHAR(200)))

--DELETE SystemSettings WHERE VName = 'SuspiciousCust_MaxId'