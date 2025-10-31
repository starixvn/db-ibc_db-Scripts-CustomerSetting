/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created By: Johnson@20251030
	Description: copy existing settings from old sports to new sports LCS on SIT[redmine: #242260]
	DB: DBCust/CustDB	
*/

CREATE TABLE #tblCust(CustID INT PRIMARY  KEY,roleid TINYINT)

DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)

INSERT INTO #tblCust(CustID, roleid)
SELECT CustID, roleid
FROM Custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM customer WITH(NOLOCK) WHERE username IN ('Supertest27THB02'))
	AND Enabled = 1
			
WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	WHERE roleid IN (2,3,4)

	IF @@ROWCOUNT =0 BREAK;

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
		,[MaxPT]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, MinPT, MaxPT, dbo.f_GetDateTime2()
	FROM  CustPTSetting3rd_Agent cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400

	INSERT INTO [dbo].[CustDiscount3rd_Agent]
		([CustID]
		,[SportType]
		,[BetType]
		,[Discount]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, Discount, dbo.f_GetDateTime2()
	FROM CustDiscount3rd_Agent cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400   	

	DELETE @tmpCust	
END

WHILE (1=1)
BEGIN
	DELETE TOP (1000) t
	OUTPUT DELETED.CustID INTO @tmpCust(custid)
	FROM #tblCust t
	WHERE roleid = 1

	IF @@ROWCOUNT =0 BREAK;

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
		,[AutoMasterPT]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, IsLive, IsAutoMasterPT, IsAutoSuperPT, SuperPT, MasterPT, AgentPT, AutoSuperPT, AutoMasterPT, dbo.f_GetDateTime2()
	FROM  CustPTSetting3rd_Member cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400

	INSERT INTO [dbo].[CustDiscount3rd_Member]
		([CustID]
		,[SportType]
		,[BetType]
		,[PlayerDiscount]
		,[AgentDiscount]
		,[MasterDiscount]
		,[SuperDiscount]
		,[RepUpdateTime])
	SELECT CustID, t.SportType, t.BetType, PlayerDiscount, AgentDiscount, MasterDiscount, SuperDiscount, dbo.f_GetDateTime2()
	FROM CustDiscount3rd_Member cs WITH(NOLOCK)
		CROSS APPLY (SELECT 9916 as SportType, 2400 as BetType			
						UNION ALL SELECT 9917, 2400) AS t
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND cs.SportType = 9911
		AND cs.BetType = 2400   

	DELETE @tmpCust		
END


DROP TABLE #tblCust
GO	
