/*
	Created: Eden
	Date: 20191029
	Task: Migrate data of Sport Book 2 (E-Sport) to New tables [RM:#123750]
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	--IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	--IF dbo.f_CheckRepTable('DSB_CustBetSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('DSB_CustBetSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('DSB_CustPTSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('DSB_CustPTSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	--IF dbo.f_CheckRepTable('custinfo') = 0 RETURN
	--IF dbo.f_CheckRepTable('PositionTakingTemplate') = 0 RETURN
	--IF dbo.f_CheckRepTable('DSB_ByteSeq') = 0 RETURN

	CREATE TABLE #MemberTemp(
		 CustID INT PRIMARY KEY CLUSTERED
		 ,recommend INT
	)
	CREATE TABLE #SMATemp(
		 CustID INT PRIMARY KEY CLUSTERED
		,roleid TINYINT
	)

	INSERT INTO #MemberTemp (CustID,recommend)
	SELECT custid,recommend
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid

	
	INSERT INTO #SMATemp (CustID,roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid

	------------------------------------Bet Setting-------------------------------------------------	
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

	------------------------------------PT Setting-------------------------------------------------	
	;WITH tmp AS (
		SELECT  dc.CustID,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							) as apositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as mpositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as spositiontakingXML
		FROM Dep_CustPTSetting_Agent dc WITH(NOLOCK) 
			INNER JOIN #SMATemp c ON dc.custid = c.custid
		WHERE  SportType = 43 and bettype = 1 and islive =0 
	)
	UPDATE a
	SET	a.AgentPT = aPT.binaryStr_new,
		a.MasterPT = mPT.binaryStr_new,
		a.SuperPT = sPT.binaryStr_new 
	FROM Tmp dc  
		INNER JOIN DSB_CustPTSetting_Agent a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID
		CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
		CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
		CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT
	
	;WITH tmp AS (
		SELECT  dc.CustID,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							) as apositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as mpositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as spositiontakingXML
		FROM Dep_CustPTSetting_Member dc WITH(NOLOCK) 
			INNER JOIN #MemberTemp c ON dc.custid = c.custid
		WHERE  SportType = 43 and bettype = 1 and islive =0 
	)
	UPDATE a
	SET	a.AgentPT = aPT.binaryStr_new,
		a.MasterPT = mPT.binaryStr_new,
		a.SuperPT = sPT.binaryStr_new 
	FROM Tmp dc  
		INNER JOIN DSB_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID  
		CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
		CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
		CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT
	
	;WITH tmp AS (
		SELECT  c.CustID,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.AgentPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							) as apositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.MasterPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as mpositiontakingXML,
				 (
							SELECT (
									SELECT	bs.ByteOrder	AS '@pos',
											ct.ValueId AS '@val'
									FROM dbo.DSB_ByteSeq bs WITH (NOLOCK)
										LEFT JOIN DSB_PTTemplate ct WITH(NOLOCK) ON ct.Value * 100 = dc.SuperPT
									WHERE bs.Type = 'PTSetting' 
										AND bs.SportType = dc.sporttype AND bs.BetType = dc.BetType AND bs.IsLive = dc.IsLive
									FOR XML PATH('r')
										, TYPE
									)
							FOR XML PATH('root')
								, TYPE
							)  as spositiontakingXML
		FROM Dep_CustPTGroupSetting_Member dc WITH(NOLOCK) 
			INNER JOIN #MemberTemp c ON dc.AgentID = c.recommend
			INNER JOIN Dep_CustSettingMode ds WITH(NOLOCK)  ON ds.CustID = c.CustID AND ds.IsGroupedPT = 1
		WHERE  SportType = 43 and bettype = 1 and islive =0 
	)
	UPDATE a
	SET	a.AgentPT = aPT.binaryStr_new,
		a.MasterPT = mPT.binaryStr_new,
		a.SuperPT = sPT.binaryStr_new 
	FROM Tmp dc  
		INNER JOIN DSB_CustPTSetting_Member a WITH(ROWLOCK,UPDLOCK) ON a.CustId = dc.CustID  
		CROSS APPLY dbo.f_SetBinaryValues(a.AgentPT, dc.apositiontakingXML) aPT
		CROSS APPLY dbo.f_SetBinaryValues(a.MasterPT, dc.mpositiontakingXML) mPT
		CROSS APPLY dbo.f_SetBinaryValues(a.SuperPT, dc.spositiontakingXML) sPT

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------

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

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO