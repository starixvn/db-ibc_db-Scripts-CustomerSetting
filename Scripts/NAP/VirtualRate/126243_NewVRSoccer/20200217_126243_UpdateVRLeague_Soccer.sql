/*
    Created: Tiara
    Date: 20200217
    Task: Update data for testing on UAT
    DB: BPRO/bodb02
*/ 
USE CustDB
GO

UPDATE dbo.VRLeagueGroup 
SET GroupName = 'Minor League 4'
WHERE GroupID = 11

UPDATE dbo.VRLeagueGroupMapping 
SET LeagueGroupID = 5
WHERE VRLeagueGroupID = 11

SELECT * FROM dbo.VRLeagueGroup WITH (NOLOCK) WHERE SportType = 1

SELECT * FROM dbo.VRLeagueGroupMapping WITH (NOLOCK) WHERE VRLeagueGroupID > 5