/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 02. Initial data for column SiteLabel
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

--Inactive: Y987
UPDATE s
SET s.isActive=0
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE site='Y987'

-- Update SiteLabel
UPDATE s
SET s.SiteLabel = CASE  WHEN site='789y'					THEN '789y'
						WHEN site IN ('IBCIndo','76666B')	THEN 'IBC'
															ELSE 'Nova88'
					END
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE isLicensee=0 AND site<>'CN88' AND isActive=1