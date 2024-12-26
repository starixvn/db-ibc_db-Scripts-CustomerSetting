/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20240923
	Task: Test - InHouse
	DB:	DBCUST-CustDB
*/
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--WhiteLabelInfo
INSERT INTO [dbo].[WhiteLabelInfo](
	[CustID],
	[WhiteLabel],
	[LaunchedDate],
	[RepUpdateTime])
SELECT 123, 'whitelabel_ttest', CONVERT(date,GETDATE()), dbo.f_GetDateTime2()


--WhiteLabelSetting
INSERT INTO [dbo].[WhiteLabelSetting](
	[GroupID],
	[CustID],
	[HeadlineRate],
	[SuperRate],
	[MasterRate],
	[AgentRate],
	[Remark],
	[RepUpdateTime])
SELECT 0, 123, 1, 1, 1, 88, 'Test', dbo.f_GetDateTime2()

------------------------------------------------------------------------
--Delete data test:
DELETE FROM WhiteLabelInfo WITH (ROWLOCK)
OUTPUT deleted.CustID, dbo.f_GetDateTime2() 
	INTO WhiteLabelInfo_Del_InHouse(CustID, RepUpdateTime)
WHERE CustID=123

DELETE FROM WhiteLabelSetting WITH (ROWLOCK)
OUTPUT deleted.CustID, deleted.FromDate, dbo.f_GetDateTime2() 
	INTO WhiteLabelSetting_Del_InHouse(CustID, FromDate, RepUpdateTime)
WHERE CustID=123
GO