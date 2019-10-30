/*
	Created: 20191030@Winnie
	Task: Insert Stake Level for SG
	DB: DBCUST/CustDB
*/

USE CustDB
GO

CREATE TABLE #temp(
	[exchangeid] [int] NULL,
	[Min] [decimal](19, 8) NULL,
	[Max] [decimal](19, 8) NULL
) ON [PRIMARY]

GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (3, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (4, CAST(2.50000000 AS Decimal(19, 8)), CAST(1250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (5, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (6, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (2, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (32, CAST(10.00000000 AS Decimal(19, 8)), CAST(5000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (1, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (9, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (12, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (13, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (15, CAST(0.50000000 AS Decimal(19, 8)), CAST(250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (16, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (21, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (22, CAST(0.50000000 AS Decimal(19, 8)), CAST(250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (33, CAST(0.50000000 AS Decimal(19, 8)), CAST(250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (34, CAST(0.50000000 AS Decimal(19, 8)), CAST(250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (35, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (43, CAST(2.50000000 AS Decimal(19, 8)), CAST(1250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (45, CAST(50.00000000 AS Decimal(19, 8)), CAST(25000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (47, CAST(0.50000000 AS Decimal(19, 8)), CAST(250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (51, CAST(2.50000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (61, CAST(4.00000000 AS Decimal(19, 8)), CAST(2000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (64, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (67, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (69, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (70, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (30, CAST(2.50000000 AS Decimal(19, 8)), CAST(1250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (41, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (46, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (49, CAST(5.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (52, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (53, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (54, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (55, CAST(4.00000000 AS Decimal(19, 8)), CAST(2000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (56, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (57, CAST(5.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (58, CAST(1.00000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (63, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (65, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (66, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (68, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (71, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (72, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (73, CAST(1.00000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (74, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (75, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (76, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (77, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (78, CAST(0.10000000 AS Decimal(19, 8)), CAST(50.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (79, CAST(10.00000000 AS Decimal(19, 8)), CAST(5000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (80, CAST(1.00000000 AS Decimal(19, 8)), CAST(200.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (81, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (82, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (83, CAST(50.00000000 AS Decimal(19, 8)), CAST(10000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (84, CAST(200.00000000 AS Decimal(19, 8)), CAST(100000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (85, CAST(0.25000000 AS Decimal(19, 8)), CAST(125.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (86, CAST(2.50000000 AS Decimal(19, 8)), CAST(1250.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (88, CAST(500.00000000 AS Decimal(19, 8)), CAST(100000.00000000 AS Decimal(19, 8)))
GO
INSERT #temp ([exchangeid], [Min], [Max]) VALUES (89, CAST(2.00000000 AS Decimal(19, 8)), CAST(1000.00000000 AS Decimal(19, 8)))
GO

CREATE TABLE #tmpbettype (BettypeID INT PRIMARY KEY)
INSERT INTO #tmpbettype(BettypeID)
SELECT 4301 UNION ALL
SELECT 4302 UNION ALL
SELECT 4303 UNION ALL
SELECT 4304 UNION ALL
SELECT 4305

INSERT INTO StakeLevel(GameTypeID	,GameGroupID,	MinLabel,	MaxLabel,	MinStake,	MaxStake,	ExchangeID,	ResourceID)
SELECT 4301,	12,	NULL,	NULL,	NULL,	NULL,	e.exchangeid	,NULL
FROM exchange  e WITH(NOLOCK)
	INNER JOIN #temp t ON e.exchangeid=t.exchangeid

INSERT INTO StakeLevelGroupDetail(StakeLevelID,	GameTypeID,	MinLabel,	MaxLabel,	MinStake,	MaxStake)
SELECT StakeLevelID,	tb.BettypeID,	CAST(CAST(t.Min AS Float) AS NVARCHAR(50)),CAST(CAST(t.Max AS Float) AS NVARCHAR(50)),	t.Min , t.Max
FROM StakeLevel e WITH(NOLOCK) 
INNER JOIN #temp t ON e.exchangeid=t.exchangeid
	CROSS APPLY #tmpbettype tb
WHERE GameTypeID=4301 AND GameGroupID=12