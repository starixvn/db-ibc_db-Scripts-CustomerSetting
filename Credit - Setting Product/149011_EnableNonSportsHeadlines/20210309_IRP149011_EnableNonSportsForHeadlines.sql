/*
	Created: 20210309@Johnson
	Task:  enable non-sports for the list of headlines
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@MaxBet MONEY,
	@MaxLoss MONEY,
	@MMP 	MONEY,
	@MPB	MONEY,
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	
	CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT, srecommend INT, mrecommend INT, recommend INT
							,isUpdateNG BIT ,isUpdateVS BIT, isUpdateLottery BIT, isUpdateTableGame BIT
							,isUpdateKeno BIT ,isUpdateRNGWar BIT)
	DECLARE @tmpSports TABLE (sporttype INT)
	DECLARE @bitmapOrder TINYINT
	
	INSERT INTO #tblCust(custid, roleid, srecommend, mrecommend, recommend, isUpdateNG)
	SELECT c.custid, c.roleid, c.srecommend, c.mrecommend, c.recommend, 
		CASE WHEN c.roleid = 1 AND s.DisableNumber = 0 AND m.DisableNumber = 0 AND a.DisableNumber = 0 THEN 0
			WHEN c.DisableNumber = 1 THEN 1 ELSE 0 END	
	FROM custinfo c WITH(NOLOCK)
		LEFT JOIN custinfo s WITH(NOLOCK) ON c.srecommend = s.custid
		LEFT JOIN custinfo m WITH(NOLOCK) ON c.mrecommend = m.custid
		LEFT JOIN custinfo a WITH(NOLOCK) ON c.recommend = a.custid
	WHERE srecommend = @srecommend
		AND roleid IN (1,2,3)
		AND enabled = 1
	
	IF @@ROWCOUNT = 0
		RETURN;
		
	--NG, Happy 5
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)	
							OR (t.roleid IN (1,2) AND mcs.minbet = 0 AND mcs.maxbet = 0.1)
							OR (t.roleid IN (1) AND acs.minbet = 0 AND acs.maxbet = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)
							OR (t.roleid IN (1,2) AND mcs.minbet = 0 AND mcs.maxbet = 0.1)
							OR (t.roleid IN (1) AND acs.minbet = 0 AND acs.maxbet = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 THEN @MaxBet ELSE cs.maxbet END					
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
	
	--RNG Keno	
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.MaxPerGameType = 0.1)	
							OR (t.roleid IN (1,2) AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.MaxPerGameType = 0.1)
							OR (t.roleid IN (1) AND acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.MaxPerGameType = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.MaxPerGameType <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.MaxPerGameType = 0.1)		
							OR (t.roleid IN (1,2) AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.MaxPerGameType = 0.1)
							OR (t.roleid IN (1) AND acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.MaxPerGameType = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.MaxPerGameType <> 0.1 THEN @MaxBet ELSE cs.maxbet END,					
		cs.MaxPerGameType = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.MaxPerGameType = 0.1)
									OR (t.roleid IN (1,2) AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.MaxPerGameType = 0.1)
									OR (t.roleid IN (1) AND acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.MaxPerGameType = 0.1) THEN 0.1 
								WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.MaxPerGameType <> 0.1 THEN @MPM ELSE cs.MaxPerGameType END,
		cs.isDisabled = 0		
	FROM CustGameType cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
		INNER JOIN CustGameType scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND cs.GameTypeID = scs.GameTypeID													
		LEFT JOIN CustGameType mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND cs.GameTypeID = mcs.GameTypeID												
		LEFT JOIN CustGameType acs WITH(NOLOCK) ON acs.custid = t.recommend 
													AND cs.GameTypeID = acs.GameTypeID													
	WHERE cs.GameTypeID BETWEEN 1 AND 29
		AND 1 = CASE WHEN t.roleid = 1 AND scs.IsDisabled = 0 AND mcs.IsDisabled = 0 AND acs.IsDisabled = 0 THEN 0
					WHEN cs.IsDisabled = 1 THEN 1 ELSE 0 END	

	------------------------------------------------------------------				
	--virtual sports
	INSERT INTO @tmpSports(sporttype)
	SELECT sporttype
	FROM ProductSettingDetail WITH(NOLOCK)
	WHERE ProductID =5
		AND settingType IN (2,20)
	
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile 
	WHERE Sporttype = 180--vs
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateVS = CASE WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
							WHEN c.isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN t ON stt.custid = t.custid
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MaxBet ELSE cs.maxbet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
								OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
							WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MPM ELSE cs.maxpermatch END
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
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0 
						ELSE scs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MaxBet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MPM END,				
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
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 THEN @MaxBet ELSE cs.maxbet END		
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
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1) THEN 0 
						ELSE scs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1) THEN 0.1 
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
	
	--winlimit vs
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (2,3)
		AND isUpdateVS = 1
		AND sporttype = 180
	
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (1)
		AND isUpdateVS = 1
		AND sporttype = 180	
	--End VS--------------------------------------------------------------
	
	------------------------------------------------------------------
	--Lottery
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile 
	WHERE Sporttype = 220--vs
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateLottery = CASE WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
								WHEN c.isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN t ON stt.custid = t.custid
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MaxBet ELSE cs.maxbet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
								OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
							WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MPM ELSE cs.maxpermatch END
	FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
		INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND cs.sporttype = scs.sporttype
													AND cs.bettype = scs.bettype
		LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND cs.sporttype = mcs.sporttype
													AND cs.bettype = mcs.bettype		
	WHERE cs.sporttype = 220
		AND t.isUpdateLottery = 1
		AND roleid IN (2,3)
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0 
						ELSE scs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MaxBet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MPM END,				
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
	WHERE cs.sporttype = 220
		AND t.isUpdateLottery = 1
		AND roleid IN (1)
	
	--winlimit 
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (2,3)
		AND isUpdateLottery = 1
		AND sporttype = 220
	
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (1)
		AND isUpdateLottery = 1
		AND sporttype = 220	
	--End Lottery-----------------------------------------------------
	
	------------------------------------------------------------------
	--Table Game
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype = 222--Table Game
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateTableGame = CASE WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
								WHEN c.isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN t ON stt.custid = t.custid
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MaxBet ELSE cs.maxbet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
								OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
							WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MPM ELSE cs.maxpermatch END
	FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
		INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND cs.sporttype = scs.sporttype
													AND cs.bettype = scs.bettype
		LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND cs.sporttype = mcs.sporttype
													AND cs.bettype = mcs.bettype		
	WHERE cs.sporttype = 222
		AND t.isUpdateTableGame = 1
		AND roleid IN (2,3)
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0 
						ELSE scs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MaxBet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MPM END,				
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
	WHERE cs.sporttype = 222
		AND t.isUpdateTableGame = 1
		AND roleid IN (1)
	
	--winlimit 
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (2,3)
		AND isUpdateTableGame = 1
		AND sporttype = 222
	
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (1)
		AND isUpdateTableGame = 1
		AND sporttype = 222
	--End Table Game-----------------------------------------------------
	
	------------------------------------------------------------------
	--RNG War
	SELECT @bitmapOrder = bitmapOrder
	FROM ProductStatusProfile WITH(NOLOCK)
	WHERE Sporttype = 224--RNG War
	
	;WITH stt AS
	(SELECT t.custid,
		t.roleid,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(s.bitmapIsDisabled, @bitmapOrder)) as isDisabledSuper,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(m.bitmapIsDisabled, @bitmapOrder)) as isDisabledMaster,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(a.bitmapIsDisabled, @bitmapOrder)) as isDisabledAgent,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, @bitmapOrder)) as isDisabled
	FROM #tblCust t
		INNER JOIN CustProductStatus c WITH(NOLOCK) ON t.custid = c.custid
		LEFT JOIN CustProductStatus s WITH(NOLOCK) ON t.srecommend = s.custid
		LEFT JOIN CustProductStatus m WITH(NOLOCK) ON t.mrecommend = m.custid
		LEFT JOIN CustProductStatus a WITH(NOLOCK) ON t.recommend = a.custid
	)
	UPDATE t
	SET t.isUpdateRNGWar = CASE WHEN t.roleid = 1 AND isDisabledSuper = 0 AND isDisabledMaster = 0 AND isDisabledAgent = 0 THEN 0
								WHEN c.isDisabled = 1 THEN 1 ELSE 0 END
	FROM stt 
		INNER JOIN t ON stt.custid = t.custid
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN scs.minbet ELSE cs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
						WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MaxBet ELSE cs.maxbet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
								OR (t.roleid = 2 AND mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1) THEN 0.1 
							WHEN cs.minbet <> 0 AND cs.maxbet <> 0.1 AND cs.maxpermatch <> 0.1 THEN @MPM ELSE cs.maxpermatch END
	FROM CustBetSetting3rd_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t ON cs.custid = t.custid
		INNER JOIN CustBetSetting3rd_Agent scs WITH(NOLOCK) ON scs.custid = t.srecommend 
													AND cs.sporttype = scs.sporttype
													AND cs.bettype = scs.bettype
		LEFT JOIN CustBetSetting3rd_Agent mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
													AND cs.sporttype = mcs.sporttype
													AND cs.bettype = mcs.bettype		
	WHERE cs.sporttype = 224
		AND t.isUpdateRNGWar = 1
		AND roleid IN (2,3)
		
	UPDATE cs
	SET cs.minbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0 
						ELSE scs.minbet END,
		cs.maxbet = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MaxBet END,
		cs.maxpermatch = CASE WHEN (scs.minbet = 0 AND scs.maxbet = 0.1 AND scs.maxpermatch = 0.1)	
							OR (mcs.minbet = 0 AND mcs.maxbet = 0.1 AND mcs.maxpermatch = 0.1)
							OR (acs.minbet = 0 AND acs.maxbet = 0.1 AND acs.maxpermatch = 0.1) THEN 0.1 
						ELSE @MPM END,				
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
	WHERE cs.sporttype = 224
		AND t.isUpdateRNGWar = 1
		AND roleid IN (1)
	
	--winlimit 
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Agent cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (2,3)
		AND cs.sporttype = 224
		AND t.isUpdateRNGWar = 1
	
	UPDATE cs
	SET MaxWinLimit	= 3,
		MaxLossLimit = @MaxLoss
	FROM CustWinLossLimit_Member cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tblCust t on cs.custid = t.custid
	WHERE t.roleid IN (1)
		AND cs.sporttype = 224
		AND t.isUpdateRNGWar = 1
	--End RNG War-----------------------------------------------------
	
	
	
END


-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

---
---
-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @srecommend INT,		
		@currency INT,	
		@MaxBet MONEY,
		@MPM MONEY,
		@MPB MONEY,
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
UNION SELECT 22, 180,1800,360,5400 --IND
UNION SELECT 47, 180,1800,360,5400 --DDD
UNION SELECT 4, 500, 5000,1000,15000 --TB
UNION SELECT 43, 500, 5000,1000,15000 --THB

INSERT INTO #Supers(custid,currency)
SELECT ci.custid , ci.currency
FROM vw_CustAccount ca WITH(NOLOCK)
	INNER JOIN vw_customer ci WITH(NOLOCK) ON ca.custid = ci.custid
WHERE ca.groupid in (
	SELECT 	groupID 
	FROM vw_custAccount WITH(NOLOCK)
	WHERE custid IN (SELECT custid 
					FROM custinfo WITH (NOLOCK) 
					WHERE username IN ('CLM','S79RM','PHRM','KJH','MMMRM','M50RM','DDS','M789H','SFB','MTRE','MQRM','S59BR','S27A','VVG','S63H','S70RMB','S90R','WWR','XCN','M606HK'))
		   )
	AND roleid = 4
	AND site NOT IN ('789y','IBCIndo')
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
		@MPB = MPB,
		@MaxLoss = MaxLoss
	FROM @tmpBetSetting
	WHERE currency =@currency
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_CustSetting3rd_19] 
			@srecommend = @srecommend, 
			@MaxBet = MaxBet,
			@MPM = @MPM,
			@MPB = @MPB,
			@MaxLoss = @MaxLoss,
			@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END		
GO	
-- END STEP 2: Run this SP at replicated DB -----
-----------------------------------------------------------------------------------
	  
	  