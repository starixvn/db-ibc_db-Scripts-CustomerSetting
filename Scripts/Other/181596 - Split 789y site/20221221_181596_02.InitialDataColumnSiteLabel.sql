/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 02. Initial data for column SiteLabel 
			  Update SiteDBGroupID
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

DECLARE @SiteDBGroupID TINYINT

SET @SiteDBGroupID = xxx

-- Initial: SiteLabel & Update: SiteDBGroupID
--UAT
IF @@SERVERNAME = 'DBSPARE'
	UPDATE s
	SET s.SiteLabel = CASE  WHEN siteid=3	THEN '789b'
							WHEN siteid=487	THEN 'IBCIndo'
							ELSE 'MBC'
					  END,
		s.SiteDBGroupID = CASE WHEN siteid<>3 THEN @SiteDBGroupID ELSE SiteDBGroupID END
	FROM Site s WITH(UPDLOCK, ROWLOCK)
	WHERE isLicensee=0

--PRO
IF @@SERVERNAME = 'DBCUST'
	UPDATE s
	SET s.SiteLabel = CASE  WHEN siteid=3	THEN '789y'
							WHEN siteid=487	THEN 'IBCIndo'
							ELSE 'MBC'
					  END,
		s.SiteDBGroupID = CASE WHEN siteid<>3 THEN @SiteDBGroupID ELSE SiteDBGroupID END
	FROM Site s WITH(UPDLOCK, ROWLOCK)
	WHERE isLicensee=0