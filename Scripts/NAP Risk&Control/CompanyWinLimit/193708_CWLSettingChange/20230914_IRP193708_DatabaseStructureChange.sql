/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230914@Johnson
	Task: Database structure change
	DB: DBCUST/CustDB
*/
ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] DROP CONSTRAINT [PK_Winlimit_ProductGlobalSetting]
GO

ALTER TABLE Winlimit_ProductGlobalSetting ADD IsDeposit BIT
GO

UPDATE Winlimit_ProductGlobalSetting
SET IsDeposit = 1
GO

ALTER TABLE Winlimit_ProductGlobalSetting ALTER COLUMN IsDeposit BIT NOT NULL
GO


/****** Object:  Index [PK_Winlimit_ProductGlobalSetting]    Script Date: 9/18/2023 8:29:01 AM ******/
ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD  CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[BetTypeID] ASC,
	[GroupID] ASC,
	[Currency] ASC,
	IsDeposit ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [WinlimitSetting_Tables]
GO


INSERT INTO [dbo].[Winlimit_ProductGlobalSetting]
           ([ProductID]
           ,[BetTypeID]
           ,[GroupID]
           ,[GroupName]
           ,[Level1]
           ,[Level2]
           ,[Level3]
           ,[Level101]
           ,[Level102]
           ,[blockedTransferLvl3]
           ,[Currency]
		   ,IsDeposit)
SELECT [ProductID]
           ,[BetTypeID]
           ,[GroupID]
           ,[GroupName]
           ,[Level1]
           ,[Level2]
           ,[Level3]
           ,[Level101]
           ,[Level102]
           ,[blockedTransferLvl3]
           ,[Currency]
		   ,0 as IsDeposit
FROM Winlimit_ProductGlobalSetting
WHERE isDeposit = 1		   
GO


CREATE TABLE #tmpSetting (ProductID INT, 
						GroupID SMALLINT, 
						Level101 MONEY,
						Level102 MONEY,
						Level1	MONEY,
						Level2	MONEY,
						Level3	MONEY						
						)

INSERT INTO #tmpSetting(ProductID,GroupID,Level101,Level102,Level1,Level2,Level3)						
SELECT	6	,	3	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Saba Casino 
UNION ALL SELECT	32	,	16	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	PP – Pragmatic
UNION ALL SELECT	36	,	22	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	SG- Spadegaming 
UNION ALL SELECT	55	,	34	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	PG Soft
UNION ALL SELECT	66	,	47	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Vgaming
UNION ALL SELECT	73	,	56	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	MG-RNG
UNION ALL SELECT	3	,	1	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Number Game 
UNION ALL SELECT	5	,	2	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 
UNION ALL SELECT	8	,	4	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Keno RNG 
UNION ALL SELECT	22	,	10	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Macau Games 
UNION ALL SELECT	27	,	12	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 2 
UNION ALL SELECT	28	,	13	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Lottery 
UNION ALL SELECT	34	,	21	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Arcadia Gaming (Card Club)
UNION ALL SELECT	38	,	24	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Virtual Games 
UNION ALL SELECT	40	,	29	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Table Game 
UNION ALL SELECT	49	,	37	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 3 (Old)
UNION ALL SELECT	77	,	62	,	NULL	,	-200000	,	NULL	,	200000	,	300000	--	Virtual Sports 3
UNION ALL SELECT	50	,	32	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Funky Games
UNION ALL SELECT	56	,	36	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Joker
UNION ALL SELECT	60	,	40	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	MaxGame
UNION ALL SELECT	61	,	42	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Habanero
UNION ALL SELECT	62	,	46	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	CG (Creative Gaming)
UNION ALL SELECT	63	,	43	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Sports Lottery
UNION ALL SELECT	67	,	49	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	AdvantPlay
UNION ALL SELECT	68	,	50	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	AdvantPlay Mini
UNION ALL SELECT	69	,	51	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Bitcoin
UNION ALL SELECT	72	,	55	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	SEAL Entertainment
UNION ALL SELECT	75	,	58	,	-50000	,	-100000	,	50000	,	100000	,	200000	--	Jili

--Update Global setting
UPDATE p
SET p.Level101  = ISNULL(t.Level101,p.Level101),
	p.Level102 = ISNULL(t.Level102,p.Level102),
	p.Level1 = ISNULL(t.Level1,p.Level1),
	p.Level2 = ISNULL(t.Level2,p.Level2),
	p.Level3 = ISNULL(t.Level3,p.Level3)
FROM Winlimit_ProductGlobalSetting p WITH(ROWLOCK)
	INNER JOIN #tmpSetting t on p.ProductID = t.ProductID and p.GroupID = t.GroupID
WHERE p.IsDeposit = 0
	AND p.currency NOT IN (51,13)
GO
