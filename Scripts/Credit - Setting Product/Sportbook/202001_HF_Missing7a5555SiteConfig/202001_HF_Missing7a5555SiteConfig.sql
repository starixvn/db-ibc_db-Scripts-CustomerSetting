/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240307@Helios
	Task: HF Missing 7a5555S Site Config  [#202001] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	IF NOT EXISTS (SELECT 1 FROM ProductProfileSiteCurrency WITH (NOLOCK) WHERE SiteID = 1233 AND Currency = 0 AND ProductSettingID  IN (250,251,252) )
	BEGIN
		INSERT INTO ProductProfileSiteCurrency 
			(
				SiteID
			    , Currency
			    , ProductSettingID
			)
			SELECT 1233 AS SiteID , 0 AS Currency , 250 AS ProductSettingID
		UNION SELECT 1233 AS SiteID , 0 AS Currency , 251 AS ProductSettingID
		UNION SELECT 1233 AS SiteID , 0 AS Currency , 252 AS ProductSettingID
	END

	IF NOT EXISTS (SELECT 1 FROM ProductProfileSiteCurrency_UAT WITH (NOLOCK) WHERE SiteID = 1233 AND Currency = 0 AND ProductSettingID  IN (345,348,349) )
	BEGIN
		INSERT INTO ProductProfileSiteCurrency_UAT 
			(
				SiteID
			    , Currency
			    , ProductSettingID
			)
			SELECT 1233 AS SiteID , 0 AS Currency , 345 AS ProductSettingID
		UNION SELECT 1233 AS SiteID , 0 AS Currency , 348 AS ProductSettingID
		UNION SELECT 1233 AS SiteID , 0 AS Currency , 349 AS ProductSettingID
	END