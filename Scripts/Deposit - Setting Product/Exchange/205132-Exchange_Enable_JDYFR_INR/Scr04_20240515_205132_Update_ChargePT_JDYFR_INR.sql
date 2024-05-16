/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240515
	Task: update exchange PT [Redmine:#205132]
	DB: DBCUST/CustDB
*/

USE Custdb
GO

DECLARE @SuperId INT

SELECT @SuperId = ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
	AND ci.Enabled = 1
	AND (
		(cs.site IN ('JDYFR') AND Ci.currency IN (61))
	)

UPDATE Dep_ChargeInfoSetting WITH (ROWLOCK,UPDLOCK)
SET RepUpdateTime=SYSDATETIME()
	, PT=87.5
WHERE CustID=@SuperId
GO