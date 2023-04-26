/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230410@Johnson
	Task: Initial ProductSettingDetail
	DB: DBCUST/CustDB
*/


INSERT INTO [dbo].[ProductSettingType]
           ([SettingType]
           ,[SettingName]
           ,[SettingNameDetail])
SELECT 25,'Commission','SB Comm'
UNION ALL SELECT 26,'Bet Setting','SB Bet Setting'
UNION ALL SELECT 27,'Parlay Max Payout','SB Parlay Max Payout'
UNION ALL SELECT 150,'Commisssion','Sportbook Comm'
UNION ALL SELECT 151,'Bet Setting','Sportbook Bet Setting'
UNION ALL SELECT 152,'Parlay Max Payout','Sportbook Parlay MaxPayout'
UNION ALL SELECT 153,'PT','Sportbook/RNG Games/LCS PT'
UNION ALL SELECT 154,'Bet Setting','RNG Games Bet Setting'
UNION ALL SELECT 156,'Commission','LCS Comm'
GO

WITH T AS (
SELECT 	25	SettingType,	1	SportType,	1	BetType,	1	GroupID,	150	GroupType,	1	GroupTypeOrder,	NULL	SubGroupID,	NULL	SubGroupOrder,	0	CreationStatus,	5	DisplayType,	249	ProductSettingID,	0	IsLive,	1	ProductID,	NULL	MaxPT,	0.0025	MaxDiscount,	NULL	IsSync,	NULL	IsHidden,	NULL	IsDisabled,	4	SettingLevel,	1	DisplayOrder,	0	SettingStatus,	0.0005	IntervalValue,	1	RealProductId,	NULL	MaxChoice,	NULL	Parent_ProductSettingID,	1	Child_DisplayOrder,	NULL SubType
UNION ALL SELECT 	25	,	1	,	3	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	250	,	0	,	1	,	NULL	,	0.005	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	2	,	NULL
UNION ALL SELECT 	25	,	1	,	7	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	251	,	0	,	1	,	NULL	,	0.0075	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	3	,	NULL
UNION ALL SELECT 	25	,	1	,	8	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	252	,	0	,	1	,	NULL	,	0.01	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	4	,	NULL
UNION ALL SELECT 	25	,	1	,	4	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	253	,	0	,	1	,	NULL	,	0.01	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	5	,	NULL
UNION ALL SELECT 	25	,	1	,	5	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	254	,	0	,	1	,	NULL	,	0.0025	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	6	,	NULL
UNION ALL SELECT 	25	,	2	,	1	,	1	,	150	,	1	,	NULL	,	NULL	,	0	,	5	,	255	,	0	,	1	,	NULL	,	0.01	,	NULL	,	NULL	,	NULL	,	4	,	1	,	0	,	0.0005	,	1	,	NULL	,	NULL	,	7	,	NULL
UNION ALL SELECT 	26	,	1	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	256	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	1	,	NULL
UNION ALL SELECT 	26	,	9901	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	257	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	2	,	NULL
UNION ALL SELECT 	26	,	1	,	9	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	258	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	3	,	NULL
UNION ALL SELECT 	26	,	2	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	259	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	4	,	NULL
UNION ALL SELECT 	26	,	9902	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	260	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	5	,	NULL
UNION ALL SELECT 	26	,	3	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	261	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	6	,	NULL
UNION ALL SELECT 	26	,	5	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	262	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	7	,	NULL
UNION ALL SELECT 	26	,	8	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	263	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	8	,	NULL
UNION ALL SELECT 	26	,	10	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	264	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	9	,	NULL
UNION ALL SELECT 	26	,	11	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	265	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	10	,	NULL
UNION ALL SELECT 	26	,	99	,	1	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	266	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	11	,	NULL
UNION ALL SELECT 	26	,	99	,	9	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	267	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	12	,	NULL
UNION ALL SELECT 	27	,	1	,	9	,	1	,	152	,	3	,	NULL	,	NULL	,	0	,	1	,	268	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	15	,	NULL
UNION ALL SELECT 	27	,	99	,	9	,	1	,	152	,	3	,	NULL	,	NULL	,	0	,	1	,	269	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	16	,	NULL
UNION ALL SELECT 	28	,	1	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	270	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	1	,	NULL
UNION ALL SELECT 	28	,	1	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	271	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	2	,	NULL
UNION ALL SELECT 	28	,	1	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	272	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	3	,	NULL
UNION ALL SELECT 	28	,	1	,	4	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	273	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	4	,	NULL
UNION ALL SELECT 	28	,	1	,	5	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	274	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	5	,	NULL
UNION ALL SELECT 	28	,	1	,	6	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	275	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	6	,	NULL
UNION ALL SELECT 	28	,	1	,	7	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	276	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	7	,	NULL
UNION ALL SELECT 	28	,	1	,	8	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	277	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	8	,	NULL
UNION ALL SELECT 	28	,	1	,	9	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	278	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	9	,	NULL
UNION ALL SELECT 	28	,	1	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	279	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	10	,	NULL
UNION ALL SELECT 	28	,	1	,	9999	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	280	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	11	,	NULL
UNION ALL SELECT 	28	,	1	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	281	,	1	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	12	,	NULL
UNION ALL SELECT 	28	,	1	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	282	,	1	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	13	,	NULL
UNION ALL SELECT 	28	,	1	,	7	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	283	,	1	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	14	,	NULL
UNION ALL SELECT 	28	,	1	,	8	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	284	,	1	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	15	,	NULL
UNION ALL SELECT 	28	,	2	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	285	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	16	,	NULL
UNION ALL SELECT 	28	,	2	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	286	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	17	,	NULL
UNION ALL SELECT 	28	,	2	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	287	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	18	,	NULL
UNION ALL SELECT 	28	,	2	,	7	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	288	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	19	,	NULL
UNION ALL SELECT 	28	,	2	,	8	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	289	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	20	,	NULL
UNION ALL SELECT 	28	,	2	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	290	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	21	,	NULL
UNION ALL SELECT 	28	,	2	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	291	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	22	,	NULL
UNION ALL SELECT 	28	,	2	,	9999	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	292	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	23	,	NULL
UNION ALL SELECT 	28	,	3	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	293	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	24	,	NULL
UNION ALL SELECT 	28	,	3	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	294	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	25	,	NULL
UNION ALL SELECT 	28	,	3	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	295	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	26	,	NULL
UNION ALL SELECT 	28	,	3	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	296	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	27	,	NULL
UNION ALL SELECT 	28	,	3	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	297	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	28	,	NULL
UNION ALL SELECT 	28	,	5	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	298	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	29	,	NULL
UNION ALL SELECT 	28	,	5	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	299	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	30	,	NULL
UNION ALL SELECT 	28	,	5	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	300	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	31	,	NULL
UNION ALL SELECT 	28	,	5	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	301	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	32	,	NULL
UNION ALL SELECT 	28	,	5	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	302	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	33	,	NULL
UNION ALL SELECT 	28	,	5	,	9999	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	303	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	34	,	NULL
UNION ALL SELECT 	28	,	8	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	304	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	35	,	NULL
UNION ALL SELECT 	28	,	8	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	305	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	36	,	NULL
UNION ALL SELECT 	28	,	8	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	306	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	37	,	NULL
UNION ALL SELECT 	28	,	8	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	307	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	38	,	NULL
UNION ALL SELECT 	28	,	10	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	308	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	39	,	NULL
UNION ALL SELECT 	28	,	10	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	309	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	40	,	NULL
UNION ALL SELECT 	28	,	10	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	310	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	41	,	NULL
UNION ALL SELECT 	28	,	10	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	311	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	42	,	NULL
UNION ALL SELECT 	28	,	10	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	312	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	43	,	NULL
UNION ALL SELECT 	28	,	11	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	313	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	44	,	NULL
UNION ALL SELECT 	28	,	11	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	314	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	45	,	NULL
UNION ALL SELECT 	28	,	11	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	315	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	46	,	NULL
UNION ALL SELECT 	28	,	99	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	316	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	47	,	NULL
UNION ALL SELECT 	28	,	99	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	317	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	48	,	NULL
UNION ALL SELECT 	28	,	99	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	318	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	49	,	NULL
UNION ALL SELECT 	28	,	99	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	319	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	50	,	NULL
UNION ALL SELECT 	28	,	99	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	320	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	51	,	NULL
UNION ALL SELECT 	28	,	99	,	9999	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	321	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	52	,	NULL
UNION ALL SELECT 	28	,	99	,	9	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	322	,	0	,	1	,	90	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	3	,	0	,	NULL	,	1	,	NULL	,	NULL	,	53	,	NULL
UNION ALL SELECT 	23	,	161	,	81	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	239	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL
UNION ALL SELECT 	23	,	164	,	8101	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	240	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	4	,	2	,	0	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL
)
INSERT INTO [dbo].[ProductSettingDetail]
           ([SettingType]
           ,[SportType]
           ,[BetType]
           ,[GroupID]
           ,[GroupType]
           ,[GroupTypeOrder]
           ,[SubGroupID]
           ,[SubGroupOrder]
           ,[CreationStatus]
           ,[DisplayType]
           ,[ProductSettingID]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType])
SELECT [SettingType]
           ,[SportType]
           ,[BetType]
           ,[GroupID]
           ,[GroupType]
           ,[GroupTypeOrder]
           ,[SubGroupID]
           ,[SubGroupOrder]
           ,[CreationStatus]
           ,[DisplayType]
           ,[ProductSettingID]
           ,[IsLive]
           ,[ProductID]
           ,[MaxPT]
           ,[MaxDiscount]
           ,[IsSync]
           ,[IsHidden]
           ,[IsDisabled]
           ,[SettingLevel]
           ,[DisplayOrder]
           ,[SettingStatus]
           ,[IntervalValue]
           ,[RealProductId]
           ,[MaxChoice]
           ,[Parent_ProductSettingID]
           ,[Child_DisplayOrder]
           ,[SubType]
FROM T		   
GO

WITH T AS (
SELECT 	2	SettingType,	43	SportType,	1	BetType,	1	GroupID,	151	GroupType,	2	GroupTypeOrder,	NULL	SubGroupID,	NULL	SubGroupOrder,	0	CreationStatus,	1	DisplayType,	13 Child_DisplayOrder
UNION ALL SELECT 	2	,	44	,	3	,	1	,	151	,	2	,	NULL	,	NULL	,	0	,	1	,	14
UNION ALL SELECT 	1	,	43	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	54
UNION ALL SELECT 	1	,	43	,	2	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	55
UNION ALL SELECT 	1	,	43	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	56
UNION ALL SELECT 	1	,	43	,	10	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	57
UNION ALL SELECT 	1	,	43	,	20	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	58
UNION ALL SELECT 	1	,	43	,	9999	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	59
UNION ALL SELECT 	1	,	44	,	1	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	60
UNION ALL SELECT 	1	,	44	,	3	,	1	,	153	,	4	,	1	,	1	,	0	,	2	,	61
UNION ALL SELECT 	23	,	202	,	1501	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	2
UNION ALL SELECT 	23	,	169	,	3611	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	3
UNION ALL SELECT 	23	,	220	,	1024	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	1
UNION ALL SELECT 	23	,	222	,	4901	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	4
UNION ALL SELECT 	2	,	9908	,	1201	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	5
UNION ALL SELECT 	23	,	161	,	81	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	6
UNION ALL SELECT 	23	,	164	,	8101	,	2	,	154	,	1	,	NULL	,	NULL	,	0	,	3	,	7
UNION ALL SELECT 	18	,	169	,	3611	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	3
UNION ALL SELECT 	18	,	220	,	1024	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	1
UNION ALL SELECT 	18	,	222	,	4901	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	4
UNION ALL SELECT 	1	,	9908	,	1201	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	5
UNION ALL SELECT 	18	,	202	,	1501	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	2
UNION ALL SELECT 	18	,	161	,	81	,	2	,	153	,	2	,	2	,	1	,	0	,	2	,	6
UNION ALL SELECT 	19	,	211	,	2401	,	3	,	156	,	1	,	3	,	1	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	244	,	3001	,	3	,	156	,	1	,	3	,	1	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	170	,	3701	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	225	,	5601	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	233	,	3401	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	239	,	3501	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	241	,	3300	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	242	,	3201	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	19	,	243	,	3101	,	3	,	156	,	1	,	4	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	211	,	2401	,	3	,	153	,	2	,	5	,	1	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	244	,	3001	,	3	,	153	,	2	,	5	,	1	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	170	,	3701	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	225	,	5601	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	233	,	3401	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	239	,	3501	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	241	,	3300	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	242	,	3201	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	243	,	3101	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	1	,	171	,	3801	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	1	,	200	,	1611	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	1	,	9906	,	4001	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	208	,	2101	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL	
UNION ALL SELECT 	18	,	176	,	8201	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	224	,	5500	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
UNION ALL SELECT 	18	,	245	,	4601	,	3	,	153	,	2	,	6	,	2	,	0	,	2	,	NULL
)
UPDATE p
SET GroupID = t.GroupID,
	GroupType = t.GroupType,
	GroupTypeOrder = t.GroupTypeOrder,
	SubGroupID = t.SubGroupID,
	SubGroupOrder = t.SubGroupOrder,
	CreationStatus = t.CreationStatus,
	DisplayType = t.DisplayType,
	Child_DisplayOrder = t.Child_DisplayOrder
FROM ProductSettingDetail p WITH(UPDLOCK)
	INNER JOIN T ON p.SportType = t.SportType
					AND p.Bettype = t.Bettype
					AND p.SettingType = t.SettingType
GO

--update subtype for Virtual Sports
UPDATE  ProductSettingDetail WITH(UPDLOCK)
SET SubType = 1
WHERE SportType = 9908
	AND Bettype = 1201
	AND SettingType = 2
GO

UPDATE ProductSettingDetail WITH(UPDLOCK)
SET CreationStatus = SettingStatus
WHERE GroupID IS NULL
GO