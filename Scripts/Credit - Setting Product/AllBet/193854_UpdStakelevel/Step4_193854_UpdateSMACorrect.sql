/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230918
	Task: Allbet - Change Play Currency - Change bet limit for RM,HK$, RMB, HKK, USD and re-open Credit Markets [Redmine: 193854]
	DB: DBCust/CustDB
	Step 4 : Correct Data
*/
----------------------------------------------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
AS
BEGIN
	SET NOCOUNT ON

	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN

	CREATE TABLE #supers		(CustID INT PRIMARY KEY)
	CREATE TABLE #CustListAgent (CustID INT PRIMARY KEY,SportType	SMALLINT,BetType INT)
	
	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.Site NOT IN ('CN88')
		AND ci.currency IN ( 2, 67) --RM, HKK
	
	INSERT INTO #CustListAgent(CustID, SportType, BetType)
	SELECT ci.custid, SportType , BetType
	FROM dbo.custInfo ci WITH (NOLOCK)
		INNER JOIN #supers S ON srecommend = s.custid
		CROSS APPLY (
			SELECT TOP 1 SportType,  BetType
			FROM CustStakeLevel_Agent cs  WITH (NOLOCK) where cs.CustId = ci.custid AND cs.SportType = 211 AND cs.BetType = 2401  
			AND StakeLevelList in ('2627',',2627','2628',',2628')
	) kq
	WHERE ci.Enabled = 1 AND ci.roleid in (2,3,4)
	
	UPDATE cs
	SET cs.StakeLevelList =  ''
	FROM CustStakeLevel_Agent cs WITH (ROWLOCK, UPDLOCK) 
		INNER JOIN #CustListAgent ci ON cs.CustId = ci.custid AND cs.SportType = ci.SportType AND cs.BetType = ci.BetType

	DROP TABLE #supers
	DROP TABLE #CustListAgent
END
GO


EXEC dbo.Acc_DynamicCustSetting3rd_09
GO
