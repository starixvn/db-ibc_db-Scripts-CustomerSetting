/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20250422
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
SELECT 228744731
,144
,11500
,''
,GETDATE()
, dbo.f_GetDateTime2()