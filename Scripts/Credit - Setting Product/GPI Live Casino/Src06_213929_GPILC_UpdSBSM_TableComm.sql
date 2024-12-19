/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241120@Virgil
	Task: GPI Live Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #213485]
	DB: DBCUST-CustDB
	Note: Update TableComm column for Bettype 11534-11567 not support commission
*/
USE CustDB
GO

--// SportBettypeSettingMatrix //--
UPDATE sbsm
SET TableComm = 'NoCommission',
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [CustDB].[dbo].[SportBettypeSettingMatrix] sbsm WITH(ROWLOCK, UPDLOCK)
WHERE SportType = 144 
	AND BetType BETWEEN 11534 AND 11567



