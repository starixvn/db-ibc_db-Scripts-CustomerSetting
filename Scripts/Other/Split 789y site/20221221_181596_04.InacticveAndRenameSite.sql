/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 04. Inactive and rename Site
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

--Inactive: 789y
UPDATE s
SET s.isActive=0, s.site='789y (Old)'
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE site='789y'

--Diminter, GWinner
UPDATE s
SET s.isActive=0, s.isDeposit=1
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE site IN ('Diminter', 'GWinner')