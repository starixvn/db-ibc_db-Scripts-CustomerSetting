/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20250421@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Migrate Data to _UAT [186118]
*/
--===================================================================================
SET IDENTITY_INSERT [dbo].[CustomerClassSpread_UAT] ON;

INSERT INTO CustomerClassSpread_UAT(PolicyID, PolicyTitle, Spread, Enable, IsTest, LastModifiedUser, LastModifiedTime, IsLive, Type, RepUpdateTime)	
SELECT PolicyID, PolicyTitle, Spread, Enable, IsTest, LastModifiedUser, LastModifiedTime, IsLive, Type, [dbo].[f_GetDateTime2]() AS RepUpdateTime
FROM CustomerClassSpread WITH(NOLOCK)

	SET IDENTITY_INSERT [dbo].[CustomerClassSpread_UAT] OFF;
GO

INSERT INTO CustomerClassSpreadDetail_UAT(PolicyID, SiteID, Currency, [Platform], SportType, RepUpdateTime)	
SELECT PolicyID, SiteID, Currency, [Platform], SportType, [dbo].[f_GetDateTime2]() AS RepUpdateTime
FROM CustomerClassSpreadDetail WITH(NOLOCK)
GO

CREATE TABLE #CCSpreadClass(PolicyID INT, CustomerClass SMALLINT, IsFinished BIT DEFAULT(0))
CREATE TABLE #CCSpreadClass_temp(PolicyID INT, CustomerClass SMALLINT)

INSERT INTO #CCSpreadClass(PolicyID, CustomerClass)
SELECT PolicyID, CustomerClass
FROM CustomerClassSpreadClass WITH(NOLOCK)

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

	INSERT INTO CustomerClassSpreadClass_UAT(PolicyID, CustomerClass, RepUpdateTime)
	SELECT PolicyID, CustomerClass, [dbo].[f_GetDateTime2]()
	FROM #CCSpreadClass_temp	
END

DROP TABLE #CCSpreadClass
DROP TABLE #CCSpreadClass_temp

GO