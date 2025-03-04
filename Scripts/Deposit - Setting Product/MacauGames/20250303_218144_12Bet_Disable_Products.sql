/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20250303
	Task: [12Bet] - Disable products
		https://nexdev.net/issues/218144
	DB: DBCust/CustDB

	*** count = 4067 rows
*/ 
USE CustDB
GO

CREATE TABLE #tmpCustomers (CustID INT PRIMARY KEY)
CREATE TABLE #tmpCustomers_batch (CustID INT PRIMARY KEY)

DECLARE @xmlStrHidden XML
	
SET @xmlStrHidden = (
		SELECT bitmapOrder AS '@b', 
						 1 AS '@s'
		FROM Dep_ProductStatusProfile WITH (NOLOCK)
		WHERE Sporttype IN 
		(	  156       -- SEAL Entertainment
			, 158       -- Jili
			, 159       -- YeeBet
			, 165       -- Arcadia Gaming
			, 167       -- CG
			, 208       -- Saba Casino
			, 211       -- Allbet
			, 212       -- Macau Games
			, 221       -- Exchange
			, 232       -- PG Soft
			, 234       -- Joker
			, 238       -- Habanero
			, 239       -- BG
			, 243       -- AE Sexy
			, 244       -- SA Gaming
			, 245       -- Virtual Games
			, 250       -- AG Casino
		)	
		FOR XML PATH ('r'), ROOT ('root')
	)

-- get customers
INSERT INTO #tmpCustomers (CustID)
SELECT cs.CustID
FROM [dbo].Dep_CustProductStatus cs WITH(NOLOCK)
INNER JOIN Customer c WITH (NOLOCK) ON c.CustID = cs.CustID 
WHERE c.srecommend IN (7526048)			--	12BETSuperHK
	OR c.mrecommend IN (927780, 857227)	--	12BETAFF

WHILE EXISTS (SELECT 1 FROM #tmpCustomers)
BEGIN
	TRUNCATE TABLE #tmpCustomers_batch

	DELETE TOP (2000) C
		OUTPUT deleted.CustID 
		INTO #tmpCustomers_batch (CustID)
	FROM #tmpCustomers C

	UPDATE cs
	SET	bitmapIsHidden = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsHidden, CONVERT(VARCHAR(MAX),@xmlStrHidden))),
		bitmapIsDisabled = (SELECT bitmap FROM dbo.f_GenerateProductStatus_multiple (cs.bitmapIsDisabled, CONVERT(VARCHAR(MAX),@xmlStrHidden))),
		RepUpdateTime=dbo.f_GetDateTime2()
	FROM [dbo].Dep_CustProductStatus cs WITH(ROWLOCK,UPDLOCK)
	INNER JOIN #tmpCustomers_batch c WITH (NOLOCK) ON c.CustID = cs.CustID 

	WAITFOR DELAY '00:00:0.280'
END
GO

DROP TABLE #tmpCustomers, #tmpCustomers_batch
GO