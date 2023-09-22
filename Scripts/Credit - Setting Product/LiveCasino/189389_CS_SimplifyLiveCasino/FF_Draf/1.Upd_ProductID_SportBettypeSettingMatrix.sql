
CREATE TABLE #tmpSettingMatrix (SportType			SMALLINT,
		BetType										INT,
		isLicensee									BIT,
		isLive										BIT,
		Site										VARCHAR(50),
		RealProductId								TINYINT	,
		ProductID									INT
		PRIMARY KEY CLUSTERED ( BetType ASC,
								SportType ASC,
								isLicensee ASC,
								isLive ASC, 
								Site ASC)) 

INSERT INTO #tmpSettingMatrix (SportType , BetType , isLicensee , isLive , Site , RealProductId , ProductID)
SELECT SportType, BetType, isLicensee, isLive, Site, RealProductId , ISNULL (ProductID , 0)
FROM SportBettypeSettingMatrix WITH (NOLOCK)
WHERE RealProductId IS NOT NULL
GROUP BY SportType, BetType, isLicensee, isLive, Site, RealProductId , ProductID


UPDATE
	tmp SET tmp.ProductID = sd.ProductID
FROM #tmpSettingMatrix tmp
LEFT JOIN ProductSettingDetail sd WITH (NOLOCK) ON tmp.RealProductId = sd.RealProductId
WHERE tmp.RealProductId = sd.RealProductId 
AND sd.ProductID <> tmp.ProductID


SELECT 
	tmp.RealProductId AS RealProductID_Matrix 
,	sd.RealProductId AS RealProductID_SettingDetail
,	sd.ProductID  AS ProductID_SettingDetail
,	tmp.ProductID AS ProductID_Matrix
,	CASE 
		WHEN tmp.RealProductId = sd.RealProductId AND sd.ProductID = tmp.ProductID THEN 'Skip'
		WHEN tmp.RealProductId = sd.RealProductId AND sd.ProductID <> tmp.ProductID THEN 'UPD ProductID_Matrix From ProductID_SettingDetail'
	END AS 'CASE'
INTO #A
FROM #tmpSettingMatrix tmp
LEFT JOIN ProductSettingDetail sd WITH (NOLOCK) ON tmp.RealProductId = sd.RealProductId
GROUP BY tmp.RealProductId , tmp.ProductID , sd.RealProductId , sd.ProductID



SELECT *
FROM #A t
Order by t.[CASE]


DROP TABLE #tmpSettingMatrix
DROP TABLE #A
