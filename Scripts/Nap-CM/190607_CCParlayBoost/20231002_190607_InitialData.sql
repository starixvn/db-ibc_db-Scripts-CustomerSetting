/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20231002@Winfred
	DB: DBCUST/CustDB, DBTP-bodb02
	Task:  Allow to offer Parlay Boost on rule setting and add in house replication
	Revisions:
		- 20231002@Winfred: NAP CM Customer Class - Allow to offer Parlay Boost on rule setting [RedmineID: #190607]
*/
TRUNCATE TABLE CustomerClassUtilityOffer
TRUNCATE TABLE CustomerClassUtilityOfferDetail


CREATE TABLE #Site(Site SMALLINT, isdeposit BIT )
CREATE TABLE #UtilityOffer(ID INT , PolicyTitle VARCHAR(500), UtilityOffering VARCHAR(500), IsTest TINYINT, LastModifiedUser INT, LastModifiedTime DATETIME, isFinished BIT DEFAULT(0))
CREATE TABLE #CC(CustomerClass SMALLINT,CustomerClassName VARCHAR(100))
CREATE TABLE #Currency(Currency INT,ID INT)

INSERT INTO #Site(Site,isDeposit)
SELECT TOP 5 siteid, isDeposit  FROM SITE WITH(NOLOCK) where isActive = 1 and isDeposit =0 
UNION
SELECT  TOP 5 SiteID, isDeposit FROM SITE WITH(NOLOCK) where isActive = 1 and isDeposit =1


INSERT INTO #UtilityOffer(ID, PolicyTitle, UtilityOffering, IsTest, LastModifiedUser, LastModifiedTime)
SELECT 0 AS ID, 'Good Customer' AS PolicyTitle, 1 AS UtilityOffering, 0 AS IsTest, 8 AS LastModifiedUser, GETDATE() AS LastModifiedTime 
UNION ALL
SELECT 1 AS ID, 'Normal Customer' AS PolicyTitle, 1 AS UtilityOffering, 0 AS IsTest, 8 AS LastModifiedUser, GETDATE() AS LastModifiedTime 

INSERT INTO #CC(CustomerClass, CustomerClassName)
Select 13, 'Robot' union all 
Select 200, 'New' union all 
Select 2000, 'Suspicious +' union all 
Select 2001, 'Healthy -' union all 
Select 2002, 'Moderate +' union all 
Select 2003, 'Suspicious +' union all 
Select 2004, 'Dangerous +' union all 
Select 2005, 'Dangerous +' union all 
Select 999, 'Healthy +'  

INSERT INTO #Currency(Currency, ID)
SELECT top 50 exchangeId , 0 AS ID FROM exchange e with(nolock) where OfferSite in ( 0,1) AND exchangeId NOT IN (15, 20)
Union 
SELECT top 50 exchangeId  , 1 AS ID FROM exchange e with(nolock) where OfferSite = 2 AND exchangeId NOT IN (4) 

DECLARE @ID SMALLINT = 0, @PolicyID	INT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #UtilityOffer
	SET isFinished = 1
		,@ID=ID
	WHERE isFinished = 0	
			
	IF @@ROWCOUNT = 0 BREAK

	INSERT INTO CustomerClassUtilityOffer (PolicyTitle, UtilityOffering, IsTest, LastModifiedUser, LastModifiedTime)	
	SELECT PolicyTitle, UtilityOffering, IsTest, LastModifiedUser, LastModifiedTime
	FROM #UtilityOffer where ID  = @ID
		
	SET @PolicyID = SCOPE_IDENTITY()

	INSERT INTO CustomerClassUtilityOfferDetail(PolicyID, SiteID, CustomerClass,Currency)	
	SELECT @PolicyID, s.Site , cc.CustomerClass , c.Currency
	FROM #Site s
		INNER JOIN #Currency c ON s.isdeposit = c.ID
		CROSS APPLY #CC cc
	WHERE s.isdeposit = @ID

	IF @ID = 0
	BEGIN
		-- all Site + only currency
		INSERT INTO CustomerClassUtilityOfferDetail(PolicyID, SiteID, CustomerClass,Currency)	
		SELECT @PolicyID, s.Site , cc.CustomerClass , CASE s.Site WHEN 0 THEN 20  
										 WHEN -1 THEN 15 
										 WHEN -2 THEN 4 END AS Currency
		FROM (  SELECT 0 AS Site UNION
				SELECT -1 AS Site UNION
				SELECT -2 AS Site 
				) s
			CROSS APPLY #CC cc
		
		-- only Site + all currency
		INSERT INTO CustomerClassUtilityOfferDetail(PolicyID, SiteID, CustomerClass,Currency)	
		SELECT TOP 1 @PolicyID, s.siteid, cc.CustomerClass , 0 AS Currency
		FROM SITE s WITH(NOLOCK) 
			CROSS APPLY #CC cc
		WHERE isActive = 1 AND isDeposit = @ID AND siteid NOT IN (SELECT Site FROM #Site)

	END

END

DROP TABLE #CC
DROP TABLE #Site
DROP TABLE #UtilityOffer
DROP TABLE #Currency