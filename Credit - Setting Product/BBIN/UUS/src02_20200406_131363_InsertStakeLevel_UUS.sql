/*
	Created: 20200406@Elodie
	Task: Insert StakeLevel for BBIN_UUS [Redmine: #131363]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

CREATE TABLE #temp(
	GameTypeID		INT,
	[MinLabel]		VARCHAR(30),
	[MaxLabel]		VARCHAR(30),
	[MinStake]		[decimal](19, 8) NULL,
	[MaxStake]		[decimal](19, 8) NULL,
	[ExchangeId]	[int] 
) ON [PRIMARY]

GO
INSERT #temp (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
SELECT 3300, 20, '2', '250', 2, 250 UNION ALL -- UUS
SELECT 3300, 20, '2', '500', 2, 500 UNION ALL -- UUS
SELECT 3300, 20, '2', '1,000', 2, 1000 UNION ALL -- UUS
SELECT 3300, 20, '2', '2,000', 2, 2000 UNION ALL -- UUS
SELECT 3300, 72, '30', '3,000', 30, 3000 UNION ALL -- YNG
SELECT 3300, 72, '30', '15,000', 30, 15000 UNION ALL -- YNG
SELECT 3300, 72, '30', '30,000', 30, 30000 UNION ALL -- YNG
SELECT 3300, 72, '30', '50,000', 30, 50000  -- YNG

DELETE S
FROM StakeLevel S WITH(ROWLOCK) 
WHERE S.GameTypeID = 3300
	AND S.ExchangeId IN (20,72)

INSERT INTO StakeLevel (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
SELECT T.GameTypeID, T.MinLabel,T.MaxLabel,	T.MinStake , T.MaxStake, T.ExchangeId
FROM #temp T WITH(NOLOCK)

DROP TABLE #temp