  /*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20220725
    Task: Correct Data custid = 51180940 : [#175813]
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
DECLARE @CustID INT = 51180940
DECLARE @AgentID INT, @SuperID INT, @site varchar(10), @currency int
SELECT @AgentID= recommend, @SuperID = srecommend, @site = site, @currency = currency FROM customer WITH(NOLOCK) WHERE CustID IN (51180940)

/*
SELECT * FROM custinfo								WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM vw_customer							WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM [CustSettingGame]						WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM CustVirtualSetting					WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM Dep_CustProductSetting				WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM Dep_CustSetting						WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM Dep_CustSetting3rd					WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM CustGameType							WITH(NOLOCK) WHERE CustID IN (51180940)
SELECT * FROM Dep_CustDiscountSetting_Member		WITH(NOLOCK) WHERE CustID IN (51180940) -- group
SELECT * FROM Dep_CustPTSetting_Member				WITH(NOLOCK) WHERE CustID IN (51180940) -- group
SELECT * FROM Dep_CustCommRate						WITH(NOLOCK) WHERE CustID IN (51180940) -- not offer
SELECT * FROM Dep_CustSetting_AGCasino				WITH(NOLOCK) WHERE CustID IN (51180940) -- not offer
SELECT * FROM Dep_CustSpecialLevel					WITH(NOLOCK) WHERE CustID IN (51180940) -- not offer

--Need correct
SELECT * FROM Dep_CustSettingMode	WITH(NOLOCK) WHERE CustID IN (51180940 ) 
SELECT * FROM Dep_CustProductStatus	WITH(NOLOCK) WHERE CustID IN (51180940 ) 
SELECT * FROM Dep_CustBetSetting_Member WITH(NOLOCK) WHERE CustID IN (51180940 ) --Get From Upline
SELECT * FROM Dep_CustStakeLevel_Member WITH(NOLOCK) WHERE CustID IN (51180940) --Get From Upline
*/
---------
--Dep_CustSettingMode : GET FROM DB061
INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT,IsGroupedComm,IsGroupedBetLimit,IsGroupedStakeLevel)
SELECT CustID,IsGroupedPT,IsGroupedComm,IsGroupedBetLimit,IsGroupedStakeLevel
FROM DBACC.bodb02.dbo.Dep_CustSettingMode WITH(NOLOCK) WHERE CustID = @CustID

------------------------Get From Upline---------------------------
--Product Status
INSERT INTO [dbo].[Dep_CustProductStatus]([CustID],bitmapIsDisabled,bitmapIsHidden)  
SELECT @CustID, cs.bitmapIsDisabled,cs.bitmapIsHidden  
FROM [dbo].[Dep_CustProductStatus] cs WITH (NOLOCK)  
WHERE cs.CustID = @AgentID  

--bet setting
CREATE TABLE #tmpDep_CustBetLimit_Special(Sporttype SMALLINT,Bettype SMALLINT,MaxBet MONEY,MaxPerMatch MONEY)  
CREATE TABLE #tmpDep_CustNewBetLimit_Special(Sporttype SMALLINT,Bettype SMALLINT,MaxBet MONEY) 
CREATE TABLE #ProductSettingDetail(  
  [SettingType] [tinyint] NOT NULL,  
  [SportType] [smallint] NOT NULL,  
  [BetType] [smallint] NOT NULL,  
  [IsLive] BIT NOT NULL  
    
 )  

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

---------------------DELETE Dep_Customer_Archived----------------------
DELETE
FROM Dep_Customer_Archived WITH(ROWLOCK)
WHERE custid = @CustID