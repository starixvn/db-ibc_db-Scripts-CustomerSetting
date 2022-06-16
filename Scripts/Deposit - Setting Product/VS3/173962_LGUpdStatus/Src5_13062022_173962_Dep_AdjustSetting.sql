/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220613
	Task: Adjust Setting betlimit for [Leap Gaming Virtual Sports 3] RedmineID:#173962
	DB: DBCUST/CustDB
	
	P/s : Step 5 Adjust Setting betlimit for
*/
-- BEGIN STEP 5.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	@target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 
	   )
		RETURN
	
	DECLARE	  @fSportType SMALLINT	= 180
			, @fBetType SMALLINT	= 1201
			, @tSportType SMALLINT	= 231
			, @tBetType SMALLINT	= 5301
	CREATE TABLE #Super_adjust (custid INT PRIMARY KEY)
	INSERT INTO #Super_adjust(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'			
		AND ci.Enabled=1
		AND cs.site IN('vssports','PLAYES','ZhiFeng221','WINHX1','C7YOUXI','ZhiFeng223','ZF026','HIDZ','TYgaming','JDJDAPI',
		'ZhiFeng222','ZhiFeng142','SEAL888','LUCKYBET','JUYOU','AKYL99','KSTECH2','bmwbet') 
		AND ci.currency IN (2,3,4,5,6,12,13,15,20,45,46,50,51,61,70,92,94,96,97,121)  -- RM,US$,TB,HK$,EURO,GBP,RMB,IN,UUS,Won,BND,CAN,INH,INR,MKK,HID,MK,USDT,BDT,PKR
	----------------------------------------Bet Setting-------------------------------------------------	
	SELECT f.CustID, (CASE 
					WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
					WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) AS MinBet, 
					( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
					) AS MaxBet
	INTO #CustBetSetting_Agent
	FROM dbo.Dep_CustBetSetting_Agent f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_ProductBetSetting d WITH(NOLOCK) ON c.Currency = d.Currency AND d.Sporttype = @tSportType AND d.Bettype = @tBetType
		INNER JOIN Dep_CustBetSetting_Agent t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   t.MinBet		<> (CASE 
							WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
							WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)			
		OR t.MaxBet		<> ( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							)		
		)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)
	
	SELECT f.CustID, (CASE 
					WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
					WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) AS MinBet, 
					( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							) AS MaxBet
	INTO #CustBetSetting_Member
	FROM dbo.Dep_CustBetSetting_Member f WITH (NOLOCK)
		INNER JOIN custInfo C WITH (NOLOCK) ON C.custid = f.CustID
		INNER JOIN Dep_ProductBetSetting d WITH(NOLOCK) ON c.Currency = d.Currency AND d.Sporttype = @tSportType AND d.Bettype = @tBetType
		INNER JOIN Dep_CustBetSetting_Member t  WITH (NOLOCK)
			ON f.CustID = t.CustID 
			AND t.SportType = @tSportType 
			AND t.BetType = @tBetType
	WHERE f.SportType = @fSportType AND f.BetType = @fBetType
	AND(   t.MinBet		<> (CASE 
							WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
							WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)			
		OR t.MaxBet		<> ( CASE WHEN (CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
										WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END) >		
							(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
								WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							THEN 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MinBet 
									WHEN f.MinBet <  d.MinBet THEN d.MinBet ELSE f.MinBet END)
							ELSE 
								(CASE WHEN (f.MinBet = 0 AND (f.MaxBet = 0 OR f.MaxBet = 0.1)) THEN f.MaxBet 
									WHEN f.MaxBet >  d.MaxBet THEN d.MaxBet ELSE f.MaxBet END)
							END	
							)		
		)
	AND EXISTS (SELECT 1 FROM #Super_adjust WITH (NOLOCK) WHERE CustID = C.srecommend)

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
	FROM Dep_CustBetSetting_Agent a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Agent t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	UPDATE a
	SET	a.MinBet		= t.MinBet		
		 ,a.MaxBet		= t.MaxBet	
	FROM Dep_CustBetSetting_Member a WITH(ROWLOCK)
		INNER JOIN #CustBetSetting_Member t ON a.CustId = t.CustId
	WHERE a.SportType = @tSportType AND a.BetType = @tBetType

	DROP TABLE #CustBetSetting_Agent
	DROP TABLE #CustBetSetting_Member
END
GO
-- END STEP 5.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 5.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'REPLICATED'

PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

-- BEGIN STEP 5.3: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_Dep_DynamicCustSetting_09 @target = 'DBCUST'

PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'