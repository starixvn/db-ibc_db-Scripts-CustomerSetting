  /*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220823
    Task: Correct Data custid = 51251040,25419466,51868814,53341257,25544810 : [#175813]
	Corrected:
		custinfo					
		vw_customer				
		[CustSettingGame]		
		CustVirtualSetting		
		Dep_CustProductSetting	
		Dep_CustSetting			
		Dep_CustSetting3rd		
		CustGameType	
		Dep_CustDiscountSetting_Member --Group
		Dep_CustPTSetting_Member --Group
		Dep_CustCommRate -- not offer
		Dep_CustSetting_AGCasino -- not offer
		Dep_CustSpecialLevel -- not offer

	need correct:
		Dep_CustProductStatus
		Dep_CustBetSetting_Member
		Dep_CustStakeLevel_Member
    DB: DBCUST/CustDB
*/ 
USE CUSTDB
GO
DECLARE @CustID INT 
DECLARE @AgentID INT, @SuperID INT, @site varchar(10), @currency int

CREATE TABLE #tempCust(custid INT, recommend INT, srecommend INT, site varchar(10), currency int, IsFinished BIT DEFAULT 0)
CREATE TABLE #tmpDep_CustBetLimit_Special(Sporttype SMALLINT,Bettype SMALLINT,MaxBet MONEY,MaxPerMatch MONEY)  
CREATE TABLE #tmpDep_CustNewBetLimit_Special(Sporttype SMALLINT,Bettype SMALLINT,MaxBet MONEY) 
CREATE TABLE #ProductSettingDetail(  
  [SettingType] [tinyint] NOT NULL,  
  [SportType] [smallint] NOT NULL,  
  [BetType] [smallint] NOT NULL,  
  [IsLive] BIT NOT NULL  
    
 )  

INSERT INTO #tempCust(custid,recommend, srecommend, site, currency)
SELECT custid, recommend, srecommend, site, currency 
FROM customer WITH(NOLOCK) WHERE CustID IN(51251040,25419466,51868814,53341257,25544810)

SELECT * FROM #tempCust

WHILE 1 = 1
BEGIN
	TRUNCATE TABLE #tmpDep_CustBetLimit_Special
	TRUNCATE TABLE #tmpDep_CustNewBetLimit_Special
	TRUNCATE TABLE #ProductSettingDetail

	UPDATE TOP(1) a 
	SET @CustID= custid, @AgentID= recommend, @SuperID = srecommend,
		@site = site, @currency = currency,
		IsFinished = 1
	FROM #tempCust a
	WHERE IsFinished = 0

	IF @@ROWCOUNT = 0
		BREAK
	/*
	--Need correct
	SELECT * FROM Dep_CustSettingMode	WITH(NOLOCK) WHERE CustID IN (51180940 ) 
	SELECT * FROM Dep_CustProductStatus	WITH(NOLOCK) WHERE CustID IN (51180940 ) 
	SELECT * FROM Dep_CustBetSetting_Member WITH(NOLOCK) WHERE CustID IN (51180940 ) --Get From Upline
	SELECT * FROM Dep_CustStakeLevel_Member WITH(NOLOCK) WHERE CustID IN (51180940) --Get From Upline
	*/
	---------
	--Dep_CustSettingMode : GET FROM DB061
	IF NOT EXISTS( SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE custid = @CustID)
		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT,IsGroupedComm,IsGroupedBetLimit,IsGroupedStakeLevel)
		SELECT CustID,IsGroupedPT,IsGroupedComm,IsGroupedBetLimit,IsGroupedStakeLevel
		FROM DBACC.bodb02.dbo.Dep_CustSettingMode WITH(NOLOCK) WHERE CustID = @CustID
	ELSE
		UPDATE cs
		SET cs.IsGroupedPT = csa.IsGroupedPT,
			cs.IsGroupedComm = csa.IsGroupedComm,
			cs.IsGroupedBetLimit = csa.IsGroupedBetLimit,
			cs.IsGroupedStakeLevel = csa.IsGroupedStakeLevel
		FROM [dbo].Dep_CustSettingMode cs WITH (NOLOCK)
			CROSS APPLY(	SELECT IsGroupedPT,IsGroupedComm,IsGroupedBetLimit,IsGroupedStakeLevel
							FROM DBACC.bodb02.dbo.Dep_CustSettingMode  WITH (NOLOCK)  
							WHERE CustID = @CustID) csa
		WHERE cs.CustID = @CustID

	------------------------Get From Upline---------------------------
	--Product Status
	IF NOT EXISTS( SELECT 1 FROM [Dep_CustProductStatus] WITH(NOLOCK) WHERE custid = @CustID)
		INSERT INTO [dbo].[Dep_CustProductStatus]([CustID],bitmapIsDisabled,bitmapIsHidden)  
		SELECT @CustID, cs.bitmapIsDisabled,cs.bitmapIsHidden  
		FROM [dbo].[Dep_CustProductStatus] cs WITH (NOLOCK)  
		WHERE cs.CustID = @AgentID  
	ELSE
		UPDATE cs
		SET cs.bitmapIsDisabled = csa.bitmapIsDisabled,
			cs.bitmapIsHidden = csa.bitmapIsHidden
		FROM [dbo].[Dep_CustProductStatus] cs WITH (NOLOCK)
			CROSS APPLY(	SELECT bitmapIsDisabled,bitmapIsHidden  
							FROM [dbo].[Dep_CustProductStatus]  WITH (NOLOCK)  
							WHERE CustID = @AgentID) csa
		WHERE cs.CustID = @CustID  

	--bet setting
	INSERT INTO #ProductSettingDetail (SettingType,SportType,BetType,IsLive)  
	SELECT ps.SettingType,psd.SportType,psd.BetType,psd.IsLive  
	FROM Dep_LicenseeProductSetting lds WITH (NOLOCK)  
	INNER JOIN Dep_ProductSetting ps WITH (NOLOCK) ON lds.ProductSettingID = PS.ProductSettingID  
	INNER JOIN Dep_ProductSettingDetail psd WITH (NOLOCK) ON psd.ProductSettingID = ps.ProductSettingID  
	WHERE lds.CustID =@SuperID 

	INSERT INTO #tmpDep_CustBetLimit_Special(Sporttype ,Bettype ,MaxBet ,MaxPerMatch)  
	SELECT DISTINCT s.Sporttype ,s.Bettype ,MaxBet ,MaxPerMatch  
	FROM Dep_CustBetLimit_Special smcs WITH(NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND ((CASE WHEN S.SportType IN (180,181,182,183,184,185,186) THEN 1 ELSE S.Bettype END)  = smcs.BetType) AND S.SettingType = 2  
	WHERE AgentID=@AgentID AND Site=@site AND CurrencyID=@currency  
  
	INSERT INTO #tmpDep_CustBetLimit_Special(Sporttype ,Bettype ,MaxBet ,MaxPerMatch)  
	SELECT DISTINCT s.Sporttype ,s.Bettype ,MaxBet ,MaxPerMatch  
	FROM Dep_CustBetLimit_Special smcs WITH(NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND ((CASE WHEN S.SportType IN (180,181,182,183,184,185,186) THEN 1 ELSE S.Bettype END)  = smcs.BetType) AND S.SettingType = 2  
	WHERE AgentID IS NULL AND NOT EXISTS(SELECT 1 FROM #tmpDep_CustBetLimit_Special a WITH(NOLOCK) WHERE a.SportType=smcs.SportType AND ((CASE WHEN a.SportType IN (180,181,182,183,184,185,186) THEN 1 ELSE a.Bettype END)  = smcs.BetType))  
		AND Site=@site AND CurrencyID=@currency  

	INSERT INTO [dbo].[Dep_CustBetSetting_Member]  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet]  
		,[MaxPerMatch])  
           
	SELECT @CustID, smcs.SportType,smcs.BetType,  
		smcs.MinBet,  
		ISNULL(t.MaxBet,smcs.MaxBet),  
		ISNULL(t.MaxPerMatch,smcs.MaxPerMatch)  
	FROM dbo.Dep_CustBetSetting_Agent smcs WITH (NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND s.Bettype = smcs.BetType AND S.SettingType = 2  
		LEFT JOIN #tmpDep_CustBetLimit_Special t ON smcs.SportType=t.Sporttype AND smcs.BetType=t.Bettype  
	WHERE smcs.custid = @AgentID  
		AND NOT EXISTS( SELECT 1 FROM [Dep_CustBetSetting_Member] WITH(NOLOCK) WHERE custid = @CustID AND SportType = smcs.SportType and bettype = smcs.BetType)

	---------------------
	INSERT INTO #tmpDep_CustNewBetLimit_Special(Sporttype ,Bettype ,MaxBet )  
	SELECT DISTINCT s.Sporttype ,s.Bettype ,MaxBet   
	FROM Dep_CustBetLimit_Special smcs WITH(NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND (S.Bettype  = smcs.BetType) AND S.SettingType = 11  
	WHERE AgentID=@AgentID AND Site=@site AND CurrencyID=@currency  
  
	INSERT INTO #tmpDep_CustNewBetLimit_Special(Sporttype ,Bettype ,MaxBet )  
	SELECT DISTINCT s.Sporttype ,s.Bettype ,MaxBet   
	FROM Dep_CustBetLimit_Special smcs WITH(NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND (S.Bettype  = smcs.BetType) AND S.SettingType = 11  
	WHERE AgentID IS NULL AND NOT EXISTS(SELECT 1 FROM #tmpDep_CustNewBetLimit_Special a WITH(NOLOCK) WHERE a.SportType=smcs.SportType AND (a.Bettype  = smcs.BetType))  
		AND Site=@site AND CurrencyID=@currency  
      
	INSERT INTO [dbo].[Dep_CustBetSetting_Member]  
		([CustID]  
		,[SportType]  
		,[BetType]  
		,[MinBet]  
		,[MaxBet])  
           
	SELECT @CustID, smcs.SportType,smcs.BetType,  
		smcs.MinBet,  
		ISNULL(t.MaxBet,smcs.MaxBet)  
	FROM dbo.Dep_CustBetSetting_Agent smcs WITH (NOLOCK)  
		INNER JOIN #ProductSettingDetail s ON s.SportType = smcs.SportType AND s.Bettype = smcs.BetType AND S.SettingType = 11  
		LEFT JOIN #tmpDep_CustNewBetLimit_Special t ON smcs.SportType=t.Sporttype AND smcs.BetType=t.Bettype  
	WHERE smcs.custid = @AgentID   
		AND NOT EXISTS( SELECT 1 FROM [Dep_CustBetSetting_Member] WITH(NOLOCK) WHERE custid = @CustID AND SportType = smcs.SportType and bettype = smcs.BetType)

	----Stake level
	INSERT INTO Dep_CustStakeLevel_member (CustID,SportType,BetType,StakeLevelList)  
	SELECT @CustID,T.SportType,T.BetType,temp.list  
	FROM #ProductSettingDetail T  
		CROSS APPLY (SELECT TOP 1 ss.value list  
		FROM dbo.Dep_CustStakeLevel_Agent AS csla WITH (NOLOCK)  
			CROSS APPLY STRING_SPLIT(csla.StakeLevelList, ',') AS ss  
			INNER JOIN Dep_StakeLevel sl WITH (NOLOCK) ON ss.value = sl.StakeLevelID    
		WHERE csla.CustID = @AgentID  
			AND csla.SportType = T.SportType  
			AND csla.BetType = T.betType  
		ORDER BY sl.MaxStake, sl.MinStake, SL.GameGroupID   
		) AS Temp  
	WHERE t.SettingType = 8  
		AND NOT EXISTS( SELECT 1 FROM Dep_CustStakeLevel_member WITH(NOLOCK) WHERE custid = @CustID AND SportType = t.SportType and bettype = t.BetType)

	INSERT INTO Dep_CustStakeLevel_member (CustID,SportType,BetType,StakeLevelList)  
	SELECT @CustID,T.SportType,T.BetType,temp.list  
	FROM #ProductSettingDetail T  
		CROSS APPLY (SELECT TOP 1 ss.value list  
		FROM dbo.Dep_CustStakeLevel_Agent AS csla WITH (NOLOCK)  
			CROSS APPLY STRING_SPLIT(csla.StakeLevelList, ',') AS ss  
			INNER JOIN Dep_StakeLevel sl WITH (NOLOCK) ON ss.value = sl.StakeLevelID    
		WHERE csla.CustID = @AgentID AND csla.SportType = T.SportType AND csla.BetType = T.betType  
          
		ORDER BY sl.MaxStake, sl.MinStake  
		) AS Temp  
	WHERE t.SettingType = 7  
		AND NOT EXISTS( SELECT 1 FROM Dep_CustStakeLevel_member WITH(NOLOCK) WHERE custid = @CustID AND SportType = t.SportType and bettype = t.BetType)

	---------------------DELETE Dep_Customer_Archived----------------------
	DELETE
	FROM Dep_Customer_Archived WITH(ROWLOCK)
	WHERE custid = @CustID
END

DROP TABLE #ProductSettingDetail
DROP TABLE #tmpDep_CustBetLimit_Special
DROP TABLE #tmpDep_CustNewBetLimit_Special