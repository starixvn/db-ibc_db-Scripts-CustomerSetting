/*
	Created: Elodie
	Date: 20170801
	Task: Change Lottery MinPT of Super for 'SRRMB','SKWRMB','SRARMB','SRH','SRHK','SRMA','SRHKA','SRJ','SRKH','SRHH','SRK','SRHD','SRMC','SRQ','SRHC' line
	DB: DBCUST/CustDB
*/
USE CustDB
GO
/*	

	DROP TABLE #MemberPT
	DROP TABLE #AgentPT
	DROP TABLE #MasterPT
	DROP TABLE #SuperPT
	
	select count(1) from #CheckPTResult_Credit	
	SELECT ca.username AS UsernameA, ca.roleid AS roleidA, cb.username AS UsernameB, cb.roleid AS roleidB, cs.* 
	FROM #CheckPTResult_Credit cs
		INNER JOIN CustInfo ca WITH (NOLOCK) ON cs.custidA = ca.custid
		INNER JOIN CustInfo cb WITH (NOLOCK) ON cs.custidB = cb.custid
	ORDER BY ruleid	
	
	DROP TABLE #CheckPTResult_Credit
	GO
*/	
	DECLARE @Sporttype SMALLINT	

	CREATE TABLE #CheckPTResult_Credit(
		[RuleId] [smallint] NULL,
		[SportType] [smallint] NULL,
		[BetType] [smallint] NULL,
		[CustIdA] [int] NULL,
		[CustIdB] [int] NULL,
		[ValueA] [smallmoney] NULL,
		[ValueB] [smallmoney] NULL,
		[CreatedDate] [datetime] NULL,
		[IsLive] [bit] NULL
	)

	ALTER TABLE #CheckPTResult_Credit ADD  CONSTRAINT [DF_CheckPTRule_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
	ALTER TABLE #CheckPTResult_Credit ADD  DEFAULT ((0)) FOR [IsLive]		
	CREATE TABLE #supers (custid int)
	CREATE TABLE #masters (custid int)
	
	SELECT @Sporttype = 220

	INSERT INTO #supers (CustID)
	select ci.srecommend
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE username IN ('MRTB', 'MKWRM')

	INSERT INTO #masters (CustID)
	select ci.custid
	FROM dbo.custInfo ci WITH (NOLOCK)
	WHERE username IN ('MRTB', 'MKWRM')

	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,0 IsGroup
	INTO #MemberPT
	FROM dbo.CustInfo ci
		JOIN dbo.CustPTSetting3rd_Member cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.mrecommend IN (SELECT Custid FROM #masters)
			AND ci.roleid = 1  
			AND ci.Enabled = 1      
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = @Sporttype
			
	INSERT INTO #MemberPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,IsGroup)
	SELECT ci.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,1
	FROM dbo.CustInfo ci
		INNER JOIN dbo.CustSettingMode3rd csm WITH (NOLOCK) ON ci.custid = csm.CustID AND csm.IsGrouped = 1
		INNER JOIN dbo.CustPTGroupSetting3rd_Member cs WITH (NOLOCK) ON cs.AgentID = ci.recommend  
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.mrecommend IN (SELECT Custid FROM #masters)
			AND ci.roleid = 1  
			AND ci.Enabled = 1      
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = @Sporttype
			
			
	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	INTO #AgentPT
	FROM dbo.CustInfo ci
		JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.mrecommend IN (SELECT Custid FROM #masters)
			AND ci.roleid = 2  
			AND ci.Enabled = 1      
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = @Sporttype
			
	SELECT cs.CustID,ci.recommend,ci.mrecommend,ci.srecommend, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	INTO #MasterPT
	FROM dbo.CustInfo ci
		JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.custid IN (SELECT Custid FROM #masters)
			AND ci.roleid = 3  
			AND ci.Enabled = 1      
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = @Sporttype
	
	SELECT cs.CustID, cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
	INTO #SuperPT
	FROM dbo.CustInfo ci
		JOIN dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustID
		INNER JOIN dbo.CustProductStatus stt WITH (NOLOCK) ON ci.CustID = stt.CustID
		LEFT JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) ON prf.Sporttype = cs.sporttype
	WHERE ci.srecommend IN (SELECT Custid FROM #supers)
			AND ci.roleid = 4  
			AND ci.Enabled = 1      
			AND ci.Currency NOT IN (20,27,28)     
			AND cs.SportType = @Sporttype
					
	-- End of DATA PREPARATION				
	DECLARE @RuleId SMALLINT = 0
	-- Starting check PT Rule
	 
	----13. M4 < N3
	INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
	SELECT 13 as RuleId, scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.MasterPT , cs.MinPT, scs.IsLive  
	FROM #MasterPT cs
		INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
	WHERE scs.MasterPT < cs.MinPT

	----17. M3 < N3   
	INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
	SELECT 17 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.MasterPT, cs.MinPT, cs.IsLive  
	FROM #MasterPT cs
	WHERE cs.MasterPT < cs.MinPT
		
	----20. N3 > M1 + A1   
	INSERT INTO CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
	SELECT 20 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
	FROM #MemberPT cs
		INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
	WHERE scs.MinPT > cs.MasterPT + cs.AgentPT
			

CREATE TABLE #Cust (srecommend INT, mrecommend INT, isfinished bit default(0)) 
DECLARE @srecommend INT, @mrecommend INT
DECLARE @PT	VARCHAR(MAX)='<ROOT><PT SportType="220" BetType="1021" IsLive="0"/><PT SportType="220" BetType="1022" IsLive="0"/><PT SportType="220" BetType="1023" IsLive="0"/><PT SportType="220" BetType="1024" IsLive="0"/></ROOT>'

INSERT INTO #Cust (srecommend, mrecommend)
SELECT DISTINCT ci.srecommend, cs.CustIdA
FROM #CheckPTResult_Credit cs
	INNER JOIN dbo.custInfo ci WITH (NOLOCK) ON ci.custid = cs.CustIdA

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Cust
	SET isfinished = 1
		,@srecommend = srecommend
		,@mrecommend = mrecommend	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
			
	EXEC dbo.Acc_DynamicCustSetting3rd_04 
			@SuperID = @srecommend
			,@MasterID = @mrecommend
			,@RoleID = 3
			,@SportBettypeXML = @PT 
			
	waitfor delay '00:00:0.100'
END


