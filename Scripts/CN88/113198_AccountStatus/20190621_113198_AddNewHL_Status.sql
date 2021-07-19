/*
	Created: 20190621@Elodie	
	Task: initial data CS_CustomerStatus
	DB: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO CS_CustomerStatus  (CustId, InactiveInfo, SuspendedInfo, ViewOnlyInfo)
SELECT CustId, 0, 0, 0
FROM Customer c WITH (NOLOCK)
WHERE c.username IN ('HLTest21', 'HLTest22', 'HLTest23', 'HLTest24', 'HLTest25')
