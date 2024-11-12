/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@20241112
	Task: Correct data SiteBuider New Currencies : 
		Site = ZT001CIS, Currencies: 55,56,57,82,85,86 [RM:213541]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
DECLARE @PT_Sportsbook SMALLMONEY = 95 -- get from site builder log
	,@SiteName		VARCHAR(10)  = 'ZT001CIS'
	,@CurrencyList VARCHAR(MAX) = ''
------------------------------------------
DECLARE @CurrencyTbl TABLE ( Currency INT)
INSERT INTO @CurrencyTbl(Currency)
		  SELECT 55 
UNION ALL SELECT 56 
UNION ALL SELECT 57 
UNION ALL SELECT 82 
UNION ALL SELECT 85 
UNION ALL SELECT 86 

SET @CurrencyList = (
		SELECT DISTINCT Currency 
		FROM @CurrencyTbl
		FOR Json PATH
	)
-------------------
DECLARE @ErrCode	INT = 0 
	, @ErrMsg		NVARCHAR(MAX) = '' 
	, @LicenseeId	INT = 0 
	, @ErrExtraInfo VARCHAR(MAX) = ''  -- Log DB
-------------------Init currency setting on bodb_licensee
EXEC bodb_Licensee.dbo.[API_SiteBuilder_LicenseeDB_CurrencyIns]
	 @SiteName		= @SiteName	
	,@CurrencyList	= @CurrencyList
	,@PT_Sportsbook	= @PT_Sportsbook
	,@IP			= ''
	,@ErrCode		= @ErrCode OUTPUT
	,@ErrMsg		= @ErrMsg OUTPUT
	,@LicenseeId	= @LicenseeId OUTPUT
	,@ErrExtraInfo	= @ErrExtraInfo OUTPUT

SELECT @ErrCode		AS ErrCode		
	,@ErrMsg		AS ErrMsg		
	,@LicenseeId	AS LicenseeId	
	,@ErrExtraInfo	AS ErrExtraInfo
	,'InitLicenseeDBSetting'	AS Step

IF ISNULL(@LicenseeId,0) <> 0 -- Init company Winlimit
BEGIN
	EXEC CUSTDB.dbo.[Dot_Dep_CWL_InsertSetting]
		 @LicenseeID	= @LicenseeID	
		,@ErrCode		= @ErrCode	OUTPUT
		,@ErrMsg		= @ErrMsg	OUTPUT	

	SELECT @ErrCode		AS ErrCode		
		,@ErrMsg		AS ErrMsg		
		,@LicenseeId	AS LicenseeId	
		,'InitCompanyWinlimit'	AS Step
END