/*
	Created: 20210122@Johnson
	DB: DBCUST/CustDB
	Task: initial settings for ION Live Casino setting for 76666b,766666,7aa666
	(copy from AE Casino)
*/
CREATE TABLE #tblCust (CustID INT PRIMARY KEY, roleid TINYINT)

--17 rows affect
SELECT c.custid into #supers
FROM vw_Customer c (nolock) 
	INNER JOIN custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
WHERE site IN ('76666b','766666','7aa666')
	AND c.roleid = 4
	AND c.currency =69
	AND ci.Enabled = 1

--1077 rows affect	
INSERT INTO #tblCust(custid,roleid)
SELECT custid,roleid
FROM custinfo ci WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND enabled = 1
GO

----------------------------------------------------------
--PT
--229 rows affect	
INSERT INTO [dbo].[CustPTSetting3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT]
           ,[MinPT]
           ,[MaxPT])
SELECT [CustID]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,[IsLive]
	   ,[IsAutoMasterPT]
	   ,[IsAutoSuperPT]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	   ,[AutoSuperPT]
	   ,[AutoMasterPT]
	   ,[MinPT]
	   ,[MaxPT]
FROM  CustPTSetting3rd_Agent cs WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)   
	AND sporttype = 243
GO

--851 rows affect
INSERT INTO [dbo].[CustPTSetting3rd_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[IsAutoMasterPT]
           ,[IsAutoSuperPT]
           ,[SuperPT]
           ,[MasterPT]
           ,[AgentPT]
           ,[AutoSuperPT]
           ,[AutoMasterPT])
SELECT [CustID]
	   ,255 as [SportType]
	   ,5601 as [BetType]
	   ,[IsLive]
	   ,[IsAutoMasterPT]
	   ,[IsAutoSuperPT]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	   ,[AutoSuperPT]
	   ,[AutoMasterPT]
FROM CustPTSetting3rd_Member cs WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)   
	AND sporttype = 243		   
GO
------------------------------------------------------


------------------------------------------------------
--commission
--229 rows affect	
INSERT INTO [dbo].[CustDiscount3rd_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[Discount])
SELECT [CustID]
	   ,225 as [SportType]
	   ,5601 [BetType]
	   ,[Discount]		   
FROM  CustDiscount3rd_Agent cs WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)   
	AND sporttype = 243    
GO


--851 rows affect
INSERT INTO [dbo].[CustDiscount3rd_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[PlayerDiscount]
           ,[AgentDiscount]
           ,[MasterDiscount]
           ,[SuperDiscount])
SELECT  [CustID]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount] 
FROM CustDiscount3rd_Member WITH(NOLOCK)	   
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)   
	AND sporttype = 243 
GO
------------------------------------------------------


------------------------------------------------------
--winloss limit
--226 rows affect
INSERT INTO [dbo].[CustWinLossLimit_Agent]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
SELECT [CustId]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,[MaxWinLimit]
	   ,[MaxLossLimit]
	   ,[IsAutoReset]
FROM CustWinLossLimit_Agent	WITH(NOLOCK)	   
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid > 1)   
	AND sporttype = 243   
GO

--851 rows affect
INSERT INTO [dbo].[CustWinLossLimit_Member]
           ([CustId]
           ,[SportType]
           ,[BetType]
           ,[MaxWinLimit]
           ,[MaxLossLimit]
           ,[IsAutoReset])
SELECT [CustId]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,[MaxWinLimit]
	   ,[MaxLossLimit]
	   ,[IsAutoReset]    
FROM CustWinLossLimit_Member WITH(NOLOCK)
WHERE custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)   
	AND sporttype = 243   
GO
------------------------------------------------------


------------------------------------------------------
--stakelevel	
--config global setting for stakelevel
UPDATE StakeLevel WITH(UPDLOCK,ROWLOCK)
SET	MinLabel = '1',
	MaxLabel = '1,000',
	MinStake = 1,
	MaxStake = 1000
WHERE GameTypeID = 5601--ION
	AND exchangeid = 69--MMK
GO

DECLARE @StakeLevelID INT 

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID = 5601--ION
	AND exchangeid = 69--MMK

--226 rows affect
INSERT INTO [dbo].[CustStakeLevel_Agent]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList])
SELECT [CustID]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,CAST(@StakeLevelID as VARCHAR(100)) as [StakeLevelList]		   
FROM #tblCust
WHERE roleid > 1	   
    	
--851 rows affect		
INSERT INTO [dbo].[CustStakeLevel_Member]
           ([CustID]
           ,[SportType]
           ,[BetType]
           ,[StakeLevelList]
           ,[LastUpdated])
SELECT  [CustID]
	   ,225 as [SportType]
	   ,5601 as [BetType]
	   ,CAST(@StakeLevelID as VARCHAR(100)) as [StakeLevelList]
	   ,GETDATE() as [LastUpdated] 	
FROM #tblCust 
WHERE roleid = 1
------------------------------------------------------

------------------------------------------------------
--product status
DECLARE @bitmapOrder TINYINT = 27--ION 

--1077 rows affect
UPDATE cs
SET cs.bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsHidden,@BitmapOrder,0)),
	bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus(cs.bitmapIsDisabled,@BitmapOrder,isDisabled.value)) 	
FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tblCust ci WITH(NOLOCK) ON cs.CustID = ci.CustID
	CROSS APPLY dbo.f_CustSetting_ProductStatusSel(CS.bitmapIsDisabled, 22) as isDisabled--AE 



