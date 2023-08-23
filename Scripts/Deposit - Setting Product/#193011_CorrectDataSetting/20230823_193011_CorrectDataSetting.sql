/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Luke
	Date: 20230823
	Task:  Correct data setting for 5 custid: 70678974, 70889590, 71069603, 71071747, 71575481 [RedmineID: #193011]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE d 
SET d.IsGroupedPT = 1, d.IsGroupedBetLimit = 1
FROM Dep_CustSettingMode d WITH (ROWLOCK)
WHERE CustID IN (70678974
				,70889590
				,71069603
				,71071747
				,71575481)
