/*
	Created: 20171117@Johnson
	Task : Correct settings for un-sync members for GD,VB,AB
	DB:  DBCUST/CustDB
*/
 
 ALTER PROCEDURE [dbo].[Acc_CustSetting3rd_19]
	@srecommend INT, 
	@target VARCHAR(20)	
AS
BEGIN
	SET NOCOUNT ON;
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbcust only
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
		
	IF dbo.f_CheckRepTable('CustSettingGame') = 0 RETURN--GD
	IF dbo.f_CheckRepTable('CustOverrideGame') = 0 RETURN	
	IF dbo.f_CheckRepTable('CustWinLimit') = 0 RETURN
	IF dbo.f_CheckRepTable('CustGameType') = 0 RETURN
	
	IF dbo.f_CheckRepTable('CustProductStatus') = 0 RETURN--VB,AB
	IF dbo.f_CheckRepTable('ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustDiscount3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
		
	CREATE TABLE #tmpMembers (CustID INT PRIMARY KEY, srecommend INT, mrecommend INT, recommend INT, SyncGD BIT, SyncAB BIT, SyncVB BIT)
	
	DECLARE @bitmapOrderVB TINYINT,
			@bitmapOrderAB TINYINT						
	
	SELECT @bitmapOrderAB = MAX(CASE WHEN sporttype = 211 AND bettype = 2401 THEN bitmapOrder ELSE 0 END),		
		@bitmapOrderVB = MAX(CASE WHEN sporttype = 212 AND bettype = 4001 THEN bitmapOrder ELSE 0 END)
	FROM dbo.ProductStatusProfile WITH(NOLOCK)
	WHERE sporttype IN (211,212)
	
	--GD
	INSERT INTO #tmpMembers(custID, srecommend, mrecommend, recommend, SyncGD, SyncAB, SyncVB)
	SELECT ci.custid, srecommend, mrecommend, recommend,		
		CASE WHEN HideGoldDeluxe = 1 THEN 0 ELSE 1 END,
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB),
		dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB)
	FROM dbo.CustInfo ci WITH(NOLOCK)		
		INNER JOIN dbo.CustProductStatus p WITH(NOLOCK) ON ci.custid = p.custid
	WHERE srecommend = @srecommend
		AND roleid = 1
		AND enabled = 1
		AND (HideGoldDeluxe = 1
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderAB) = 0
			OR dbo.f_GetProductStatus(bitmapHasSynced,@bitmapOrderVB) = 0
			)
	
	UPDATE cs
	SET cs.mpositiontaking = CASE WHEN t.isDirectAccount = 1 THEN 0 ELSE mcs.mpositiontaking END,
		cs.apositiontaking = CASE WHEN t.isDirectAccount = 1 THEN mcs.mpositiontaking ELSE 0 END,		
		cs.isautompositiontaking =0,
		cs.autompositiontaking =0,
		cs.discount = CASE WHEN t.isDirectAccount = 1 THEN mcs.adiscount ELSE 0 END
	FROM dbo.CustSettingGame cs WITH(UPDLOCK,ROWLOCK)
		INNER JOIN #tmpMembers t ON cs.custID = t.custID	
		INNER JOIN dbo.CustSettingGame scs WITH(NOLOCK) ON scs.custid = t.srecommend 
														AND scs.sporttype =cs.sporttype
														AND scs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame mcs WITH(NOLOCK) ON mcs.custid = t.mrecommend 
														AND mcs.sporttype =cs.sporttype
														AND mcs.bettype = cs.bettype
		INNER JOIN dbo.CustSettingGame acs WITH(NOLOCK) ON acs.custid = t.recommend 
														AND acs.sporttype =cs.sporttype
														AND acs.bettype = cs.bettype												
	WHERE cs.sporttype = 255
		AND cs.bettype = 1701
		AND t.SyncGD = 0
		
END
	