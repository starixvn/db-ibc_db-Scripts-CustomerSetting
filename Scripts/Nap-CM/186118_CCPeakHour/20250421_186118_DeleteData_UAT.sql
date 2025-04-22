/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20250421@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Migrate Data to _UAT [186118]
*/
--===================================================================================

DELETE FROM CustomerClassSpread_UAT WITH(ROWLOCK,UPDLOCK) 
OUTPUT DELETED.PolicyID, [dbo].[f_GetDateTime2]() 
INTO CustomerClassSpread_UAT_Del_InHouse(PolicyID, RepUpdateTime )
GO

DELETE FROM CustomerClassSpreadDetail_UAT WITH(ROWLOCK,UPDLOCK) 
OUTPUT DELETED.PolicyID, DELETED.SiteID, DELETED.Currency, DELETED.[Platform], DELETED.SportType, [dbo].[f_GetDateTime2]() 
INTO CustomerClassSpreadDetail_UAT_Del_InHouse(PolicyID, SiteID, Currency, [Platform], SportType, RepUpdateTime )
GO

CREATE TABLE #CCSpreadClass(PolicyID INT, CustomerClass SMALLINT, IsFinished BIT DEFAULT(0))
CREATE TABLE #CCSpreadClass_temp(PolicyID INT, CustomerClass SMALLINT)

INSERT INTO #CCSpreadClass(PolicyID, CustomerClass)
SELECT PolicyID, CustomerClass
FROM CustomerClassSpreadClass_UAT WITH(NOLOCK)

WHILE 0 = 0
BEGIN
	TRUNCATE TABLE #CCSpreadClass_temp

	UPDATE TOP(2000) #CCSpreadClass
	SET	isFinished = 1
	OUTPUT	DELETED.PolicyID, DELETED.CustomerClass
	INTO	#CCSpreadClass_temp (PolicyID, CustomerClass)
	WHERE	isFinished = 0

	IF	@@ROWCOUNT = 0
		BREAK

	DELETE a
	OUTPUT	DELETED.PolicyID, DELETED.CustomerClass, [dbo].[f_GetDateTime2]()
	INTO CustomerClassSpreadClass_UAT_Del_InHouse(PolicyID, CustomerClass, RepUpdateTime)
	FROM CustomerClassSpreadClass_UAT a WITH (ROWLOCK,UPDLOCK)
		INNER JOIN #CCSpreadClass_temp b ON a.PolicyID = b.PolicyID AND a.CustomerClass = b.CustomerClass
END

DROP TABLE #CCSpreadClass
DROP TABLE #CCSpreadClass_temp
GO