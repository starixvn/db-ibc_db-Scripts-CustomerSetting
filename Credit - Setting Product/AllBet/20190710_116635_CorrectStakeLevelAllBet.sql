/*
	Created: 20190710@Winnie
	Task: SAS- Correct data for Allbet DSC setting for licensee Axiawin - [Redmine:#116635]	
	DB: Run at DBCust.CustDB
*/  
USE [CustDB]
Go

DELETE FROM Dep_StakeLevel WHERE SiteID=401 AND StakeLevelID IN(591,592)

UPDATE Dep_CustStakeLevel_Agent WITH(ROWLOCK,UPDLOCK)
	SET StakeLevelList=593
WHERE CustID=37398333 AND SportType=211 AND BetType=2401

UPDATE Dep_CustStakeLevel_Agent WITH(ROWLOCK,UPDLOCK)
	SET StakeLevelList=594
WHERE CustID=37398333 AND SportType=211 AND BetType=2402
