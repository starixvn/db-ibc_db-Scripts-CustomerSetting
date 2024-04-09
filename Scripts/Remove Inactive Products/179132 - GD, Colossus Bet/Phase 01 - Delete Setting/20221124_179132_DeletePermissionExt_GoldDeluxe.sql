/*<info serverAlias="DBCust-NAP_UserControl"></info>*/
/*	
	Created: 20221124@Tacy
	Task: GoldDeluxe & Fishing Gold - Delete permission on Ext
		https://nexdev.net/issues/174511
		https://nexdev.net/issues/179132
	DB: DBCUST/NAP_UserControl
*/
USE NAP_UserControl
GO 

DECLARE @tbFunc TABLE (FuncID INT)

INSERT INTO @tbFunc (FuncID)
SELECT FuncID
FROM eaFunction WITH (NOLOCK)
WHERE FuncName LIKE '%Gold Deluxe%' OR FuncName LIKE '%Fishing%'

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