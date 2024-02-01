/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20230224
	Task: NAP LM - Enhance Bet Setting function for AM to use RedmineID:#178105
	DB: DBCUST/CustDB

	Revision:
		- 20240201@Tacy: Run on SIT
	
*/

IF NOT EXISTS(SELECT TOP 1 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Dep_CustBetLimit_Special'  
    AND COLUMN_NAME = 'MinBet')  
BEGIN
	ALTER TABLE Dep_CustBetLimit_Special ADD MinBet MONEY
END

IF EXISTS(SELECT TOP 1 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Dep_CustBetLimit_Special'  
    AND COLUMN_NAME = 'MinBet')  
BEGIN
	-- Update Agent
	UPDATE d 
	SET d.MinBet = a.MinBet
	FROM Dep_CustBetLimit_Special d WITH(UPDLOCK)
	INNER JOIN Dep_CustBetSettingGame_Agent a WITH(NOLOCK) ON d.AgentID = a.CustID AND d.SportType = a.SportType AND d.Bettype = a.BetType
	WHERE d.MaxBet IS NOT NULL AND d.AgentID IS NOT NULL AND d.SportType NOT IN (161, 202)
	-- Update licensee
	UPDATE d 
	SET d.MinBet = a.MinBet
	FROM Dep_CustBetLimit_Special d WITH(UPDLOCK)
	CROSS APPLY (
			SELECT TOP 1 custid 
			FROM Dep_CustSuper WITH(NOLOCK)
			WHERE currency = d.CurrencyID AND site = d.Site
	) s
	INNER JOIN Dep_CustBetSettingGame_Agent a WITH(NOLOCK) ON s.custid = a.CustID AND d.SportType = a.SportType AND d.Bettype = a.BetType
	WHERE d.MaxBet IS NOT NULL AND d.AgentID IS NULL AND d.SportType NOT IN (161, 202)
END