	/*<info serverAlias="DBCUST-CustDB"></info>*/
	/*
		Created: 20220608@Winfred
		Task: Correct data stakelevel from Soccer Mines [Redmine: #172671]
		DB: DBCUST/CustDB
	*/
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #SiteOffer (siteid int,currency tinyint)
	CREATE TABLE #InitialStake (StakeLevelID int,siteid int,currency tinyint,isfinished bit default(0))
	CREATE TABLE #StakeTemp (StakeLevelID int)

	DECLARE @srecommend INT , @Bettype  INT 
	SET  @Bettype = 4605
	-- licensee exists Soccer Mines
	INSERT INTO #SiteOffer(siteid,currency )
	SELECT DISTINCT s.siteid,c.currency
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
		INNER JOIN Dep_CustStakeLevel_Agent csa WITH (NOLOCK) ON c.custid = ci.custid 
								AND csa.SportType = 245 AND csa.BetType = @Bettype
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1
		AND c.currency IN (SELECT ExchangeId FROM exchange WITH(NOLOCK)
							WHERE currency IN ('RM','KHR','PLN','USDT','US$','AUD','MMK','MKK','CHF','UUS','BND','YUN','RMB','DKK','NOK', 'SEK', 'IN', 'TB', 'Won','INH','Euro','INR','RUB','GBP','JPY','BDT', 'BRL', 'PKR'))
		--AND s.Site NOT IN ('Athena000')
		AND EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting l WITH(NOLOCK)
					WHERE productSettingID = 34
					AND c.custid = l.custid)
	-- Initial stake level Soccer Mines
	INSERT INTO #InitialStake(StakeLevelID,siteid,currency )
	SELECT DISTINCT a.StakeLevelID,a.SiteID,a.ExchangeID
	FROM Dep_StakeLevel a WITH(NOLOCK)
	WHERE a.GameTypeID = @Bettype

	DELETE a 
	FROM #InitialStake a
	LEFT JOIN #SiteOffer so ON a.siteid = so.siteid AND a.currency = so.currency
	WHERE so.siteid IS NOT NULL

	--SELECT * FROM #InitialStake a
	--LEFT JOIN #SiteOffer so ON a.siteid = so.siteid AND a.currency = so.currency
	--WHERE so.siteid IS NULL

	DECLARE @batch int = 3000
	
		WHILE EXISTS(SELECT TOP 1 1 FROM #InitialStake)
		BEGIN
			DELETE TOP (@batch) #InitialStake
			OUTPUT DELETED.StakeLevelID 
			INTO #StakeTemp(StakeLevelID)

			IF @@ROWCOUNT=0
				BREAK		

			DELETE cg
			FROM Dep_StakeLevel cg WITH(ROWLOCK)		
				INNER JOIN #StakeTemp  t 
					ON cg.StakeLevelID=t.StakeLevelID

			TRUNCATE TABLE #StakeTemp
	END

	DELETE cg
	FROM Dep_CustStakeLevel_Agent  cg WITH(ROWLOCK)		
	WHERE cg.CustID IN (47854310,47854311,47854312,47854331,47854332,47854333) AND cg.SportType = 245 AND BetType = @Bettype

	DELETE cg
	FROM Dep_CustStakeLevel_Member  cg WITH(ROWLOCK)		
	WHERE cg.CustID IN (47854313,47854314,47854334,47854335,47922133,47922138,58942020,58942021) AND cg.SportType = 245 AND BetType = @Bettype

	DROP TABLE #InitialStake
	DROP TABLE #SiteOffer
	DROP TABLE #StakeTemp
END	
GO
-- END STEP 1.1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 1.1: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
EXEC Acc_Dep_DynamicCustSetting_09




