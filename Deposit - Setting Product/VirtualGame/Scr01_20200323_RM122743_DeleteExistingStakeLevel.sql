/*
	Created: Eden
	Date: 20191029
	Task: DELETE existed setting for Virtual game DEPOSIT
	DB: DBCust/CustDB
*/

DECLARE @SportBettype TABLE (SportType SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype(SportType, BetType) VALUES (245, 4601)
DECLARE @CustTmp TABLE (CustID INT, SportType SMALLINT, BetType SMALLINT)
-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
WHILE (1 = 1)
BEGIN		
	INSERT INTO @CustTmp (CustID, SportType, BetType) 		
	SELECT TOP (4000) a.CustID,a.SportType,a.BetType
	FROM Dep_CustStakeLevel_Agent a WITH(NOLOCK)
		INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
		
	IF @@ROWCOUNT = 0 BREAK	

	DELETE csa
	FROM dbo.Dep_CustStakeLevel_Agent csa WITH(ROWLOCK)
		INNER JOIN @CustTmp cs ON cs.custid = csa.custid AND csa.bettype = cs.BetType AND csa.sporttype = cs.SportType
END

WHILE (1 = 1)
BEGIN		
	INSERT INTO @CustTmp (CustID, SportType, BetType) 		
	SELECT TOP (4000) a.CustID,a.SportType,a.BetType
	FROM Dep_CustStakeLevel_Member a WITH(NOLOCK)
		INNER JOIN @SportBettype t ON a.SportType = t.SportType and a.BetType = t.BetType
		
	IF @@ROWCOUNT = 0 BREAK	

	DELETE csm
	FROM dbo.Dep_CustStakeLevel_Member csm WITH(ROWLOCK)
		INNER JOIN @CustTmp cs ON cs.custid = csm.custid AND csm.bettype = cs.BetType AND csm.sporttype = cs.SportType
END
