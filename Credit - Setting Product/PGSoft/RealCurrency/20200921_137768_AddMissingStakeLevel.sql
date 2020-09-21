/*
	Created: Elodie
	Date: 20200921
	Task:  Insert missing stake level [PG Game] RedmineID:#137763
	DB: DBCust/CustDB
*/
USE CustDB
GO

INSERT INTO dbo.CustStakeLevel_Member([CustID]
									,[SportType]
									,[BetType]
									,[StakeLevelList]
									,LastUpdated) 
SELECT 45183023, 232,6001,1650 as [StakeLevelList],GETDATE() as LastUpdated

