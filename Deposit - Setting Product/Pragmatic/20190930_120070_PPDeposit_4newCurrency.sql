/*
	Date: 2019-09-30
	Created: Winnie
	Task: add global setting for cash #120070  4 new currency 
	DB: DBCUST/CUSTDB
*/
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
CREATE TABLE #tmp1(
	[Game ] [varchar](50) NULL,
	[Min] [varchar](50) NULL,
	[Max] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'7 Monkeys', N'0.07', N'7.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'7 Piggies', N'0.07', N'0.70')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'8 Dragons', N'0.20', N'4.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'3 Kingdoms - Battle of Red Cliffs', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'888 Dragons', N'0.10', N'40.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'888 Gold', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Caishen’s Gold', N'0.38', N'22.80')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Diamond Strike', N'0.15', N'22.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Diamonds are Forever 3 Lines', N'0.03', N'9.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Dragon Kingdom', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Gold Train', N'0.03', N'30.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Journey to the West', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Pixie Wings', N'0.50', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'triple-tigers', N'0.10', N'40.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Wolf Gold', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'chilli-heat', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'fairytale-fortune', N'0.15', N'7.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'mad-monkey', N'0.09', N'9.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Hot Safari', N'0.25', N'7.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Lady Godiva', N'0.20', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'aztec-gems', N'0.05', N'80.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'lucky-new-year', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Lady of the Moon', N'0.13', N'26.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Crazy 7s', N'0.15', N'22.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Devil''s 13', N'0.13', N'26.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Fruity Blast', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Queen of Gold', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'The Catfather', N'0.09', N'9.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Magic Crystals (243 ways)', N'0.30', N'30.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Busy Bees', N'0.20', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Hockey League Wild Match', N'0.09', N'6.30')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Spooky Fortune', N'0.20', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Glorious Rome', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Panther Queen', N'0.25', N'7.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'3 Genie Wishes', N'0.50', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Money Roll', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Aladdin''s Treasure', N'0.50', N'25.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'KTV', N'0.15', N'22.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Hockey League', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Irish Charms', N'0.03', N'9.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Mighty Kong', N'0.50', N'25.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Romeo and Juliet', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Santa', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Summer Time', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Valentine''s Day', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Winter', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Tales of Egypt', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'fire88', N'0.07', N'28.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Dwarven Gold Deluxe', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'gold-rush', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Wild Spells', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Vegas Nights', N'0.25', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'jokers-jewel', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'The Catfather Part II', N'0.30', N'6.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Ancient Egypt', N'0.10', N'6.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Beowulf', N'0.40', N'8.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Hercules Son of Zeus', N'0.50', N'25.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Lucky Dragons', N'0.50', N'25.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Dwarven Gold', N'0.25', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Great Reef', N'0.25', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Jurassic Giants (4096 ways)', N'0.50', N'5.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Panda’s Fortune', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Queen of Atlantis (1024 ways)', N'0.50', N'5.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'The Champions', N'0.25', N'12.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'5 Lions', N'0.50', N'5.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Asgard', N'0.25', N'50.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Madame Destiny', N'0.10', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Great Rhino', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Jade Butterfly', N'0.30', N'30.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Leprechaun Song', N'0.20', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Peking Luck', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Da Vinci''s Treasure', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Master Chen''s Fortune', N'0.09', N'9.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Vegas Magic', N'0.20', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Leprechaun Carol', N'0.20', N'6.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Mustang Gold', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Triple Dragons', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Safari King', N'0.50', N'25.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Treasure Horse', N'0.18', N'4.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Golden Pig', N'0.25', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Wild Gladiator', N'0.25', N'5.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Extra Juicy', N'0.10', N'1.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Egyptian Fortunes', N'0.20', N'48.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'The Dog House', N'0.20', N'4.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Caishen Cash', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Sweet Bonanza', N'0.20', N'2.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Super Joker', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'John Hunter and the Tomb of the Scarab Queen', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Tree of Riches', N'0.10', N'10.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'The Great Chicken Escape', N'0.20', N'4.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Vampires vs Wolves', N'0.10', N'20.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Hot Chilli', N'0.09', N'27.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'John Hunter and the Aztec Treasure', N'0.20', N'2.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Monkey Warrior', N'0.25', N'2.50')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'Triple Joker', N'0.05', N'15.00')
INSERT #tmp1 ([Game ], [Min], [Max]) VALUES (N'5 Lions Gold', N'0.18', N'4.50')


INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT  t.typeID,41,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp1 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON t.typenamee Like a.[Game ] +'%' 
WHERE t.typenamee NOT IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')
UNION
SELECT  t.typeID,41,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp1 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON a.[Game ]  Like  t.typenamee +'%'
WHERE t.typenamee NOT IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')
UNION
SELECT  t.typeID,41,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp1 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON a.[Game ]  =  t.typenamee 
WHERE t.typenamee IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')

DROP TABLE #tmp1
	
;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							
DROP TABLE #tmpStake
----------------------------------
CREATE TABLE #tmpStake(GameTypeID INT,ExchangeID INT,MinLabel VARCHAR(200),MaxLabel VARCHAR(200),MinStake DECIMAL(19,8),MaxStake DECIMAL(19,8))
CREATE TABLE #tmp3(
	[Game ] [varchar](50) NULL,
	[Min] [varchar](50) NULL,
	[Max] [varchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'7 Monkeys', N'0.42', N'42.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'7 Piggies', N'0.42', N'4.20')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'8 Dragons', N'1.20', N'24.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'3 Kingdoms - Battle of Red Cliffs', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'888 Dragons', N'0.60', N'240.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'888 Gold', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Caishen’s Gold', N'2.28', N'136.80')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Diamond Strike', N'0.90', N'135.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Diamonds are Forever 3 Lines', N'0.18', N'54.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Dragon Kingdom', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Gold Train', N'0.18', N'180.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Journey to the West', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Pixie Wings', N'3.00', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'triple-tigers', N'0.60', N'240.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Wolf Gold', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'chilli-heat', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'fairytale-fortune', N'0.90', N'45.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'mad-monkey', N'0.54', N'54.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Hot Safari', N'1.50', N'45.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Lady Godiva', N'1.20', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'aztec-gems', N'0.30', N'480.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'lucky-new-year', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Lady of the Moon', N'0.78', N'156.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Crazy 7s', N'0.90', N'135.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Devil''s 13', N'0.78', N'156.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Fruity Blast', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Queen of Gold', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'The Catfather', N'0.54', N'54.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Magic Crystals (243 ways)', N'1.80', N'180.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Busy Bees', N'1.20', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Hockey League Wild Match', N'0.54', N'37.80')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Spooky Fortune', N'1.20', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Glorious Rome', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Panther Queen', N'1.50', N'45.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'3 Genie Wishes', N'3.00', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Money Roll', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Aladdin''s Treasure', N'3.00', N'150.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'KTV', N'0.90', N'135.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Hockey League', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Irish Charms', N'0.18', N'54.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Mighty Kong', N'3.00', N'150.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Romeo and Juliet', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Santa', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Summer Time', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Valentine''s Day', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Sugar Rush Winter', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Tales of Egypt', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'fire88', N'0.42', N'168.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Dwarven Gold Deluxe', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'gold-rush', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Wild Spells', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Vegas Nights', N'1.50', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'jokers-jewel', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'The Catfather Part II', N'1.80', N'36.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Ancient Egypt', N'0.60', N'36.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Beowulf', N'2.40', N'48.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Hercules Son of Zeus', N'3.00', N'150.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Lucky Dragons', N'3.00', N'150.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Dwarven Gold', N'1.50', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Great Reef', N'1.50', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Jurassic Giants (4096 ways)', N'1.00', N'10.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Panda’s Fortune', N'1.50', N'15.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Queen of Atlantis (1024 ways)', N'3.00', N'30.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'The Champions', N'1.50', N'75.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'5 Lions', N'3.00', N'30.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Asgard', N'1.50', N'300.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Madame Destiny', N'0.60', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Great Rhino', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Jade Butterfly', N'1.80', N'180.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Leprechaun Song', N'1.20', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Peking Luck', N'1.50', N'15.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Da Vinci''s Treasure', N'0.50', N'5.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Master Chen''s Fortune', N'0.54', N'54.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Vegas Magic', N'1.20', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Leprechaun Carol', N'1.20', N'36.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Mustang Gold', N'1.50', N'15.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Triple Dragons', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Safari King', N'3.00', N'150.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Treasure Horse', N'1.08', N'27.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Golden Pig', N'1.50', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Wild Gladiator', N'1.50', N'30.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Extra Juicy', N'0.20', N'2.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Egyptian Fortunes', N'1.20', N'288.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'The Dog House', N'1.20', N'24.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Caishen Cash', N'1.00', N'10.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Sweet Bonanza', N'0.80', N'8.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Super Joker', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'John Hunter and the Tomb of the Scarab Queen', N'1.00', N'10.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Tree of Riches', N'0.60', N'60.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'The Great Chicken Escape', N'1.20', N'24.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Vampires vs Wolves', N'0.60', N'120.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Hot Chilli', N'0.54', N'162.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'John Hunter and the Aztec Treasure', N'0.80', N'8.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Monkey Warrior', N'1.50', N'15.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'Triple Joker', N'0.30', N'90.00')
INSERT #tmp3 ([Game ], [Min], [Max]) VALUES (N'5 Lions Gold', N'1.08', N'27.00')

INSERT INTO #tmpStake (GameTypeID ,ExchangeID ,MinLabel,MaxLabel ,MinStake ,MaxStake)
SELECT  t.typeID,e.ExchangeID,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp3 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON t.typenamee Like a.[Game ] +'%' 
	CROSS APPLY  Exchange e WITH(NOLOCK) 
WHERE t.typenamee NOT IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')
	AND Code IN('DKK','SEK','NOK')
UNION
SELECT  t.typeID,e.ExchangeID,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp3 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON a.[Game ]  Like  t.typenamee +'%'
	CROSS APPLY  Exchange e WITH(NOLOCK) 
WHERE t.typenamee NOT IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')
	AND Code IN('DKK','SEK','NOK')
UNION
SELECT  t.typeID,e.ExchangeID,CAST(MIN AS VARCHAR(30)),CAST(MAX AS VARCHAR(30)) ,Min,Max
FROM #tmp3 a
	INNER JOIN DBEXT.[bodb02].[dbo].[bettype] t WITH(NOLOCK) ON a.[Game ]  =  t.typenamee 
	CROSS APPLY  Exchange e WITH(NOLOCK)
WHERE t.typenamee IN('5 Lions Gold','Hockey League Wild Match','The Catfather Part II','Dwarven Gold Deluxe','Hockey League','Dwarven Gold','The Catfather')
	AND Code IN('DKK','SEK','NOK')

;WITH T AS(
SELECT s.StakeLevelID,t.* 
FROM Dep_StakeLevel s (NOLOCK)
CROSS APPLY (SELECT * FROM #tmpStake t WHERE s.ExchangeId = t.ExchangeID ) t
WHERE s.GameTypeID = 4101
)
MERGE Dep_StakeLevelGroupDetail as g 
USING t ON g.GameTypeID = t.GameTypeID AND g.StakeLevelID = t.StakeLevelID 
WHEN MATCHED THEN UPDATE SET g.MinLabel = t.MinLabel,
							g.MaxLabel = t.MaxLabel,
							g.MinStake = t.MinStake,
							g.MaxStake = t.MaxStake
WHEN NOT MATCHED THEN INSERT ([StakeLevelID]
							   ,[GameTypeID]
							   ,[MinLabel]
							   ,[MaxLabel]
							   ,[MinStake]
							   ,[MaxStake]
							   )
				VALUES(t.StakeLevelID,t.GameTypeID,t.MinLabel,t.MaxLabel,t.MinStake,t.MaxStake);	   							
DROP TABLE #tmpStake
DROP TABLE #tmp3

