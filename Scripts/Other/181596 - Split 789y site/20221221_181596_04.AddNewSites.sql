/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 04. Insert 4 new sites (YUT, Y789, Y889, YOther) 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SiteDBGroupID TINYINT

SET @SiteDBGroupID = xxx

-- Add 4 new sites:
INSERT INTO Site ([site], [ServerID], [isLicensee], [isActive], [isDeposit], [SpecialGroup], [BlockNewCust], [SiteDBGroupID], [SiteLabel])
SELECT 'yUT', [ServerID], [isLicensee], 1, [isDeposit], [SpecialGroup], [BlockNewCust], @SiteDBGroupID, '789y'
FROM Site WITH (NOLOCK)
WHERE siteid=3
UNION ALL 
SELECT 'y789', [ServerID], [isLicensee], 1, [isDeposit], [SpecialGroup], [BlockNewCust], @SiteDBGroupID, '789y'
FROM Site WITH (NOLOCK)
WHERE siteid=3
UNION ALL 
SELECT 'y889', [ServerID], [isLicensee], 1, [isDeposit], [SpecialGroup], [BlockNewCust], @SiteDBGroupID, '789y'
FROM Site WITH (NOLOCK)
WHERE siteid=3
UNION ALL 
SELECT 'yOther', [ServerID], [isLicensee], 1, [isDeposit], [SpecialGroup], [BlockNewCust], @SiteDBGroupID, '789y'
FROM Site WITH (NOLOCK)
WHERE siteid=3