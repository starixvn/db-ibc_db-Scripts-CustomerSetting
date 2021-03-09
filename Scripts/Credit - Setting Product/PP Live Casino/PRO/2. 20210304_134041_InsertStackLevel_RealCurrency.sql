/*
	Created: 20210304@Tina
	Task: Insert StakeLevel for PP Live Casino - Real Currency
	DB: DBCUST/CustDB
	
*/

USE CustDB
GO

CREATE TABLE #StakeLevel_Temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #StakeLevel_Temp (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT 3701, 13, '0.4', '10000', 0.4, 10000 UNION ALL -- CNY(RMB)
SELECT 3701, 6, '0.1', '2500', 0.1, 2500 UNION ALL -- EUR(EURO)
SELECT 3701, 12, '0.1', '2500', 0.1, 2500 UNION ALL -- GBP(GBP)
SELECT 3701, 5, '0.4', '10000', 0.4, 10000 UNION ALL -- HKD(HK$)
SELECT 3701, 67, '0.4', '10000', 0.4, 10000 UNION ALL -- HKD(HKK)
SELECT 3701, 47, '2.0', '50000', 2.0, 50000 UNION ALL -- IDR(DDD)
SELECT 3701, 33, '2.0', '50000', 2.0, 50000 UNION ALL -- IDR(IDD)
SELECT 3701, 34, '2.0', '50000', 2.0, 50000 UNION ALL -- IDR(IDR)
SELECT 3701, 15, '2.0', '50000', 2.0, 50000 UNION ALL -- IDR(IN)
SELECT 3701, 22, '2.0', '50000', 2.0, 50000 UNION ALL -- IDR(IND)
SELECT 3701, 45, '100.0', '2,500000', 100.0, 2500000 UNION ALL -- KRW(Won)
SELECT 3701, 69, '0.1', '2500', 0.1, 2500 UNION ALL -- MMK(MMK)
SELECT 3701, 2, '0.4', '10000', 0.4, 10000 UNION ALL -- MYR(RM)
SELECT 3701, 43, '4.0', '100000', 4.0, 100000 UNION ALL -- THB(THB)
SELECT 3701, 35, '0.1', '2500', 0.1, 2500 UNION ALL -- USD($US)
SELECT 3701, 3, '0.1', '2500', 0.1, 2500 UNION ALL -- USD(US$)
SELECT 3701, 95, '0.1', '2500', 0.1, 2500 UNION ALL -- USD(USD)
SELECT 3701, 64, '0.1', '2500', 0.1, 2500 UNION ALL -- USD(UT)
SELECT 3701, 16, '0.1', '2500', 0.1, 2500 UNION ALL -- USD(Yen)
SELECT 3701, 51, '1.0', '25000', 1.0, 25000 -- VND(INH)

UPDATE t
SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MinStake > 999

UPDATE t
SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
FROM #StakeLevel_Temp t
WHERE MaxStake > 999


DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3701 AND S.ExchangeId NOT IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #StakeLevel_Temp T WITH(NOLOCK)
ORDER BY GameTypeID,ExchangeId,MaxStake

DROP TABLE #StakeLevel_Temp

--select ExchangeId, code + '('+ currency+')' NiceName
--from exchange E WITH (NOLOCK)
--WHERE E.code = 'GBP'

--select * from StakeLevel with (nolock) where GameTypeID = 3701