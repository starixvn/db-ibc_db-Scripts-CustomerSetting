/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231116@Johnson
	Task: Seal Entertainment - Incorporate to Licensee Sites [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

DELETE Dep_ProductStatusProfile WITH(ROWLOCK) WHERE SportType = 156
DELETE Dep_ProductSetting WITH(ROWLOCK) WHERE ProductSettingID IN (159,160)
DELETE Dep_ProductSettingDetail WITH(ROWLOCK) WHERE ProductSettingID IN (159,160)


INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 156,8900,36

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT 159, 72, 4, 0, 1, 1
UNION SELECT 160, 72, 1, 0, 2, 1
GO


INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT 159, 156, 8900, 0, 0, 1, NULL, 0
UNION SELECT 160, 156, 8900, 0, 0, 1, NULL, 0
GO

;WITH T AS (
SELECT 	156	Sporttype,	1	GameGroupID,	0.01	MinBet,	5000	MaxBet,	1	LicenseeGroupID,	NULL	Remark,	SYSDATETIME()	RepUpdateTime,	0	isDeleted--	RM
UNION ALL SELECT 	156	,	1	,	0.01	,	1000	,	2	,	NULL	,	SYSDATETIME()	,	0	--	US$, USDT
UNION ALL SELECT 	156	,	1	,	0.01	,	35000	,	3	,	NULL	,	SYSDATETIME()	,	0	--	TB
UNION ALL SELECT 	156	,	1	,	0.01	,	1000	,	4	,	NULL	,	SYSDATETIME()	,	0	--	EURO
UNION ALL SELECT 	156	,	1	,	0.01	,	8000	,	5	,	NULL	,	SYSDATETIME()	,	0	--	RMB
UNION ALL SELECT 	156	,	1	,	0.01	,	15000	,	7	,	NULL	,	SYSDATETIME()	,	0	--	IN
UNION ALL SELECT 	156	,	1	,	0.01	,	1000	,	6	,	NULL	,	SYSDATETIME()	,	0	--	UUS
UNION ALL SELECT 	156	,	1	,	0.01	,	150000	,	8	,	NULL	,	SYSDATETIME()	,	0	--	JPY
UNION ALL SELECT 	156	,	1	,	0.01	,	120000	,	9	,	NULL	,	SYSDATETIME()	,	0	--	PE
UNION ALL SELECT 	156	,	1	,	0.01	,	1000000	,	10	,	NULL	,	SYSDATETIME()	,	0	--	Won
UNION ALL SELECT 	156	,	1	,	0.01	,	1500	,	11	,	NULL	,	SYSDATETIME()	,	0	--	BND
UNION ALL SELECT 	156	,	1	,	0.01	,	15000	,	12	,	NULL	,	SYSDATETIME()	,	0	--	MXN
UNION ALL SELECT 	156	,	1	,	0.01	,	25000	,	13	,	NULL	,	SYSDATETIME()	,	0	--	INH
UNION ALL SELECT 	156	,	1	,	0.01	,	100000	,	14	,	NULL	,	SYSDATETIME()	,	0	--	RUB
UNION ALL SELECT 	156	,	1	,	0.01	,	85000	,	15	,	NULL	,	SYSDATETIME()	,	0	--	INR
UNION ALL SELECT 	156	,	1	,	0.01	,	2000	,	16	,	NULL	,	SYSDATETIME()	,	0	--	MKK
UNION ALL SELECT 	156	,	1	,	0.01	,	4000	,	17	,	NULL	,	SYSDATETIME()	,	0	--	KHR
UNION ALL SELECT 	156	,	1	,	0.01	,	5000	,	18	,	NULL	,	SYSDATETIME()	,	0	--	BRL
UNION ALL SELECT 	156	,	1	,	0.01	,	350000	,	23	,	NULL	,	SYSDATETIME()	,	0	--	ARS
UNION ALL SELECT 	156	,	1	,	0.01	,	100000	,	20	,	NULL	,	SYSDATETIME()	,	0	--	BDT		   
)
INSERT INTO [dbo].[Dep_ProductStakeLevelGroup]
           ([Sporttype]
           ,[GameGroupID]
           ,[MinBet]
           ,[MaxBet]
           ,[LicenseeGroupID]
           ,[Remark]
           ,[RepUpdateTime]
           ,[isDeleted]
		   ,[SiteID])
SELECT [Sporttype]
	   ,[GameGroupID]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[LicenseeGroupID]
	   ,[Remark]
	   ,t.RepUpdateTime
	   ,[isDeleted]
	   ,0 SiteID
FROM T
