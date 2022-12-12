/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220412
	Task:  Adjust Soccer BetLimit 368Cash - deposit RedmineID:#181523
	DB: DBCust/CustDB
*/

DECLARE
	  @SuperID				INT = 13682916 -- 368CashSuperIN
	, @BetLimit				VARCHAR(MAX)
	, @AgentID				INT = 13682919  -- 368CashIN01
	, @IsAgentOnly			BIT = 0
	, @ApplyExistedMem		BIT= 1	

BEGIN
	SET NOCOUNT ON

	DECLARE  @mrecommend	INT

	DECLARE @NewBetLimitTbl TABLE (
		SportType			INT
		, BetType			INT
		, MinBet			MONEY
		, MaxBet			MONEY
		, MaxPerMatch		MONEY
		, MaxPerNumber		MONEY
		, MaxPayoutPerMatch	MONEY
		)
	DECLARE @ProductID		TINYINT,
			@ProductName	VARCHAR(50),
			@SettingLevel	TINYINT

	INSERT @NewBetLimitTbl(SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch)
	SELECT 1 AS SportType, 1 AS BetType, 1 AS MinBet, 300000 AS MaxBet, 300000 AS MaxPerMatch, NULL AS MaxPerNumber, 2400000 AS MaxPayoutPerMatch

	CREATE TABLE #tempSMA(
					CustID			INT,
					SportType		INT ,
					BetType			INT ,
					MinBet			MONEY,
					MaxBet			MONEY,
					MaxPerMatch		MONEY,
					MaxPerNumber		MONEY,
					MaxPayoutPerMatch	MONEY
					)

	-- Select ProductID and SettingLevel
	SELECT @ProductID = ProductID, @SettingLevel = SettingLevel
	FROM (	SELECT TOP 1 ps.ProductID, ps.SettingLevel
			FROM Dep_ProductSettingDetail AS psd WITH(NOLOCK)
				INNER JOIN	@NewBetLimitTbl AS tmp ON	psd.SportType = tmp.SportType AND	psd.BetType = tmp.BetType
				INNER JOIN Dep_ProductSetting AS ps WITH (NOLOCK) ON ps.ProductSettingID = psd.ProductSettingID
			WHERE	ps.ProductID IS NOT NULL
				AND	ps.SettingLevel IS NOT NULL
				AND ps.SettingType IN(10,12)	-- Bet Limit
		 ) iq

	IF NOT EXISTS (SELECT 1 FROM Dep_ProductSetting ps WITH(NOLOCK) 
								INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID 
							WHERE ProductID=@ProductID AND SettingType IN(10,12) AND CustID=@SuperID)
		SELECT @IsAgentOnly=0

	IF(@IsAgentOnly=0)
	BEGIN		
		SELECT @mrecommend=mrecommend FROM Customer WITH(NOLOCK) WHERE custid=@AgentID
					
		INSERT INTO #tempSMA(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch)
		SELECT @SuperID,s.SportType,s.BetType,s.MinBet,s.MaxBet,s.MaxPerMatch,s.MaxPerNumber,s.MaxPayoutPerMatch
		FROM @NewBetLimitTbl s
		UNION ALL
		SELECT @mrecommend,s.SportType,s.BetType,s.MinBet,s.MaxBet,s.MaxPerMatch,s.MaxPerNumber,s.MaxPayoutPerMatch
		FROM @NewBetLimitTbl s

	END

	INSERT INTO #tempSMA(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch)
	SELECT @AgentID,s.SportType,s.BetType,s.MinBet,s.MaxBet,s.MaxPerMatch,s.MaxPerNumber,s.MaxPayoutPerMatch
	FROM @NewBetLimitTbl s

	UPDATE main
	SET main.minbet			= tmp.MinBet
		, main.maxbet		= tmp.MaxBet
		, main.maxpermatch	= tmp.MaxperMatch
		, main.MaxPerNumber		= tmp.MaxPerNumber
		, main.MaxPayoutPerMatch	= tmp.MaxPayoutPerMatch
	FROM dbo.Dep_CustBetSettingGame_Agent main WITH(ROWLOCK)
		INNER JOIN #tempSMA tmp	ON main.CustID=tmp.CustID AND tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
	WHERE (
				main.minbet		<> tmp.MinBet
			OR main.maxbet		<> tmp.MaxBet
			OR main.maxpermatch <> tmp.MaxperMatch
			OR main.MaxPerNumber <> tmp.MaxPerNumber
			OR main.MaxPayoutPerMatch <> tmp.MaxPayoutPerMatch
			)

	DELETE t 
	FROM #tempSMA t 
	INNER JOIN Dep_CustBetSettingGame_Agent cs WITH(NOLOCK) ON t.custid = cs.custid AND cs.sporttype = t.Sporttype AND cs.bettype = t.Bettype

	INSERT INTO dbo.Dep_CustBetSettingGame_Agent(CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch)
	SELECT CustID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch
	FROM #tempSMA t

	INSERT INTO Dep_CustBetSettingGameGroup_Member(AgentID,SportType,BetType,MinBet,MaxBet,MaxPerMatch,MaxPerNumber,MaxPayoutPerMatch)
	SELECT @AgentID,t.SportType,t.BetType,t.MinBet,t.MaxBet,t.MaxPerMatch,t.MaxPerNumber,t.MaxPayoutPerMatch
	FROM @NewBetLimitTbl t
		LEFT JOIN Dep_CustBetSettingGameGroup_Member m WITH(NOLOCK) ON  m.AgentID = @AgentID AND t.SportType= m.SportType AND t.BetType = m.BetType
	WHERE m.AgentID IS NULL
	
	IF @ApplyExistedMem=1
	BEGIN
		UPDATE main
		SET main.minbet			= tmp.MinBet
			, main.maxbet		= tmp.MaxBet
			, main.maxpermatch	= tmp.MaxperMatch
			, main.MaxPerNumber		= tmp.MaxPerNumber
			, main.MaxPayoutPerMatch	= tmp.MaxPayoutPerMatch
		FROM dbo.Dep_CustBetSettingGameGroup_Member main WITH(ROWLOCK)
			INNER JOIN @NewBetLimitTbl tmp	ON tmp.SportType = main.sporttype AND tmp.BetType = main.bettype
		WHERE (
					main.minbet		<> tmp.MinBet
				OR main.maxbet		<> tmp.MaxBet
				OR main.maxpermatch <> tmp.MaxperMatch
				OR main.MaxPerNumber <> tmp.MaxPerNumber
				OR main.MaxPayoutPerMatch <> tmp.MaxPayoutPerMatch
				)
				AND main.AgentID = @AgentID

		EXEC Acc_Dep_DynamicCustSetting_02				
				@CustID=@AgentID,
				@BetLimit=@BetLimit,
				@Mode = 'GameBetLimit'

	END

	IF NOT EXISTS (SELECT 1 FROM Dep_ProductSetting ps WITH(NOLOCK) 
									INNER JOIN Dep_LicenseeProductSetting d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID WHERE ProductID=@ProductID AND SettingType IN(10,12) AND CustID=@SuperID)
		BEGIN
			INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
			SELECT @SuperID,ProductSettingID
			FROM Dep_ProductSetting WITH(NOLOCK)
			WHERE ProductID=@ProductID AND SettingType IN (10,12)
		END		

END


GO
