/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231016@Tacy
	Task: Sample data for In-House testing
	DB: DBCUST-CustDB
	
	Revisions:
		- 20231016@Tacy: Integration - Parlay Boost Bonus [RedmineID: #186192]
*/
USE CustDB
GO

INSERT INTO Dep_CustBonusSharing ([CustID], [BonusSharingRate], [FromDate], [isDeleted])
SELECT TOP 1 custid, 0.5, CAST (GETDATE() AS DATE), 1
FROM Customer C WITH (NOLOCK)
WHERE site='ATHENA000' AND currency=20
AND roleid=4
GO