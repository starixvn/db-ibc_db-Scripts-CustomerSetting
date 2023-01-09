/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 02. Initial data for column SiteLabel 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO


DECLARE @SiteLabel VARCHAR(50)

/*
	on UAT: @SiteLabel='789b'
	on PRO: @SiteLabel='789y'
*/
SET @SiteLabel = xxx

UPDATE s
SET s.SiteLabel = CASE  WHEN siteid=3	THEN @SiteLabel
						WHEN siteid=487	THEN 'IBCIndo'
						ELSE 'MBC'
					END
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE isLicensee=0