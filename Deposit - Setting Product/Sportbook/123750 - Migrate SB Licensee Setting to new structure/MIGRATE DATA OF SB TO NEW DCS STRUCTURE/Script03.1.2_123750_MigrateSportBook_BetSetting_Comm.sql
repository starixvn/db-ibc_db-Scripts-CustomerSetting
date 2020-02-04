/*
	Created: Eden
	Date: 20191029
	Task: Migrate Comm and BetSetting of Sport Book and Sport Book 2 (E-Sport) to New tables [RM:#123750]
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_08]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('DSB_CustBetSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('DSB_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('DSB_CustDiscount_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('DSB_CustDiscount_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('CommissionTemplate') = 0 RETURN
	IF dbo.f_CheckRepTable('DSB_ByteSeq') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN

	CREATE TABLE #MemberTemp(
		 CustID INT PRIMARY KEY CLUSTERED
		,maxpermatch	money
		,maxpermatch2	money
		,maxpermatch3	money
		,maxpermatch5	money
		,maxpermatch8	money
		,maxpermatch10	money
		,maxpermatch11	money
		,maxpermatch99	money
		,MaxPerMatch99MP money
	)
	CREATE TABLE #SMATemp(
		 CustID INT PRIMARY KEY CLUSTERED
		,roleid TINYINT
		,maxpermatch	money
		,maxpermatch2	money
		,maxpermatch3	money
		,maxpermatch5	money
		,maxpermatch8	money
		,maxpermatch10	money
		,maxpermatch11	money
		,maxpermatch99	money
		,MaxPerMatch99MP money
	)

	INSERT INTO #MemberTemp (
		 CustID
		,maxpermatch	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP
		)
	SELECT custid
		,maxpermatch	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid

	
	INSERT INTO #SMATemp (
		 CustID
		,roleid
		,maxpermatch	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP
		)
	SELECT custid
		,roleid
		,maxpermatch	
		,maxpermatch2	
		,maxpermatch3	
		,maxpermatch5	
		,maxpermatch8	
		,maxpermatch10	
		,maxpermatch11	
		,maxpermatch99	
		,MaxPerMatch99MP
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid

	------------------------------------Bet Setting-------------------------------------------------	
	--SportBook
	INSERT INTO DSB_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.custid
			,a.sporttype
			,a.bettype
			,a.minbet
			,a.maxbet
			,case when a.sporttype = 1 then c.maxpermatch
				when a.sporttype = 2 then c.maxpermatch2
				when a.sporttype = 3 then c.maxpermatch3
				when a.sporttype = 5 then c.maxpermatch5
				when a.sporttype = 8 then c.maxpermatch8
				when a.sporttype = 10 then c.maxpermatch10
				when a.sporttype = 11 then c.maxpermatch11
				when a.sporttype = 99 and bettype = 1 then c.maxpermatch99
				when a.sporttype = 99 and bettype = 9 then c.MaxPerMatch99MP
			end AS maxpermatch
	FROM Dep_CustSetting a WITH(NOLOCK) 
			INNER JOIN #SMATemp c ON a.custid = c.custid AND c.roleid IN (2,3,4)
	WHERE SportType IN (1,2,3,5,8,10,11,99) and bettype = 1 and islive = 0
	UNION ALL
	SELECT a.custid
			,a.sporttype
			,a.bettype
			,a.minbet
			,a.maxbet
			,c.MaxPerMatch99MP
	FROM Dep_CustSetting a WITH(NOLOCK) 
		INNER JOIN #SMATemp c ON a.custid = c.custid AND c.roleid IN (2,3,4)
	WHERE SportType = 99 and bettype = 9 

	INSERT INTO DSB_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.custid
			,a.sporttype
			,a.bettype
			,a.minbet
			,a.maxbet
			,case when a.sporttype = 1 then c.maxpermatch
				when a.sporttype = 2 then c.maxpermatch2
				when a.sporttype = 3 then c.maxpermatch3
				when a.sporttype = 5 then c.maxpermatch5
				when a.sporttype = 8 then c.maxpermatch8
				when a.sporttype = 10 then c.maxpermatch10
				when a.sporttype = 11 then c.maxpermatch11
				when a.sporttype = 99 and bettype = 1 then c.maxpermatch99
				when a.sporttype = 99 and bettype = 9 then c.MaxPerMatch99MP
			end AS maxpermatch
	FROM Dep_CustSetting a WITH(NOLOCK) 
		INNER JOIN #MemberTemp c ON a.custid = c.custid
	WHERE SportType IN (1,2,3,5,8,10,11,99) and bettype = 1 and islive = 0
	UNION ALL
	SELECT a.custid
			,a.sporttype
			,a.bettype
			,a.minbet
			,a.maxbet
			,c.MaxPerMatch99MP
	FROM Dep_CustSetting a WITH(NOLOCK) 
		INNER JOIN #MemberTemp c ON a.custid = c.custid
	WHERE SportType = 99 and bettype = 9 


	--Esport
	INSERT INTO DSB_CustBetSetting_Agent(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.CustID
		,a.SportType
		,a.BetType
		,a.MinBet
		,a.MaxBet
		,a.MaxPerMatch
	FROM Dep_CustBetSetting_Agent a WITH(NOLOCK)
		INNER JOIN #SMATemp c ON a.custid = c.custid
	WHERE a.SportType = 43 


	INSERT INTO DSB_CustBetSetting_Member(
		 CustID
		,SportType
		,BetType
		,MinBet
		,MaxBet
		,MaxPerMatch
	)
	SELECT a.CustID
		,a.SportType
		,a.BetType
		,a.MinBet
		,a.MaxBet
		,a.MaxPerMatch
	FROM Dep_CustBetSetting_Member a WITH(NOLOCK)
		INNER JOIN #MemberTemp c ON a.custid = c.custid
	WHERE a.SportType = 43

	------------------------------------Commisson Setting-------------------------------------------------	
	DECLARE @InitialBinaryStr binary(10) =  0x00000000000000000000

	;WITH tmp AS (
		SELECT dc.CustID,dc.SportType,dc.bettype,dc.islive,
			  CASE WHEN c.roleid = 2 THEN dc.adiscount
				   WHEN c.roleid = 3 THEN dc.discount
				   WHEN c.roleid = 4 THEN dc.sdiscount END AS discount
		FROM Dep_CustSetting dc WITH(NOLOCK) 
			INNER JOIN #SMATemp c ON dc.custid = c.custid
		WHERE  SportType = 1 and bettype = 1 and islive =0 
	)
	,tmp1 AS (
		SELECT  dc.CustID,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										 LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.discount
									WHERE bs.Type = 'DiscountAgent' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							) as discountXML
		FROM tmp dc
	)
	INSERT INTO DSB_CustDiscount_Agent (CustID,Discount)
	SELECT  dc.CustID,dis.binaryStr_new AS Discount
	FROM Tmp1 dc  
		CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.discountXML) dis

	;WITH tmp AS (
		SELECT  c.CustID,
				 (
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									ct.ValueId AS '@val'
							FROM Dep_CustSetting dc WITH(NOLOCK) 
								INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.playerdiscount
							WHERE bs.Type = 'DiscountMember' 
								AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
								AND  dc.custid = c.custid
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
				) as pdiscountXML,
				(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									ct.ValueId AS '@val'
							FROM Dep_CustSetting dc WITH(NOLOCK) 
								INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.adiscount
							WHERE bs.Type = 'DiscountMember' 
								AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
								AND  dc.custid = c.custid
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
				) as adiscountXML,
				(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									ct.ValueId AS '@val'
							FROM Dep_CustSetting dc WITH(NOLOCK) 
								INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.discount
							WHERE bs.Type = 'DiscountMember' 
								AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
								AND  dc.custid = c.custid
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
				) as mdiscountXML,
				(
					SELECT (
							SELECT	bs.ByteOrder	AS '@pos',
									ct.ValueId AS '@val'
							FROM Dep_CustSetting dc WITH(NOLOCK) 
								INNER JOIN dbo.DSB_ByteSeq bs WITH (NOLOCK) ON bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
								LEFT JOIN DSB_CommTemplate ct WITH(NOLOCK) ON ct.Value = dc.sdiscount
							WHERE bs.Type = 'DiscountMember' 
								AND  dc.SportType = 1 AND dc.bettype IN (1,4,5,9) AND dc.islive = 0 
								AND  dc.custid = c.custid
							FOR XML PATH('r')
								, TYPE
							)
					FOR XML PATH('root')
						, TYPE
				) as sdiscountXML
		FROM #MemberTemp c
	)
	INSERT INTO DSB_CustDiscount_Member (CustID,PlayerDiscount,AgentDiscount,MasterDiscount,SuperDiscount)
	SELECT  dc.CustID,
		    pdis.binaryStr_new AS PlayerDiscount,
			adis.binaryStr_new AS AgentDiscount,
			mdis.binaryStr_new AS MasterDiscount,
			sdis.binaryStr_new AS SuperDiscount
	FROM Tmp dc  
		CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.pdiscountXML) pdis
		CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.adiscountXML) adis
		CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.mdiscountXML) mdis
		CROSS APPLY dbo.f_SetBinaryValues(@InitialBinaryStr, dc.sdiscountXML) sdis


	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_08 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20

-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_08 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO