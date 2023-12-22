/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20231221@Johnson
	Task: Remove currency PE for Goldenfph, BODemoJS [redmine: #198398]
	DB: DBCUST/CUSTDB
*/
DECLARE @Currency INT

SELECT @Currency = ExchangeID 
FROM dbo.Exchange WITH(NOLOCK)
WHERE currency = 'PE'
	
DELETE WinLimit_ProductSettingDetail 
WHERE ExchangeID = @currency
	AND SiteID IN (SELECT SiteID 
					FROM site WITH(NOLOCK)
					WHERE site IN ('Goldenfph','BODemoJS')
				)

DELETE bodb_licensee.dbo.CurrencyUser 
WHERE LicenseeID IN (SElECT LicenseeID
					FROM bodb_licensee.dbo.Licensees WITH (NOLOCK)
					WHERE LicenseeName IN ('Goldenfph','BODemoJS')
		)
	AND CurrencyID = @currency
	
DELETE 	bodb_licensee.dbo.LicenseeCust
WHERE LicenseeID IN (SElECT LicenseeID
					FROM bodb_licensee.dbo.Licensees WITH (NOLOCK)
					WHERE LicenseeName IN ('Goldenfph','BODemoJS')
		)
	AND Currency = @currency
