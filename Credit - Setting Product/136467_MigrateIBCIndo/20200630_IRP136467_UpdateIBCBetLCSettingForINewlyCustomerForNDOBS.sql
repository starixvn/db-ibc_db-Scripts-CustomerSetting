/*
	Created: 20200630@Johnson
	Task: initial IBCBet Live Casino setting for newly customers of INDOBS
	DB: DBCUST/CUSTDB	
*/
 
DECLARE @maxcustid INT = xxx

CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT, currency INT, isFinished BIT DEFAULT 0)	
	
INSERT INTO #tblCust(custid,roleid, currency)
SELECT custid, roleid, currency
FROM custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid 
					FROM Acc_CustGroup g WITH(NOLOCK) 
					WHERE groupname = 'indobs'	)
	AND Enabled = 1
	AND custid > @maxcustid
	
--PT setting	
INSERT INTO [dbo].[CustPTSetting3rd_Agent]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	   ,[IsAutoMasterPT]
	   ,[AutoMasterPT]
	   ,[IsAutoSuperPT]
	   ,[AutoSuperPT]
	   ,[MinPT]
	   ,[MaxPT])
SELECT t.custid, 242, 3201, 0,
	CASE WHEN roleid = 4 THEN 75 WHEN roleid = 3 THEN 5 ELSE 0 END as SuperPT,
	CASE WHEN roleid = 4 THEN 75 WHEN roleid = 3 THEN 70 ELSE 0 END as MasterPT,
	CASE WHEN roleid = 4 THEN 75 ELSE 0 END as AgentPT, 
	0 as IsAutoMasterPT,
	0 as AutoMasterPT,
	0 as IsAutoSuperPT,
	0 as AutoSuperPT,
	0 as MinPT,
	100 as MaxPT
FROM #tblCust t
	LEFT JOIN CustPTSetting3rd_Agent cs WITH(NOLOCK) ON t.custid = cs.custid 
														AND cs.sporttype = 242
WHERE roleid > 1
	AND cs.custid IS NULL

INSERT INTO [dbo].[CustPTSetting3rd_Member]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[IsLive]
	   ,[SuperPT]
	   ,[MasterPT]
	   ,[AgentPT]
	   ,[IsAutoMasterPT]
	   ,[AutoMasterPT]
	   ,[IsAutoSuperPT]
	   ,[AutoSuperPT])
SELECT  t.custid, 242, 3201, 0,
	0 as SuperPT,
	0 as MasterPT,
	0 as AgentPT, 
	0 as IsAutoMasterPT,
	0 as AutoMasterPT,
	0 as IsAutoSuperPT,
	0 as AutoSuperPT		
FROM #tblCust t
	LEFT JOIN CustPTSetting3rd_Member cs WITH(NOLOCK) ON t.custid = cs.custid 
														AND cs.sporttype= 242
WHERE roleid = 1
	AND cs.custid IS NULL

--Discount setting
INSERT INTO [dbo].[CustDiscount3rd_Agent]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[Discount])
SELECT t.custid, 242, 3201, 
	CASE WHEN roleid IN (3,4) THEN 0.007 ELSE 0 END
FROM #tblCust t
	LEFT JOIN CustDiscount3rd_Agent cs WITH(NOLOCK) ON t.custid = cs.custid					
														AND cs.sporttype= 242
WHERE roleid > 1
	AND cs.custid IS NULL

INSERT INTO [dbo].[CustDiscount3rd_Member]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[PlayerDiscount]
	   ,[AgentDiscount]
	   ,[MasterDiscount]
	   ,[SuperDiscount])
SELECT t.custid, 242, 3201, 0, 0, 0.007, 0.007
FROM #tblCust t
	LEFT JOIN CustDiscount3rd_Member cs WITH(NOLOCK) ON t.custid = cs.custid
														AND cs.sporttype= 242
WHERE roleid = 1
	AND cs.custid IS NULL
	
--bet setting
DECLARE @StakeLevelID_22 INT,
		@StakeLevelID_33 INT

SELECT @StakeLevelID_22 = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE Exchangeid = 22
	AND GameTypeID = 3201
	
SELECT @StakeLevelID_33 = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE Exchangeid = 33
	AND GameTypeID = 3201	
	
INSERT INTO [dbo].[CustStakeLevel_Agent]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[StakeLevelList])
SELECT t.custid, 242, 3201,CASE WHEN currency = 22 THEN @StakeLevelID_22 ELSE @StakeLevelID_33 END	
FROM #tblCust t
	LEFT JOIN CustStakeLevel_Agent cs WITH(NOLOCK) ON t.custid = cs.custid	
													AND sporttype = 242
WHERE roleid > 1
	AND cs.custid IS NULL

INSERT INTO [dbo].[CustStakeLevel_Member]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[StakeLevelList]
	   ,[LastUpdated])
SELECT t.custid, 242, 3201, CASE WHEN currency = 22 THEN @StakeLevelID_22 ELSE @StakeLevelID_33 END, GETDATE()
FROM #tblCust t
	LEFT JOIN CustStakeLevel_Member cs WITH(NOLOCK) ON t.custid = cs.custid	
													AND sporttype = 242
WHERE roleid = 1

--winlimit
INSERT INTO [dbo].[CustWinLossLimit_Agent]
	   ([CustId]
	   ,[SportType]
	   ,[BetType]
	   ,[MaxWinLimit]
	   ,[MaxLossLimit]
	   ,[IsAutoReset])
SELECT t.custid, 242, 3201,cs1.MaxWinLimit,cs1.MaxLossLimit,cs1.IsAutoReset
FROM CustWinLossLimit_Agent cs1 WITH(NOLOCK)
	INNER JOIN #tblCust t ON cs1.custid = t.custid
							AND cs1.sporttype = 243
	LEFT JOIN CustWinLossLimit_Agent cs2 WITH(NOLOCK) ON cs2.custid = t.custid
														AND cs2.sporttype = 242
WHERE roleid > 1
	AND cs2.custid IS NULL

INSERT INTO [dbo].[CustWinLossLimit_Member]
	   ([CustId]
	   ,[SportType]
	   ,[BetType]
	   ,[MaxWinLimit]
	   ,[MaxLossLimit]
	   ,[IsAutoReset])
SELECT t.custid, 242, 3201,cs1.MaxWinLimit,cs1.MaxLossLimit,cs1.IsAutoReset
FROM CustWinLossLimit_Member cs1 WITH(NOLOCK)
	INNER JOIN #tblCust t ON cs1.custid = t.custid
							AND cs1.sporttype = 243
	LEFT JOIN CustWinLossLimit_Member cs2 WITH(NOLOCK) ON cs2.custid = t.custid
														AND cs2.sporttype = 242
WHERE roleid = 1
	AND cs2.custid IS NULL

DROP TABLE #tblCust