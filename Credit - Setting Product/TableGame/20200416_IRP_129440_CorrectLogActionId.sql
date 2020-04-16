/*
	Created by: Elodie
	Date: 20200416
	Task: Update ActionId
	DB: DBCUST/CustDB
*/
DECLARE @OldAction TABLE (ID INT IDENTITY(1,1), ActionId INT)
DECLARE @NewAction TABLE (ID INT IDENTITY(1,1), ActionId INT)

INSERT INTO @OldAction (ActionId)
SELECT la.ActionID
FROM LogAction la WITH (NOLOCK)
	INNER JOIN LogActionDetail ld WITH (NOLOCK) ON la.ActionID = ld.ActionID
WHERE productid = 28
ORDER BY la.ActionID

INSERT INTO @NewAction (ActionId)
SELECT la.ActionID
FROM LogAction la WITH (NOLOCK)
	INNER JOIN LogActionDetail ld WITH (NOLOCK) ON la.ActionID = ld.ActionID
WHERE productid = 44
ORDER BY la.ActionID

UPDATE l
SET l.ActionID = na.ActionId
FROM UserLog_RunSP l WITH (NOLOCK)
	INNER JOIN @OldAction oa ON oa.ActionId = l.ActionID
	INNER JOIN @NewAction na ON na.ID = oa.ID
WHERE logid BETWEEN 857919406 ANd 859647906
