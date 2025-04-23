/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden
	Date: 20250423
	Task:  Insert Setting StakeLevel for DirectMember RedmineID:#225010
	DB: DBCust/CustDB
*/
USE CustDB
GO

INSERT INTO CustStakeLevel_Member(
 CustID
,SportType
,BetType
,StakeLevelList
,LastUpdated
,RepUpdateTime
)
SELECT 228976094
,233
,3401
,''
,GETDATE()
,dbo.f_GetDateTime2()