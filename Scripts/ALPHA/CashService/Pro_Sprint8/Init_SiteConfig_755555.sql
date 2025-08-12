/*<info serverAlias="DBCUST-AgencyCashService" executers="" viewers=""></info>*/
/*
      Task:         Alpha - Agency Cash Service - Init data Site Config for 7a5555 [#235266]
      DB:           DBCUST-AgencyCashService
      Created:      20250815@Helios
*/

SET NOCOUNT ON;
SET XACT_ABORT ON;

-- Declare parameters for source and target SiteID
DECLARE @FromSite INT, @ToSite INT;

-- Get SiteID values from CustDb.dbo.Site
SELECT @FromSite = SiteID FROM CustDb.dbo.Site WITH (NOLOCK) WHERE Site = '222227';
SELECT @ToSite = SiteID FROM CustDb.dbo.Site WITH (NOLOCK) WHERE Site = '755555';

-- Validate both SiteIDs exist
IF @FromSite IS NULL OR @ToSite IS NULL
BEGIN
    RAISERROR(N'Invalid SiteID: Source (25 - 222227) or Target (22 - 755555) does not exist', 16, 1);
    RETURN;
END;



IF EXISTS (SELECT TOP 1 1 FROM dbo.CashSiteConfig WITH (NOLOCK) WHERE SiteID = @FromSite)
   AND NOT EXISTS (SELECT TOP 1 1 FROM dbo.CashSiteConfig WITH (NOLOCK) WHERE SiteID = @ToSite)
BEGIN
	INSERT INTO CashSiteConfig 
	(
		SiteId
	    , CountryCode
	    , RepUpdateTime
	)
    SELECT 
        @ToSite AS SiteID,
        CountryCode,
        [dbo].[f_GetDateTime2]() AS RepUpdateTime
    FROM dbo.CashSiteConfig WITH (NOLOCK)
    WHERE SiteID = @FromSite;
END;



IF EXISTS (SELECT TOP 1 1 FROM dbo.CashProviderConfig WITH (NOLOCK) WHERE SiteID = @FromSite)
   AND NOT EXISTS (SELECT TOP 1 1 FROM dbo.CashProviderConfig WITH (NOLOCK) WHERE SiteID = @ToSite)
BEGIN
    INSERT INTO dbo.CashProviderConfig (
        SiteID,
        ProviderID,
        RepUpdateTime
    )
    SELECT 
        @ToSite AS SiteID,
        ProviderID,
        [dbo].[f_GetDateTime2]() AS RepUpdateTime
    FROM dbo.CashProviderConfig WITH (NOLOCK)
    WHERE SiteID = @FromSite;
END;



IF EXISTS (SELECT TOP 1 1 FROM dbo.CashBankConfig WITH (NOLOCK) WHERE SiteID = @FromSite)
   AND NOT EXISTS (SELECT TOP 1 1 FROM dbo.CashBankConfig WITH (NOLOCK) WHERE SiteID = @ToSite)
BEGIN
    INSERT INTO dbo.CashBankConfig (
        SiteID,
        BankID,
        RepUpdateTime
    )
    SELECT 
        @ToSite AS SiteID,
        BankID,
        [dbo].[f_GetDateTime2]() AS RepUpdateTime
    FROM dbo.CashBankConfig WITH (NOLOCK)
    WHERE SiteID = @FromSite;
END;

-- Output result
SELECT 'Success' AS Result;
