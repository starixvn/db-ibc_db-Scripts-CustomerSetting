/*
	Created: 20210309@Johnson
	Task:  update bet settings, winlimit non-sports for the list of headlines
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@MaxBet MONEY,
	@MaxLoss MONEY,
	@MPM 	MONEY,	
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('custsetting3rd') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLimit') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT,
							maxpermatch161 MONEY, MaxPerBall161 MONEY,maxpermatch164 MONEY,
							s_maxpermatch161 MONEY, s_MaxPerBall161 MONEY,s_maxpermatch164 MONEY,
							m_maxpermatch161 MONEY, m_MaxPerBall161 MONEY,m_maxpermatch164 MONEY,
							a_maxpermatch161 MONEY, a_MaxPerBall161 MONEY,a_maxpermatch164 MONEY,
							isUpdateNG BIT, isUpdateCasino BIT, isUpdateVS BIT, isUpdateFishingWorld BIT, isUpdateMacauGames BIT)
							
	CREATE TABLE #tblCustSport (custid INT, Sporttype INT, bettype INT, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT, UplineStakeLevelList VARCHAR(200),
								isDisabledSuper BIT, isDisabledMaster BIT, isDisabledAgent BIT PRIMARY KEY(custid,sporttype,bettype))
								
		
	DECLARE @tmpSports TABLE (sporttype INT)
	DECLARE @bitmapOrder TINYINT
	
	INSERT INTO #tblCust(custid, roleid, srecommend, mrecommend, recommend, 
						maxpermatch161 , MaxPerBall161, maxpermatch164,
						s_maxpermatch161, s_MaxPerBall161 ,s_maxpermatch164,
						m_maxpermatch161, m_MaxPerBall161 ,m_maxpermatch164,
						a_maxpermatch161, a_MaxPerBall161 ,a_maxpermatch164,isUpdateNG, isUpdateCasino 
						)
	SELECT c.custid, c.roleid, c.srecommend, c.mrecommend, c.recommend, 
		c.maxpermatch161 , c.MaxPerBall161, c.maxpermatch164,
		s.maxpermatch161 , s.MaxPerBall161, s.maxpermatch164,
		m.maxpermatch161 , m.MaxPerBall161, m.maxpermatch164,
		a.maxpermatch161 , a.MaxPerBall161, a.maxpermatch164,
		CASE WHEN c.roleid = 1 AND s.DisableNumber = 0 AND m.DisableNumber = 0 AND a.DisableNumber = 0 THEN 0
			WHEN c.DisableNumber = 1 THEN 1 ELSE 0 END as isUpdateNG,
		CASE WHEN c.roleid = 1 AND s.DisableCasino = 0 AND m.DisableCasino = 0 AND a.DisableCasino = 0 THEN 0
			WHEN c.DisableCasino = 1 THEN 1 ELSE 0 END as isUpdateCasino	
	FROM custinfo c WITH(NOLOCK)
		LEFT JOIN custinfo s WITH(NOLOCK) ON c.srecommend = s.custid
		LEFT JOIN custinfo m WITH(NOLOCK) ON c.mrecommend = m.custid
		LEFT JOIN custinfo a WITH(NOLOCK) ON c.recommend = a.custid
	WHERE c.srecommend = @srecommend
		AND c.roleid IN (1,2,3)
		AND c.enabled = 1
	
	IF @@ROWCOUNT = 0
		RETURN;
		
	------------------------------------------------------------------
	--NG, Happy 5
	IF EXISTS(SELECT 1 FROM #tblCust WHERE isUpdateNG = 1)
	BEGIN
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.sporttype = 161 AND (cs.maxbet < 1 OR t.maxpermatch161 < 1 OR t.MaxPerBall161 < 1))
								OR (cs.sporttype = 164 AND (cs.maxbet < 1 OR t.maxpermatch164 < 1)) THEN cs.minbet 
							WHEN t.roleid IN (1) AND (acs.maxbet < 1 OR (cs.sporttype = 161 AND (t.a_maxpermatch161 < 1 OR t.a_MaxPerBall161 <1))
																			OR (cs.sporttype = 164 AND t.a_maxpermatch164 < 1)) THEN acs.minbet  
							WHEN t.roleid IN (1,2) AND (mcs.maxbet < 1 OR (cs.sporttype = 161 AND (t.m_maxpermatch161 < 1 OR t.m_MaxPerBall161 <1))
																			OR (cs.sporttype = 164 AND t.m_maxpermatch164 < 1)) THEN mcs.minbet  												
							WHEN scs.maxbet < 1 OR ((cs.sporttype = 161 AND (t.s_maxpermatch161 < 1 OR t.s_MaxPerBall161 <1))
																			OR (cs.sporttype = 164 AND t.s_maxpermatch164 < 1)) THEN scs.minbet  																			
							WHEN cs.maxbet >= 1 AND ((cs.sporttype = 161 AND t.maxpermatch161 >= 1 AND t.maxperball161 >= 1)
													OR (cs.sporttype = 164 AND t.maxpermatch164 >= 1)) THEN scs.minbet ELSE cs.minbet END,
			cs.maxbet = CASE WHEN (cs.sporttype = 161 AND (cs.maxbet < 1 OR t.maxpermatch161 < 1 OR t.MaxPerBall161 < 1))
								OR (cs.sporttype = 164 AND (cs.maxbet < 1 OR t.maxpermatch164 < 1)) THEN cs.maxbet 
							WHEN t.roleid IN (1) AND (acs.maxbet < 1 OR (cs.sporttype = 161 AND (t.a_maxpermatch161 < 1 OR t.a_MaxPerBall161 <1))
																			OR (cs.sporttype = 164 AND t.a_maxpermatch164 < 1)) THEN acs.maxbet 
							WHEN t.roleid IN (1,2) AND (mcs.maxbet < 1 OR (cs.sporttype = 161 AND (t.m_maxpermatch161 < 1 OR t.m_MaxPerBall161 <1))
																			OR (cs.sporttype = 164 AND t.m_maxpermatch164 < 1)) THEN mcs.maxbet
							WHEN scs.maxbet < 1 OR ((cs.sporttype = 161 AND (t.s_maxpermatch161 < 1 OR t.s_maxperball161 < 1))
														OR (cs.sporttype = 164 AND t.s_maxpermatch164 < 1)) THEN scs.maxbet							
							WHEN cs.maxbet >= 1 AND ((cs.sporttype =161 AND t.maxpermatch161 >= 1 AND t.MaxPerBall161 >= 1)
													OR (cs.sporttype =164 AND t.maxpermatch164 >= 1)) THEN @MaxBet ELSE cs.maxbet END					
		FROM custsetting3rd cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON cs.custid = t.custid
			INNER JOIN custsetting3rd scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN custsetting3rd mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype
			LEFT JOIN custsetting3rd acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND cs.sporttype = acs.sporttype
														AND cs.bettype = acs.bettype
		WHERE cs.sporttype IN (161,164)
			AND t.isUpdateNG = 1
	END		
	---End NG,Happy5--------------------------------------------------
	
	------------------------------------------------------------------
	--RNG Casino
	--winlimit
	IF EXISTS(SELECT 1 FROM #tblCust WHERE isUpdateCasino = 1)
	BEGIN
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) = 0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLimit cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE isUpdateCasino = 1
			AND sporttype = 208	
	END		
	----End RnG Casino------------------------------------------------
		
	------------------------------------------------------------------				
	--virtual sports
	DELETE @tmpSports
	
	INSERT INTO @tmpSports(sporttype)
	SELECT sporttype
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE ProductID =5--bet settings
		AND settingType IN (2,20)
	
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype = 180--vs
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrder)) as IsHidden
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateVS = CASE WHEN IsHidden = 1 THEN 0
							WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
							WHEN isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN #tblCust t ON stt.custid = t.custid
		
	
	IF EXISTS(SELECT 1 FROM #tblCust WHERE isUpdateVS = 1)
	BEGIN
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.minbet
							WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.minbet
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.minbet									
							WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN scs.minbet ELSE cs.minbet END,
			cs.maxbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxbet
							WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.maxbet
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxbet							
							WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN @MaxBet ELSE cs.maxbet END,
			cs.maxpermatch = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxpermatch
								WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.maxpermatch 
								WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxpermatch									
								WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN @MPM ELSE cs.maxpermatch END
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON cs.custid = t.custid
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype		
		WHERE cs.sporttype IN (SELECT sporttype FROM @tmpSports WHERE sporttype <> 231)
			AND t.isUpdateVS = 1
			AND roleid IN (2,3)
			
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.minbet 
							WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.minbet
							WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.minbet
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.minbet
							ELSE scs.minbet END,
			cs.maxbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxbet
							WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.maxbet 
							WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.maxbet	
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxbet	
							ELSE @MaxBet END,
			cs.maxpermatch = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxpermatch
								WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.maxpermatch	
								WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.maxpermatch	
								WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxpermatch	
							ELSE @MPM END			
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON cs.custid = t.custid
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype
			LEFT JOIN CustBetSetting3rd_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND cs.sporttype = acs.sporttype
														AND cs.bettype = acs.bettype
		WHERE cs.sporttype IN (SELECT sporttype FROM @tmpSports WHERE sporttype <> 231)
			AND t.isUpdateVS = 1
			AND roleid IN (1)
			
		--virtual sports 3
		UPDATE cs
		SET cs.minbet = CASE WHEN cs.maxbet < 1	THEN cs.minbet
							WHEN t.roleid = 2 AND mcs.maxbet < 1 THEN mcs.minbet
							WHEN scs.maxbet < 1 THEN scs.minbet
							WHEN cs.maxbet >= 1 THEN scs.minbet ELSE cs.minbet END,
			cs.maxbet = CASE WHEN cs.maxbet < 1	THEN cs.maxbet
							WHEN (t.roleid = 2 AND mcs.maxbet < 1) THEN mcs.maxbet
							WHEN (scs.maxbet < 1) THEN scs.maxbet								
							WHEN cs.maxbet >= 1 THEN @MaxBet ELSE cs.maxbet END		
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON cs.custid = t.custid
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype		
		WHERE cs.sporttype IN (SELECT sporttype FROM @tmpSports WHERE sporttype = 231)
			AND t.isUpdateVS = 1
			AND roleid IN (2,3)
			
		UPDATE cs
		SET cs.minbet = CASE WHEN cs.maxbet <1 THEN cs.minbet 
							WHEN acs.maxbet <1 THEN acs.minbet
							WHEN mcs.maxbet <1 THEN mcs.minbet
							WHEN scs.maxbet <1 THEN scs.minbet
							ELSE scs.minbet END,
			cs.maxbet = CASE WHEN cs.maxbet < 1 THEN cs.maxbet
							WHEN acs.maxbet < 1 THEN acs.maxbet
							WHEN mcs.maxbet < 1 THEN mcs.maxbet
							WHEN scs.maxbet < 1 THEN scs.maxbet	
							ELSE @MaxBet END				
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t ON cs.custid = t.custid
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype
			LEFT JOIN CustBetSetting3rd_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND cs.sporttype = acs.sporttype
														AND cs.bettype = acs.bettype
		WHERE cs.sporttype IN (SELECT sporttype FROM @tmpSports WHERE sporttype = 231)
			AND t.isUpdateVS = 1
			AND roleid IN (1)
		
		--winlimit
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (2,3)
			AND isUpdateVS = 1
			AND sporttype = 180
		
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (1)
			AND isUpdateVS = 1
			AND sporttype = 180	
	END		
	--End VS--------------------------------------------------------------
		
	------------------------------------------------------------------
	--RNG Keno	
	DELETE #tblCustSport
	
	INSERT INTO #tblCustSport(custid,bettype,roleid,srecommend,mrecommend,recommend)
	SELECT cs.custid,cs.GameTypeID,roleid,srecommend,mrecommend,recommend
	FROM CustGameType cs WITH(NOLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
		INNER JOIN CustGameType scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND cs.GameTypeID = scs.GameTypeID													
		INNER JOIN CustGameType mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND cs.GameTypeID = mcs.GameTypeID												
		INNER JOIN CustGameType acs WITH(NOLOCK) ON acs.custid = t.recommend 
													AND cs.GameTypeID = acs.GameTypeID													
	WHERE cs.GameTypeID BETWEEN 1 AND 29
		AND t.roleid = 1 
		AND (scs.IsDisabled <> 0 AND mcs.IsDisabled <> 0 AND acs.IsDisabled <> 0 AND cs.IsDisabled = 1)	
	UNION ALL
	SELECT cs.custid,cs.GameTypeID,roleid,srecommend,mrecommend,recommend
	FROM CustGameType cs WITH(NOLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
	WHERE cs.GameTypeID BETWEEN 1 AND 29
		AND t.roleid IN (2,3) 	
		AND cs.IsDisabled = 1
	
	IF EXISTS(SELECT 1 FROM #tblCustSport)	
	BEGIN
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.maxbet < 1 OR cs.MaxPerGameType < 1) THEN cs.minbet	
							WHEN (t.roleid IN (1) AND (acs.maxbet < 1 OR acs.MaxPerGameType <1)) THEN acs.minbet
							WHEN (t.roleid IN (1,2) AND (mcs.maxbet < 1 OR mcs.MaxPerGameType < 1)) THEN mcs.minbet
							WHEN (scs.maxbet < 1 OR scs.MaxPerGameType < 1)	THEN scs.minbet
							WHEN cs.maxbet >=1 AND cs.MaxPerGameType >=1 THEN scs.minbet ELSE cs.minbet END,
			cs.maxbet = CASE WHEN (cs.maxbet < 1 OR cs.MaxPerGameType < 1) THEN cs.maxbet
							WHEN (t.roleid IN (1) AND (acs.maxbet <1 OR acs.MaxPerGameType <1)) THEN acs.maxbet
							WHEN (t.roleid IN (1,2) AND (mcs.maxbet <1 OR mcs.MaxPerGameType <1)) THEN mcs.maxbet
							WHEN (scs.maxbet < 1 OR scs.MaxPerGameType < 1) THEN scs.maxbet								
							WHEN cs.maxbet >= 1 AND cs.MaxPerGameType >=1 THEN @MaxBet ELSE cs.maxbet END,					
			cs.MaxPerGameType = CASE
									WHEN (cs.maxbet <1 OR cs.MaxPerGameType <1) THEN cs.MaxPerGameType	
									WHEN (t.roleid IN (1) AND (acs.maxbet <1 OR acs.MaxPerGameType <1)) THEN acs.MaxPerGameType
									WHEN (t.roleid IN (1,2) AND (mcs.maxbet <1 OR mcs.MaxPerGameType <1)) THEN mcs.MaxPerGameType
									WHEN (scs.maxbet <1 OR scs.MaxPerGameType <1) THEN scs.MaxPerGameType																
									WHEN cs.maxbet >=1 AND cs.MaxPerGameType >=1 THEN @MPM ELSE cs.MaxPerGameType END,
			cs.isDisabled = 0		
		FROM CustGameType cs WITH(ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid
										AND cs.GameTypeID = t.bettype
			INNER JOIN CustGameType scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.GameTypeID = scs.GameTypeID													
			LEFT JOIN CustGameType mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.GameTypeID = mcs.GameTypeID												
			LEFT JOIN CustGameType acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND cs.GameTypeID = acs.GameTypeID																
	END
	
	--enable keno for super
	UPDATE cs
	SET cs.isDisabled = 0		
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
	WHERE custid = @srecommend
		AND GameTypeID BETWEEN 1 AND 29
		AND isDisabled = 1
	----End RnG Keno--------------------------------------------------
	
	------------------------------------------------------------------
	--Live casino(Allbet,WM,...)
	DELETE @tmpSports
	DELETE #tblCustSport
	
	INSERT INTO @tmpSports(sporttype)
	SELECT sporttype
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE ProductID = 41--live casino
		and SettingStatus = 0
		AND settingType  = 13--status
		AND sporttype <> 242--IBCBet Live Casino
			
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		srecommend,
		mrecommend,
		recommend,
		stt.sporttype,
		stt.bettype,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, bitmapOrder)) as IsHidden
	FROM #tblCust t
		CROSS APPLY ProductStatusProfile stt WITH(NOLOCK)
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
		WHERE stt.Sporttype IN (SELECT sporttype FROM @tmpSports)
	)
	INSERT INTO #tblCustSport(custid,sporttype,bettype,roleid,srecommend,mrecommend,recommend,isDisabledSuper,isDisabledMaster,isDisabledAgent)
	SELECT custid,sporttype,bettype,roleid,srecommend,mrecommend,recommend, isDisabledSuper, isDisabledMaster, isDisabledAgent
	FROM stt
	WHERE 1 = CASE WHEN roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
					WHEN isDisabled = 1 THEN 1 ELSE 0 END
		AND IsHidden = 0			
	
	IF EXISTS(SELECT 1 FROM #tblCustSport)
	BEGIN
		UPDATE t
		SET t.UplineStakeLevelList = CASE WHEN roleid = 1 THEN	
												CASE WHEN isDisabledAgent = 0 THEN acs.StakeLevelList
													WHEN isDisabledMaster = 0 THEN mcs.StakeLevelList
													ELSE scs.StakeLevelList END
											WHEN roleid = 2 THEN	
														CASE WHEN isDisabledMaster = 0 THEN mcs.StakeLevelList
															ELSE scs.StakeLevelList END
											WHEN roleid = 3 THEN scs.StakeLevelList 
									END				
		FROM #tblCustSport t
			LEFT JOIN CustStakeLevel_Agent scs WITH(NOLOCK) ON t.srecommend = scs.custid
															AND t.sporttype = scs.sporttype
															AND t.bettype = scs.bettype
			LEFT JOIN CustStakeLevel_Agent mcs WITH(NOLOCK) ON t.mrecommend = mcs.custid
															AND t.sporttype = mcs.sporttype
															AND t.bettype = mcs.bettype												
			LEFT JOIN CustStakeLevel_Agent acs WITH(NOLOCK) ON t.recommend = acs.custid
															AND t.sporttype = acs.sporttype
															AND t.bettype = acs.bettype
		
		UPDATE cs
		SET cs.StakeLevelList = sr.LowestStakeLevel
		FROM CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid 
										AND cs.sporttype = t.sporttype
										AND cs.bettype = t.bettype
			CROSS APPLY (
						SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
						FROM (
							SELECT	CAST(val AS INT) AS val
							FROM	dbo.strSplit(t.UplineStakeLevelList, ',')
						) AS ss
						INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
								ON	ss.val = sl.StakeLevelID
						ORDER BY	sl.MaxStake, sl.MinStake
					) sr						
		WHERE roleid IN (2,3)	

		UPDATE cs
		SET cs.StakeLevelList = sr.LowestStakeLevel
		FROM CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid 
										AND cs.sporttype = t.sporttype
										AND cs.bettype = t.bettype
			CROSS APPLY (
						SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
						FROM (
							SELECT	CAST(val AS INT) AS val
							FROM	dbo.strSplit(t.UplineStakeLevelList, ',')
						) AS ss
						INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
								ON	ss.val = sl.StakeLevelID
						ORDER BY	sl.MaxStake, sl.MinStake
					) sr						
		WHERE roleid = 1
		
		--winlimit
		UPDATE cs
		SET MaxWinLimit	=  CASE WHEN cs.sporttype <> 241 THEN 3 ELSE MaxWinLimit END,--<>BBIN
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t on cs.custid = t.custid
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
		WHERE t.roleid IN (2,3)		
		
		UPDATE cs
		SET MaxWinLimit	= CASE WHEN cs.sporttype <> 241 THEN 3 ELSE MaxWinLimit END,--<> BBIN
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t on cs.custid = t.custid
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype	
		WHERE t.roleid IN (1)
	END	
	--End Live casino------------------------------------------------------
	
	--------------------------------------------------------------------
	--Macau Games
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype = 212--Macau Games
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrder)) as isHidden
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateMacauGames = CASE WHEN isHidden = 1 THEN 0
									WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
									WHEN isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN #tblCust t ON stt.custid = t.custid
	
	IF EXISTS(SELECT 1 FROM #tblCust WHERE isUpdateMacauGames=1)
	BEGIN
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (2,3)
			AND isUpdateMacauGames = 1
			AND sporttype = 212
		
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (1)
			AND isUpdateMacauGames = 1
			AND sporttype = 212	
	END		
	--End Macau Games----------------------------------------------------------------
	
	
	------------------------------------------------------------------
	--Fishing World	
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype = 219--Fishing World
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, @bitmapOrder)) as isHidden
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateFishingWorld = CASE WHEN isHidden = 1 THEN 0
									WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
									WHEN isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN #tblCust t ON stt.custid = t.custid
			
	IF EXISTS(SELECT 1 FROM #tblCust WHERE isUpdateFishingWorld=1)
	BEGIN
		--losslimit
		UPDATE cs
		SET MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (2,3)
			AND isUpdateFishingWorld = 1
			AND sporttype = 219
		
		UPDATE cs
		SET MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCust t on cs.custid = t.custid
		WHERE t.roleid IN (1)
			AND isUpdateFishingWorld = 1
			AND sporttype = 219	
	END		
	--End Fishing World-----------------------------------------------
	
	------------------------------------------------------------------
	--Lottery,Sports Lottery will go-live 18-Mar
	DELETE @tmpSports
	DELETE #tblCustSport
	
	INSERT INTO @tmpSports(sporttype)
	SELECT sporttype
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE ProductID = 44--RnG Lottery
		--and SettingStatus = 0 --comment when testing on local
		AND settingType  = 13--status
		
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		srecommend,
		mrecommend,
		recommend,
		stt.sporttype,
		stt.bettype,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, bitmapOrder)) as isHidden
	FROM #tblCust t
		CROSS APPLY ProductStatusProfile stt WITH(NOLOCK)
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
		WHERE stt.Sporttype IN (SELECT sporttype FROM @tmpSports)
	)
	INSERT INTO #tblCustSport(custid,sporttype,bettype,roleid,srecommend,mrecommend,recommend)
	SELECT custid,sporttype,bettype,roleid,srecommend,mrecommend,recommend
	FROM stt
	WHERE 1 = CASE WHEN isHidden = 1 THEN 0
					WHEN roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
					WHEN isDisabled = 1 THEN 1 ELSE 0 END
	
	IF EXISTS(SELECT 1 FROM #tblCustSport)
	BEGIN
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.minbet
							WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.minbet
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.minbet
							WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN scs.minbet ELSE cs.minbet END,
			cs.maxbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxbet 
							WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.maxbet
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1)	THEN scs.maxbet							
							WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN @MaxBet ELSE cs.maxbet END,
			cs.maxpermatch = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxpermatch	
								WHEN (t.roleid = 2 AND (mcs.maxbet < 1 OR mcs.maxpermatch < 1)) THEN mcs.maxpermatch 
								WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxpermatch									
								WHEN cs.maxbet >= 1 AND cs.maxpermatch >= 1 THEN @MPM ELSE cs.maxpermatch END
		FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid
										AND cs.sporttype = t.sporttype										
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype		
		WHERE roleid IN (2,3)
			
		UPDATE cs
		SET cs.minbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.minbet 
							WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.minbet
							WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.minbet	
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.minbet									
							ELSE scs.minbet END,
			cs.maxbet = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxbet
							WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.maxbet
							WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.maxbet	
							WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxbet	
							ELSE @MaxBet END,
			cs.maxpermatch = CASE WHEN (cs.maxbet < 1 OR cs.maxpermatch < 1) THEN cs.maxpermatch
								WHEN (acs.maxbet < 1 OR acs.maxpermatch < 1) THEN acs.maxpermatch	
								WHEN (mcs.maxbet < 1 OR mcs.maxpermatch < 1) THEN mcs.maxpermatch	
								WHEN (scs.maxbet < 1 OR scs.maxpermatch < 1) THEN scs.maxpermatch	
							ELSE @MPM END
		FROM CustBetSetting3rd_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid
										AND cs.sporttype = t.sporttype										
			INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND cs.sporttype = scs.sporttype
														AND cs.bettype = scs.bettype
			LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND cs.sporttype = mcs.sporttype
														AND cs.bettype = mcs.bettype
			LEFT JOIN CustBetSetting3rd_Agent acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND cs.sporttype = acs.sporttype
														AND cs.bettype = acs.bettype
		WHERE roleid IN (1)
		
		--winlimit 
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t on cs.custid = t.custid
										AND cs.sporttype = t.sporttype
										AND cs.bettype = t.bettype
		WHERE t.roleid IN (2,3)
				
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t on cs.custid = t.custid
									AND cs.sporttype = t.sporttype
									AND cs.bettype = t.bettype
		WHERE t.roleid IN (1)	
	END	
	--End RnG Lottery-------------------------------------------------
	
	------------------------------------------------------------------
	--Virtual games
	DELETE #tblCustSport
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		srecommend,
		mrecommend,
		recommend,
		stt.sporttype,
		stt.bettype,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, bitmapOrder)) as isDisabled,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, bitmapOrder)) as isHidden
	FROM #tblCust t
		CROSS APPLY ProductStatusProfile stt WITH(NOLOCK)
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
		WHERE stt.Sporttype = 245--Virtual Games
	)
	INSERT INTO #tblCustSport(custid,sporttype,bettype,roleid,srecommend,mrecommend,recommend,isDisabledSuper,isDisabledMaster,isDisabledAgent)
	SELECT custid,s.sporttype,s.bettype,roleid,srecommend,mrecommend,recommend, isDisabledSuper, isDisabledMaster, isDisabledAgent
	FROM stt
		CROSS APPLY(SELECT 245 as sporttype, 4601 as bettype
					UNION  SELECT 245 as sporttype, 4602 as bettype)s
	WHERE 1 = CASE WHEN isHidden = 1 THEN 0
					WHEN roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
					WHEN isDisabled = 1 THEN 1 ELSE 0 END
	
	IF EXISTS(SELECT 1 FROM #tblCustSport)
	BEGIN
		UPDATE t
		SET t.UplineStakeLevelList = CASE WHEN roleid = 1 THEN	
												CASE WHEN isDisabledAgent = 0 THEN acs.StakeLevelList
													WHEN isDisabledMaster = 0 THEN mcs.StakeLevelList
													ELSE scs.StakeLevelList END
										WHEN roleid = 2 THEN	
													CASE WHEN isDisabledMaster = 0 THEN mcs.StakeLevelList
														ELSE scs.StakeLevelList END
										WHEN roleid = 3 THEN scs.StakeLevelList 
									END				
		FROM #tblCustSport t
			LEFT JOIN CustStakeLevel_Agent scs WITH(NOLOCK) ON t.srecommend = scs.custid
															AND t.sporttype = scs.sporttype
															AND t.bettype = scs.bettype
			LEFT JOIN CustStakeLevel_Agent mcs WITH(NOLOCK) ON t.mrecommend = mcs.custid
															AND t.sporttype = mcs.sporttype
															AND t.bettype = mcs.bettype												
			LEFT JOIN CustStakeLevel_Agent acs WITH(NOLOCK) ON t.recommend = acs.custid
															AND t.sporttype = acs.sporttype
															AND t.bettype = acs.bettype
		
		UPDATE cs
		SET cs.StakeLevelList = sr.LowestStakeLevel
		FROM CustStakeLevel_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid 
										AND cs.sporttype = t.sporttype
										AND cs.bettype = t.bettype
			CROSS APPLY (
						SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
						FROM (
							SELECT	CAST(val AS INT) AS val
							FROM	dbo.strSplit(t.UplineStakeLevelList, ',')
						) AS ss
						INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
								ON	ss.val = sl.StakeLevelID
						ORDER BY	sl.MaxStake, sl.MinStake
					) sr						
		WHERE roleid IN (2,3)	

		UPDATE cs
		SET cs.StakeLevelList = sr.LowestStakeLevel
		FROM CustStakeLevel_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN #tblCustSport t ON cs.custid = t.custid 
										AND cs.sporttype = t.sporttype
										AND cs.bettype = t.bettype
			CROSS APPLY (
						SELECT TOP(1) ISNULL(CONVERT(VARCHAR(20), sl.StakeLevelID), '') AS LowestStakeLevel
						FROM (
							SELECT	CAST(val AS INT) AS val
							FROM	dbo.strSplit(t.UplineStakeLevelList, ',')
						) AS ss
						INNER JOIN	dbo.StakeLevel AS sl WITH(NOLOCK)
								ON	ss.val = sl.StakeLevelID
						ORDER BY	sl.MaxStake, sl.MinStake
					) sr						
		WHERE roleid = 1
			
		--winlimit
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN (SELECT DISTINCT custid, sporttype
						FROM #tblCustSport 
						WHERE roleid IN (2,3))t on cs.custid = t.custid
												AND cs.sporttype = t.sporttype
		
		UPDATE cs
		SET MaxWinLimit	= 3,
			MaxLossLimit = CASE WHEN MaxLossLimit > @MaxLoss OR ISNULL(MaxLossLimit,0) =0 THEN @MaxLoss ELSE MaxLossLimit END
		FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN (SELECT DISTINCT custid, sporttype
						FROM #tblCustSport 
						WHERE roleid =1 )t on cs.custid = t.custid
												AND cs.sporttype = t.sporttype
	END												
	--End Virtual games-----------------------------------------------
	
	DROP TABLE #tblCust
	DROP TABLE #tblCustSport
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@MaxBet MONEY,
		@MPM MONEY,		
		@MaxLoss MONEY,
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @MaxBet = MaxBet,
		@MPM = MPM,		
		@MaxLoss = MaxLoss
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@MaxBet = @MaxBet,
			@MPM = @MPM,			
			@MaxLoss = @MaxLoss,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------
	  
	  

---
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST/CustDB SERVER -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@MaxBet MONEY,
		@MPM MONEY,		
		@MaxLoss MONEY,
		@super_cnt INT, 
		@index INT = 0
		
CREATE TABLE #Supers(CustID INT, currency INT, isfinished BIT DEFAULT(0))
DECLARE @tmpBetSetting TABLE(currency INT, MaxBet MONEY, MPM MONEY, MPB MONEY, MaxLoss MONEY)

INSERT INTO @tmpBetSetting(currency,MaxBet,MPM,MPB,MaxLoss)
SELECT 2, 50, 500, 100, 1500 --RM
UNION SELECT 5, 90, 900,180,2700 --HK$
UNION SELECT 13, 90, 900,180,2700 --RMB
UNION SELECT 33, 180,1800,360,5400 --IDD
UNION SELECT 43, 500, 5000,1000,15000 --THB
UNION SELECT 67, 50, 500, 100, 1500 --HKK

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
	INNER JOIN custinfo c WITH(NOLOCK) ON ca.custid = c.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND ci.roleid = 4
	AND c.enabled = 1
	AND site NOT IN ('789y','IBCIndo','76666b')
	AND ci.currency IN (SELECT currency FROM @tmpBetSetting)
	
SELECT @super_cnt = @@ROWCOUNT

DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@currency = currency
		,@srecommend = custid		
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SELECT @MaxBet = MaxBet,
		@MPM = MPM,		
		@MaxLoss = MaxLoss
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@MaxBet = @MaxBet,
			@MPM = @MPM,			
			@MaxLoss = @MaxLoss,
			@target = 'DBCUST' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 3: Run this SP at DBCUST/CustDB -----
-----------------------------------------------------------------------------------
	  	  
	  