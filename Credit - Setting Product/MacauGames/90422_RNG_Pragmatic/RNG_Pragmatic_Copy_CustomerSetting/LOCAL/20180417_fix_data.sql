/*
    Created: 20180417@Vicky
    Task: add stake level list for acc: 19997072
    DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE CustStakeLevel_Member
SET StakeLevelList = '384'
WHERE CustID=19997072 AND SportType = 212 AND BetType = 4001

UPDATE CustStakeLevel_Agent 
SET StakeLevelList = '384,385,386'
where CustID in (19997069, 19997070, 19997071) and SportType = 212 and BetType = 4001