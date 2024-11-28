/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@20241128
	Task: Correct data SiteBuider New Currencies : 
		Site = ZF1002SW, Currencies: 41,45,50,51,55,61 [RM:213541]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
DECLARE @PT_Sportsbook SMALLMONEY = 95 -- get from site builder log
	,@SiteName		VARCHAR(10)  = 'ZF1002SW'
	,@CurrencyList VARCHAR(MAX) = ''
------------------------------------------
DECLARE @CurrencyTbl TABLE ( Currency INT)
INSERT INTO @CurrencyTbl(Currency)
		  SELECT 41 
UNION ALL SELECT 45 
UNION ALL SELECT 50 
UNION ALL SELECT 51 
UNION ALL SELECT 55 
UNION ALL SELECT 61 

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