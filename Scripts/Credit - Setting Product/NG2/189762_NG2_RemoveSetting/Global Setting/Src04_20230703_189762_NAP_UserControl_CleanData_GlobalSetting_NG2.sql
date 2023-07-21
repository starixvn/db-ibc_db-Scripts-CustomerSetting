/*<info serverAlias="DBPOL-NAP_UserControl"></info>*/
/*
	Created by: Tacy@20230703
	Task: NG2 - Remove Setting
		https://nexdev.net/issues/189762
	DB: DBPOL.NAP_UserControl
*/ 
-------------------------------------------------
DECLARE @tbFunc TABLE (FuncID INT)

INSERT INTO @tbFunc (FuncID)
SELECT FuncID
FROM eaFunction WITH (NOLOCK)
WHERE FuncName LIKE '%NG2%'

DELETE m
FROM dbo.eaMenu m WITH (ROWLOCK) 
INNER JOIN @tbFunc t ON m.FuncID=t.FuncID

DELETE f
FROM eaFunction f WITH (ROWLOCK)
INNER JOIN @tbFunc t ON f.FuncID=t.FuncID

DELETE g
FROM eaGroupPolicy g WITH (ROWLOCK)
INNER JOIN @tbFunc t ON g.FuncID=t.FuncID

DELETE u
FROM eaUserPolicy u WITH (ROWLOCK)
INNER JOIN @tbFunc t ON u.FuncID=t.FuncID

-------------------------------------------------
DELETE FROM eaGroupConfiguration WITH (ROWLOCK) 
WHERE ProductId in (23)