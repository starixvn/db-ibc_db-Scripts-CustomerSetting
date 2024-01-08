/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231214@Winfred
	DB: DBCUST/CustDB
	Task: [NAP CM] Customer Class - Auto include new items for rows that is selected option "All"
	Revisions:
		- 20231214@Winfred: [NAP CM] Customer Class - Auto include new items for rows that is selected option "All" [RedmineID: #186699] 
*/
-- Clone Data policy
--===================================================================================
USE CustDB
GO

DECLARE @PolicyID_old  INT, @PolicyID_New  INT , @IsAllCurrency BIT, @IsAllNewSite BIT
, @LastModifiedTime	DATETIME, @UserID	INT, @RuleIDs VARCHAR(MAX) = ''
DECLARE @StartRun			DATETIME
		, @EndRun			DATETIME
		, @Duration			INT
		, @logSpData		NVARCHAR(MAX)
		, @xml				XML
		, @PolicyTitle_New 	VARCHAR(500)
		, @SportType		SMALLINT
		, @IsTest			TINYINT
CREATE TABLE #CustomerClassSiteManagement( PolicyID INT, Site NVARCHAR(50), Currency TINYINT, Platform TINYINT)
CREATE TABLE #Policy_Clone( PolicyID INT,IsAllCurrency BIT, IsAllNewSite BIT, isFinished BIT DEFAULT(0))  
CREATE TABLE #Rule_Clone( RuleID INT)  

INSERT INTO #Policy_Clone(PolicyID, IsAllCurrency, IsAllNewSite) 
SELECT 10 AS Policy, 1 AS IsAllCurrency, 1 AS IsAllNewSite -- BK - Problems Member All Platform
UNION
SELECT 15 AS Policy, 1 AS IsAllCurrency, 0 AS IsAllNewSite -- BK - Problems Member All Platform (credit)
UNION
SELECT 16 AS Policy, 1 AS IsAllCurrency, 0 AS IsAllNewSite -- BK - Problems Member All Platform (credit 789)
UNION
SELECT 13 AS Policy, 0 AS IsAllCurrency, 0 AS IsAllNewSite -- BK - No Restriction

SELECT @LastModifiedTime = GETDATE(), @UserID = 10278938 --starixIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) c
	SET isFinished = 1,
		@PolicyID_old = PolicyID,
		@IsAllCurrency = IsAllCurrency,
		@IsAllNewSite = IsAllNewSite
	FROM #Policy_Clone c
	WHERE isFinished = 0	
			
	IF @@ROWCOUNT = 0 BREAK 

	SELECT @StartRun = GETDATE()

	INSERT INTO #Rule_Clone(RuleID)
	SELECT RuleID 
	FROM CustomerClassPolicyRule  WITH (NOLOCK)
	WHERE PolicyID = @PolicyID_old

	SELECT @PolicyTitle_New = PolicyTitle + '_New' 
			, @SportType = SportType
			, @IsTest = IsTest
	FROM CustomerClassPolicyManagement WITH (NOLOCK)
	WHERE PolicyID = @PolicyID_old

	INSERT INTO CustomerClassPolicyManagement( PolicyTitle, SportType, IsTest, LastModifiedUser, LastModifiedTime)
	SELECT @PolicyTitle_New AS PolicyTitle,	@SportType, @IsTest, @UserID, @LastModifiedTime

	SET @PolicyID_New = SCOPE_IDENTITY()

	INSERT INTO CustomerClassPolicyRule(PolicyID, RuleID)	
	SELECT @PolicyID_New ,RuleID 
	FROM #Rule_Clone

	SELECT @RuleIDs = (SELECT STRING_AGG(CAST(RuleID AS VARCHAR(20)), ',') 
						WITHIN GROUP (ORDER BY RuleID)
						FROM #Rule_Clone  WITH(NOLOCK))

	-- Log new updated data
	SET @xml = (
			SELECT	@UserID							AS '@UserID',				
					''								AS '@IP',
					@PolicyID_New					AS '@PolicyID',
					CAST(@SportType AS VARCHAR(20))	AS '@SportType',
					CAST(@IsTest AS VARCHAR(20))	AS '@IsTest',
					@PolicyTitle_New				AS '@PolicyTitle',
					@RuleIDs						AS '@RuleIDs',
					''								AS '@ErrMsg',
					''								AS '@ErrCode'
			FOR XML PATH('R'),
			TYPE
		)
	SET @logSpData = REPLACE(CONVERT(VARCHAR(MAX), @xml), '" />', '"/"')

	SELECT @EndRun	= GETDATE(), @Duration = DATEDIFF(MILLISECOND, @StartRun, @EndRun)

	EXEC  Acc_WriteLog_UserLog_RunSP_Wrapper
				@CustID  = @UserID,
				@UserID = @UserID,
				@ActionID = 31903,
				@TrackingValue = @LogSPData,
				@duration = @Duration

	IF @IsAllCurrency = 1
	BEGIN
		  
		INSERT INTO #CustomerClassSiteManagement(PolicyID, Site, Currency, Platform)   
		SELECT DISTINCT @PolicyID_New AS PolicyID, 
				a.Site, 
				0 AS Currency, 
				0 AS Platform
		FROM CustomerClassSiteManagement a WITH (NOLOCK)
		WHERE PolicyID = @PolicyID_old
		UNION 
		SELECT DISTINCT @PolicyID_New AS PolicyID, 
				Site, 
				0 AS Currency, 
				0 AS Platform
		FROM Site WITH (NOLOCK)
		WHERE @IsAllNewSite = 1 AND isActive = 1 
		AND isDeposit = 1 AND RepUpdateTime > '2024-01-01 07:23:15.63'
	END
	ELSE
	BEGIN
		 
		INSERT INTO #CustomerClassSiteManagement(PolicyID, Site, Currency, Platform)  
		SELECT DISTINCT @PolicyID_New AS PolicyID, 
				a.Site, 
				a.Currency AS Currency, 
				0 AS Platform
		FROM CustomerClassSiteManagement a WITH (NOLOCK)
		WHERE PolicyID = @PolicyID_old
	END

	INSERT INTO CustomerClassSiteManagement(PolicyID, Site, Currency, Platform, LastModifiedUser, LastModifiedTime)   
	SELECT DISTINCT PolicyID, 
				Site, 
				Currency, 
				Platform, 
				@UserID AS LastModifiedUser, 
				@LastModifiedTime AS LastModifiedTime  
	FROM #CustomerClassSiteManagement a

	SET @xml = (  
	SELECT @UserID        AS '@UserID',      
		   ''			  AS '@IP',       
		   0			  AS '@IsOverwrite',      
		  ''			  AS '@ErrMsg',
		  ''			  AS '@ErrCode',
		(  
			SELECT DISTINCT cs.PolicyID     AS '@PID',  
			s.Sites     AS '@S',  
			c.Currencies      AS '@C',  
			p.Platforms      AS '@P'   
			FROM #CustomerClassSiteManagement AS cs  
			CROSS APPLY(
					SELECT STRING_AGG(Site, ',') WITHIN GROUP (ORDER BY Site)  AS Sites
					FROM (SELECT DISTINCT CAST(Site AS VARCHAR(MAX)) AS Site
						FROM #CustomerClassSiteManagement WITH(NOLOCK)
						WHERE PolicyID = cs.PolicyID) mis
					) s
			CROSS APPLY(
					SELECT STRING_AGG(Platform, ',') WITHIN GROUP (ORDER BY Platform)  AS Platforms
					FROM (SELECT DISTINCT CAST(Platform AS VARCHAR(MAX)) AS Platform
						FROM #CustomerClassSiteManagement WITH(NOLOCK)
						WHERE PolicyID = cs.PolicyID) mis
					) p
			CROSS APPLY(
					SELECT STRING_AGG(Currency, ',') WITHIN GROUP (ORDER BY Currency)  AS Currencies
					FROM (SELECT DISTINCT CAST(Currency AS VARCHAR(MAX)) AS Currency
						FROM #CustomerClassSiteManagement WITH(NOLOCK)
						WHERE PolicyID = cs.PolicyID) mis
					) c
			ORDER BY cs.PolicyID  
			FOR XML PATH('PS'),  
			TYPE  
		)  
	FOR XML PATH('R'),  
	TYPE  
	)  
	SET @logSpData = REPLACE(CONVERT(VARCHAR(MAX), @xml), '" />', '"/"')  
	SELECT @EndRun = GETDATE(), @Duration = DATEDIFF(MILLISECOND, @StartRun, @EndRun)  

	EXEC  Acc_WriteLog_UserLog_RunSP_Wrapper
				@CustID  = @UserID,
				@UserID = @UserID,
				@ActionID = 31905,
				@TrackingValue = @LogSPData,
				@TrackingValue2 = Null,
				@duration = @Duration

	TRUNCATE TABLE #Rule_Clone
	TRUNCATE TABLE #CustomerClassSiteManagement
END

DROP TABLE #Rule_Clone
DROP TABLE #Policy_Clone
DROP TABLE #CustomerClassSiteManagement
GO
