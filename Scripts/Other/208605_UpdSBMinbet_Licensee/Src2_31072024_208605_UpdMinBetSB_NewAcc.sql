/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240731@Winfred
	Task: [All licensees] - Change Sportsbook minbet to 30 new customer[Redmine: #208605] 
	DB: DBCust/CustDB
*/

USE CustDB
GO
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
(@maxcustID INT)
AS
BEGIN			
	
	IF (dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0
		)
		RETURN
		
	DECLARE @BatchNum INT = 300 

	CREATE TABLE #SportBettypeFilter (ProductID TINYINT, Sporttype SMALLINT, Bettype SMALLINT)
	CREATE TABLE #Supers(CustID INT PRIMARY KEY, site VARCHAR(20))

	CREATE TABLE #Member
	( CustID INT PRIMARY KEY CLUSTERED ,InsSetting BIT DEFAULT 0 
	)
	CREATE TABLE #MemberTemp
	( CustID INT PRIMARY KEY CLUSTERED )

	CREATE TABLE #SMATemp
	( CustID INT PRIMARY KEY CLUSTERED ,RoleID TINYINT )

	INSERT INTO #SportBettypeFilter (ProductID,SportType,Bettype)
	SELECT 1 AS ProductID, SportType, Bettype 
	FROM dbo.f_Dep_CustSetting_SportBetTypeSettingSelect(1,10,0)

	INSERT INTO #Supers(custid, site)
	SELECT cs.custid, cs.site
	FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
		INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
	WHERE  l.IsActive = 1-- AND l.licenseeName IN ('Athena000')
		AND cs.username NOT LIKE '3rdSuper%'
		AND cs.currency = 51

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT c.CustID FROM Customer c WITH(NOLOCK) 
		INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
	WHERE roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #SMATemp(CustID,RoleID)
	SELECT c.custid, roleid
	FROM Custinfo c WITH (NOLOCK)
		INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
	WHERE roleid IN (2,3,4) AND Enabled = 1 AND c.custid > @maxcustID 
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO #Member(CustID)
	SELECT c.custid
	FROM dbo.CustInfo c WITH(NOLOCK)
		INNER JOIN #Supers s ON s.CustID=c.srecommend
		CROSS APPLY(SELECT top 1 minbet FROM Dep_CustBetSettingGame_Member b WITH(NOLOCK) WHERE CustID = c.CustID ) d
	WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND c.custid > @maxcustID
		AND c.roleid = 1
		AND c.Enabled=1

	UPDATE d
	SET d.minbet = 30 
	from #SMATemp tmp
	CROSS APPLY #SportBettypeFilter s
	CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGame_Agent WITH(ROWLOCK)
				WHERE CustID = tmp.CustID AND SportType = s.Sporttype 
					AND BetType = s.Bettype AND MinBet < 30) d

	UPDATE d
	SET d.minbet = 30 
	from #SMATemp tmp
	CROSS APPLY #SportBettypeFilter s
	CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGameGroup_Member WITH(ROWLOCK)
				WHERE AgentID = tmp.CustID AND SportType = s.Sporttype 
					AND BetType = s.Bettype AND MinBet < 30) d
	Where tmp.RoleID = 2

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTemp
		UPDATE TOP (@BatchNum)  t SET t.InsSetting = 1 
		OUTPUT DELETED.CustID INTO #MemberTemp(CustID) FROM #Member t WHERE t.InsSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		UPDATE d
		SET d.minbet = 30 
		from #MemberTemp tmp
		CROSS APPLY #SportBettypeFilter s
		CROSS APPLY(SELECT top 15 minbet from Dep_CustBetSettingGame_Member WITH(ROWLOCK)
					WHERE CustID = tmp.CustID AND SportType = s.Sporttype 
						AND BetType = s.Bettype AND MinBet < 30) d

	END
	DROP TABLE #MemberTemp
END		
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
DECLARE @MaxCustID INT
	
SELECT @MaxCustID = xxx
EXEC dbo.Acc_Dep_DynamicCustSetting_09 @MaxCustID=@MaxCustID
