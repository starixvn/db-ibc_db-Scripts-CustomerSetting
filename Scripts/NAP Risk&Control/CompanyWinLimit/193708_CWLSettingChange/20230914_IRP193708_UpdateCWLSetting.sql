/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230914@Johnson
	Task: Database structure change
	DB: DBCUST/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

ALTER PROC Acc_CustSetting_19 
	@Target VARCHAR(20) = ''
AS 
BEGIN
	IF (@target = 'REPLICATED' AND @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE') ) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')) RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('WinLimit_ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('Exchange') = 0 RETURN

	CREATE TABLE #tmpSetting (ProductID INT, 
							GroupID SMALLINT, 
							Level101 MONEY,
							Level102 MONEY,
							Level1	MONEY,
							Level2	MONEY,
							Level3	MONEY						
							)

	INSERT INTO #tmpSetting(ProductID,GroupID,Level101,Level102,Level1,Level2,Level3)						
	SELECT	6	,	3	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Saba Casino 
	UNION ALL SELECT	32	,	16	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	PP – Pragmatic
	UNION ALL SELECT	36	,	22	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	SG- Spadegaming 
	UNION ALL SELECT	55	,	34	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	PG Soft
	UNION ALL SELECT	66	,	47	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Vgaming
	UNION ALL SELECT	73	,	56	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	MG-RNG
	UNION ALL SELECT	3	,	1	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Number Game 
	UNION ALL SELECT	5	,	2	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 
	UNION ALL SELECT	8	,	4	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Keno RNG 
	UNION ALL SELECT	22	,	10	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Macau Games 
	UNION ALL SELECT	27	,	12	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 2 
	UNION ALL SELECT	28	,	13	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Lottery 
	UNION ALL SELECT	34	,	21	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Arcadia Gaming (Card Club)
	UNION ALL SELECT	38	,	24	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Virtual Games 
	UNION ALL SELECT	40	,	29	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Table Game 
	UNION ALL SELECT	49	,	37	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 3 (Old)
	UNION ALL SELECT	77	,	62	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 3
	UNION ALL SELECT	50	,	32	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Funky Games
	UNION ALL SELECT	56	,	36	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Joker
	UNION ALL SELECT	60	,	40	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	MaxGame
	UNION ALL SELECT	61	,	42	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Habanero
	UNION ALL SELECT	62	,	46	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	CG (Creative Gaming)
	UNION ALL SELECT	63	,	43	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Sports Lottery
	UNION ALL SELECT	67	,	49	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	AdvantPlay
	UNION ALL SELECT	68	,	50	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	AdvantPlay Mini
	UNION ALL SELECT	69	,	51	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Bitcoin
	UNION ALL SELECT	72	,	55	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	SEAL Entertainment
	UNION ALL SELECT	75	,	58	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Jili

	;WITH T AS (SELECT * FROM #tmpSetting
	UNPIVOT  
	(
		Value FOR Level IN (Level101,Level102,Level1,Level2,Level3)
	)unpvt
	),
	Setting AS (SELECT *, case level when 'Level101' THEN 101  
		WHEN 'Level102' THEN 102
		WHEN 'Level1' THEN 1
		WHEN 'Level2' THEN 2
		WHEN 'Level3' THEN 3 END LevelID
	FROM T)
	UPDATE p
	SET MaxWinLimit_RM = s.Value,
		MaxWinLimit = CASE
					  WHEN p.exchangeid = 20
					  THEN s.Value
					  ELSE ROUND(s.Value / e.ActualRate, 2) END
	FROM Setting s
		INNER JOIN WinLimit_ProductSettingDetail p WITH(ROWLOCK) ON p.ProductID = s.ProductID 
																AND p.GroupID = s.GroupID
																AND p.LevelID = s.LevelID
		INNER JOIN Exchange e WITH(NOLOCK) ON p.ExchangeID = e.ExchangeID														
	WHERE SiteID IN (SELECT SiteID FROM Site WITH(NOLOCK) WHERE IsLicensee = 0)															
		AND p.ExchangeID NOT IN (13,51)
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
--------------------------------------------------------------------------------------
DECLARE @Target VARCHAR(20)
	
IF @@SERVERNAME  IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST','DBSPARE')
	SELECT @Target = 'DBCUST'
ELSE 	
	SELECT @Target = 'REPLICATED'
		
EXEC Acc_CustSetting_19 @Target = @Target 
-- END STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS & DBCUST -----
-----------------------------------------------------------------------------------	
