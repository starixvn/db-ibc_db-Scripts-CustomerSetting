/*<info serverAlias="DBCUST-CustDB"></info>*/ 
/*
	Created: Eden@20250227
	Task: Correct data SiteBuider Site = SoftGaming, 39 Currencies [RM:218685]
	DB: DBCUST/CustDB
*/
USE CUSTDB
GO
DECLARE @SiteName		VARCHAR(10)  = 'SoftGaming'
	,@ProductList	VARCHAR(MAX)
	,@LicenseeType	VARCHAR(50) = 'Boping'
------------------------------------------
DECLARE @ProductTbl TABLE ( ProductID INT)
INSERT INTO @ProductTbl(ProductID)
		  SELECT 1
UNION ALL SELECT 3
UNION ALL SELECT 5
UNION ALL SELECT 8
UNION ALL SELECT 28
UNION ALL SELECT 40
UNION ALL SELECT 66

SET @ProductList = (
	SELECT DISTINCT ProductID 
	FROM @ProductTbl
	FOR Json PATH
)

-------------------
DECLARE @ErrCode	INT = 0 
	, @ErrMsg		NVARCHAR(MAX) = '' 
	, @LicenseeId	INT = 0 


-------------------Init currency setting on bodb_licensee
EXEC bodb_Licensee.dbo.API_SiteBuilder_LicenseeDB_Ins
	 @SiteName		= @SiteName	
	,@LicenseeType  = @LicenseeType
	,@ProductList	= @ProductList
	,@ErrCode		= @ErrCode OUTPUT
	,@ErrMsg		= @ErrMsg OUTPUT
	,@LicenseeId	= @LicenseeId OUTPUT

SELECT @ErrCode		AS ErrCode		
	,@ErrMsg		AS ErrMsg		
	,@LicenseeId	AS LicenseeId	
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