/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/05/16
  Task: Alpha - Adjust bet limit of Indo customers [redmine : #188177]
  DB: DBCUST/CustDB
 
  Revisions: Initial Script Collect Cust Setting Need Update
*/

--DEPLOY THIS @DBCUST.CustDB --------

	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	SET NOCOUNT ON
	DECLARE @MinBet_new			MONEY = 10


	--Currency apply setting
	CREATE TABLE #Exchange (ExchangeId INT PRIMARY KEY  )

	INSERT INTO #Exchange
	SELECT ExchangeId 
	FROM exchange WITH (NOLOCK)
	WHERE currency IN ('IN', 'IND', 'IDD', 'IDR', 'DDD')									-- currency apply setting
	   
	-- Just Update Minbet BetSetting Global of Bitcoin
	UPDATE bs 
		SET bs.MinBet = @MinBet_new
		,	bs.DefaultMinBet = @MinBet_new
	FROM ProductBetSetting bs WITH (ROWLOCK , UPDLOCK)
	INNER JOIN #Exchange e ON bs.Currency = e.ExchangeId
	WHERE bs.Sporttype = 175 AND bs.Bettype = 7901											-- Get SportType BetType By BitCoin

	DROP TABLE #Exchange





