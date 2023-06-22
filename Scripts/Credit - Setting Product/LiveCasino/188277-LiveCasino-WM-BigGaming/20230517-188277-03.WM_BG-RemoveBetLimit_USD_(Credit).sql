/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230517@Tacy
	Task: WM, BG Live Casino - Support to change bet limit range for USD code
		Step 03. Remove bet limit
		https://nexdev.net/issues/188277
	DB: DBCust/CustDB and all replicated server
*/

--run this step after done verify step 2
DELETE s
FROM StakeLevel s WITH(ROWLOCK)
INNER JOIN exchange e WITH(NOLOCK) ON s.ExchangeId=e.ExchangeId
WHERE e.Code='USD' AND e.OfferSite<>2 AND e.IsActive=1
AND ((GameTypeID = 3401 AND MinStake = 50 AND MaxStake = 5000)
	OR (GameTypeID = 3501 AND MinStake = 3 AND MaxStake = 5000))
GO