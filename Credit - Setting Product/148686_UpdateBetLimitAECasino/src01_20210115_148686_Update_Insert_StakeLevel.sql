/*
	Created: Winfred
	Date: 20210114
	Task: change and insert Stake level for AE Casino [Redmine: 148686]
	DB: DBCUST/CustDB
*/

	USE CustDB
	GO
	-- Change Stake level
	CREATE TABLE #tempChange(
		GameTypeID		INT,
		[MinLabel]		VARCHAR(30),
		[MaxLabel]		VARCHAR(30),
		[MinStake]		[decimal](19, 8) NULL,
		[MaxStake]		[decimal](19, 8) NULL,
		[MinLabel_New]		VARCHAR(30),
		[MinStake_New]		[decimal](19, 8) NULL,
		[ExchangeId]	[int] 
	) ON [PRIMARY]

	GO

	INSERT #tempChange (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake , MinLabel_New, MinStake_New)
	--USD - Yen,UT,$US,US$,TH
	SELECT 3101 , 16, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 16, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 16, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	SELECT 3101 , 64, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 64, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 64, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	SELECT 3101 , 35, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 35, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 35, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	SELECT 3101 , 3, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 3, '1', '1,000',	1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 3, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	SELECT 3101 , 74, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 74, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 74, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	--GBP - GBP
	SELECT 3101 , 12, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 12, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 12, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	--EUR - EURO,EUR 
	SELECT 3101 , 6, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 6, '1', '1,000',  1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 6, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	SELECT 3101 , 78, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 78, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 78, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	--MMK - MMK,MKK 
	SELECT 3101 , 69, '1', '500',	1, 500,		'5', 5   UNION ALL 
	SELECT 3101 , 69, '1', '1,000', 1, 1000,	'10', 10   UNION ALL 
	SELECT 3101 , 69, '1', '2,000',	1, 2000,	'20', 20   UNION ALL 
	--=============================================================
	--MYR - RM
	SELECT 3101 , 2, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 2, '2', '5,000', 2, 5000,		'50', 50   UNION ALL 
	--HKD - HKK,HK$
	SELECT 3101 , 67, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 67, '2', '5,000', 2, 5000,	'50', 50   UNION ALL 
	SELECT 3101 , 5, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 5, '2', '5,000', 2, 5000,		'50', 50   UNION ALL 
	--CNY RMB,YUN,CY
	SELECT 3101 , 13, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 13, '2', '5,000', 2, 5000,	'50', 50   UNION ALL
	SELECT 3101 , 66, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 66, '2', '5,000', 2, 5000,	'50', 50   UNION ALL
	SELECT 3101 , 81, '2', '2,500',	2, 2500,	'5', 5   UNION ALL 
	SELECT 3101 , 81, '2', '5,000', 2, 5000,	'50', 50   UNION ALL
	--THB - TB,THB
	SELECT 3101 , 43, '20', '10,000', 20, 10000,	'100', 100   UNION ALL 
	SELECT 3101 , 43, '20', '25,000', 20, 25000,	'250', 250   UNION ALL 
	SELECT 3101 , 43, '20', '50,000', 20, 50000,	'500', 500   UNION ALL 
	SELECT 3101 , 4, '20', '10,000', 20, 10000,	'100', 100   UNION ALL 
	SELECT 3101 , 4, '20', '25,000', 20, 25000,	'250', 250   UNION ALL 
	SELECT 3101 , 4, '20', '50,000', 20, 50000,	'500', 500 


	UPDATE a 
		SET a.MinLabel = c.MinLabel_New ,a.MinStake = c.MinStake_New
	FROM StakeLevel a WITH (ROWLOCK, UPDLOCK) 	
		INNER JOIN #tempChange c ON a.GameTypeID = c.GameTypeID AND a.MinLabel = c.MinLabel  AND  a.MaxLabel = c.MaxLabel AND a.MinStake = c.MinStake AND a.MaxStake = c.MaxStake
					AND a.ExchangeId = c.ExchangeId
	WHERE a.GameTypeID = 3101

	DROP TABLE #tempChange


	-- insert Stake Stake level

	CREATE TABLE #tempNew(
		GameTypeID		INT,
		[MinLabel]		VARCHAR(30),
		[MaxLabel]		VARCHAR(30),
		[MinStake]		[decimal](19, 8) NULL,
		[MaxStake]		[decimal](19, 8) NULL,
		[ExchangeId]	[int] 
	) ON [PRIMARY]

	GO
	INSERT #tempNew (GameTypeID, ExchangeId, MinLabel, MaxLabel, MinStake, MaxStake)
	--MYR - RM 
	SELECT 3101 , 2, '100', '10,000', 100, 10000 UNION ALL 
	--HKD - HKK,HK$
	SELECT 3101 , 67, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3101 , 5,  '100', '10,000', 100, 10000 UNION ALL 
	--CNY - RMB,YUN,CY
	SELECT 3101 , 13, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3101 , 66, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3101 , 81, '100', '10,000', 100, 10000  


	MERGE StakeLevel as s
	USING #tempNew t
		ON s.GameTypeID = t.GameTypeID 
		AND s.ExchangeId = t.ExchangeId AND s.MinLabel = t.MinLabel and s.MaxLabel = t.MaxLabel
	WHEN NOT MATCHED THEN INSERT (GameTypeID, MinLabel, MaxLabel, MinStake, MaxStake,ExchangeId)
						VALUES( T.GameTypeID, T.MinLabel,T.MaxLabel, T.MinStake , T.MaxStake, T.ExchangeId)
	WHEN MATCHED THEN UPDATE SET s.MinLabel = t.MinLabel,
								s.MaxLabel = t.MaxLabel,
								s.MinStake = t.MinStake,
								s.MaxStake = t.MaxStake;

	DROP TABLE #tempNew