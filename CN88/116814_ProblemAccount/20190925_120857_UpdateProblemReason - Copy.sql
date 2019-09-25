/*
	Created: 20190925@Elodie	
	Task: Add more problem account reason
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE dbo.CS_ProblemAccount 
SET ReasonID = ReasonID + 100
WHERE ReasonID IS NOT NULL AND ReasonId <> 6

UPDATE dbo.CS_ProblemAccount 
SET ReasonID = 255
WHERE ReasonId = 6

SELECT *
FROM dbo.CS_ProblemAccount WITH (NOLOCK)
