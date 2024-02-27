/*<info serverAlias="DBCUST-bodb_Licensee"></info>*/
/*	
	Created: 20240122@Tacy
	Task: Clean VS2,VS3 data - [LicenseeProduct3rd]
		Redmine: https://nexdev.net/issues/199251
	DB: DBCUST-bodb_Licensee
*/
USE bodb_Licensee
GO 

CREATE TABLE #tmpLicenseeProduct3rd (
	[LicenseeID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	PRIMARY KEY CLUSTERED ( [LicenseeID] ASC,
							[ProductID] ASC
						)
)

WHILE (1=1)
BEGIN
	TRUNCATE TABLE #tmpLicenseeProduct3rd 

	INSERT INTO #tmpLicenseeProduct3rd (LicenseeID, ProductID)
	SELECT TOP (1000) LicenseeID, ProductID
	FROM LicenseeProduct3rd WITH (NOLOCK)
	WHERE ProductID IN (27,49,77)

	IF @@ROWCOUNT = 0
		BREAK;

	DELETE lp
	FROM LicenseeProduct3rd lp WITH (ROWLOCK)
	INNER JOIN #tmpLicenseeProduct3rd t ON t.LicenseeID=lp.LicenseeID
										AND t.ProductID=lp.ProductID
END
GO