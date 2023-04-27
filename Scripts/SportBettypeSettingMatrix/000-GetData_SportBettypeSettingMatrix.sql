/*<info serverAlias="DBTP-bodb02"></info>*/
/*
	Created: 20230421@Tacy
	Task: Get all data from [SportBettypeSettingMatrix]
	Database: DBTP-bodb02
*/
USE bodb02
GO

CREATE TABLE #Products(
		ProductID	SMALLINT PRIMARY KEY, 
		ProductName NVARCHAR(50)
)

CREATE TABLE #Sports(
		SportType SMALLINT PRIMARY KEY, 
		SportName NVARCHAR(50)
)
	
CREATE TABLE #Bettype (
		typeid INT PRIMARY KEY, 
		typenamee NVARCHAR(128)
)

INSERT INTO #Products (ProductID, ProductName)
SELECT ProductID, ProductName
FROM Products WITH (NOLOCK)

INSERT INTO #Sports (SportType, SportName)	
EXEC Acc_SporttypeSel @Mode=1

INSERT INTO #Bettype (typeid, typenamee)	
SELECT typeid,typenamee 
FROM dbo.Bettype WITH(NOLOCK)

--Get data:
SELECT sm.RealProductId, p.ProductName
	, sm.[SportType], s.SportName
	, sm.[BetType], b.typenamee
	, [isLicensee], [isLive], [Site], [isActive]
	, [SportTypeRefPT], [BetTypeRefPT], [isLivePT], [TablePT]
	, [SportTypeRefComm], [BetTypeRefComm], [IsLiveComm], [TableComm]
	, [SportTypeRefBetSetting], [BetTypeRefBetSetting], [IsLiveBetSetting], [TableBetSetting]
	, [SporttypeRefWinlossLimit], [BettypeRefWinlossLimit], [TableBettrans]
FROM SportBettypeSettingMatrix sm WITH (NOLOCK)
LEFT JOIN #Products p WITH (NOLOCK) ON p.ProductID=sm.RealProductId
LEFT JOIN #Sports s WITH (NOLOCK) ON s.SportType=sm.SportType
LEFT JOIN #Bettype b WITH (NOLOCK) ON b.typeid=sm.BetType
ORDER BY RealProductId, sm.SportType, sm.BetType

DROP TABLE #Bettype, #Products, #Sports