/*
	Created: Johnson
	Date: 20190429
	Task: correct cwl setting for RnG
	DB: DBCust/CustDB
*/

--812 rows affected
UPDATE p
SET IsBlockedTransfer = 0
FROM WinLimit_ProductSettingDetail p WITH(UPDLOCK,ROWLOCK)
	INNER JOIN site S (NOLOCK) ON p.SiteID = s.siteid
WHERE isActive = 1 
	AND isLicensee = 1
	AND productid = 6 
	AND levelID IN (1,2,101,102)
	AND IsBlockedTransfer = 1
