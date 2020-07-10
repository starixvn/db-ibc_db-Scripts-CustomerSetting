/*
	Created: 20200710@Johnson
	Task: update global PP setting for HKK 
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpSetting (GameTypeID INT, MinStake MONEY, MaxStake MONEY, MinLabel MONEY, MaxLabel MONEY)

INSERT INTO #tmpSetting(GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
SELECT 	4138	,	1.5	,	450	,	'1.50'	,	'450.00'	--	3 Genie Wishes
UNION ALL SELECT 	4117	,	0.75	,	225	,	'0.75'	,	'225.00'	--	3 Kingdoms - Battle of Red Cliffs
UNION ALL SELECT 	4197	,	0.54	,	27	,	'0.54'	,	'27.00'	--	5 Lions Gold™
UNION ALL SELECT 	4166	,	1.5	,	90	,	'1.50'	,	'90.00'	--	5 Lions™
UNION ALL SELECT 	4107	,	0.21	,	63	,	'0.21'	,	'63.00'	--	7 Monkeys
UNION ALL SELECT 	4106	,	0.21	,	4.2	,	'0.21'	,	'4.20'	--	7 Piggies™
UNION ALL SELECT 	4111	,	0.6	,	12	,	'0.60'	,	'12.00'	--	8 Dragons™
UNION ALL SELECT 	4101	,	0.03	,	300	,	'0.03'	,	'300.00'	--	888 Dragons™
UNION ALL SELECT 	4105	,	0.15	,	60	,	'0.15'	,	'60.00'	--	888 Gold™
UNION ALL SELECT 	4157	,	1.5	,	300	,	'1.50'	,	'300.00'	--	Aladdin's Treasure
UNION ALL SELECT 	4161	,	0.3	,	45	,	'0.30'	,	'45.00'	--	Ancient Egypt
UNION ALL SELECT 	4167	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Asgard™
UNION ALL SELECT 	4140	,	1.2	,	120	,	'1.20'	,	'120.00'	--	Beowulf
UNION ALL SELECT 	4224	,	0.75	,	150	,	'0.75'	,	'150.00'	--	Bronco Spirit™
UNION ALL SELECT 	4123	,	0.6	,	60	,	'0.60'	,	'60.00'	--	Busy Bees™
UNION ALL SELECT 	4185	,	0.75	,	15	,	'0.75'	,	'15.00'	--	Caishen’s Cash™
UNION ALL SELECT 	4119	,	1.14	,	114	,	'1.14'	,	'114.00'	--	Caishen’s Gold™
UNION ALL SELECT 	4118	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Chilli Heat
UNION ALL SELECT 	4125	,	0.45	,	90	,	'0.45'	,	'90.00'	--	Crazy 7s™
UNION ALL SELECT 	4126	,	0.39	,	195	,	'0.39'	,	'195.00'	--	Devil's 13™
UNION ALL SELECT 	4109	,	0.45	,	90	,	'0.45'	,	'90.00'	--	Diamond Strike™
UNION ALL SELECT 	4103	,	0.09	,	180	,	'0.09'	,	'180.00'	--	Diamonds are Forever 3 Lines
UNION ALL SELECT 	4115	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Dragon Kingdom
UNION ALL SELECT 	4155	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Dwarven Gold
UNION ALL SELECT 	4142	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Dwarven Gold Deluxe
UNION ALL SELECT 	4183	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Egyptian Fortunes™
UNION ALL SELECT 	4182	,	0.3	,	6	,	'0.30'	,	'6.00'	--	Extra Juicy™
UNION ALL SELECT 	4110	,	0.45	,	45	,	'0.45'	,	'45.00'	--	Fairytale Fortune™
UNION ALL SELECT 	4164	,	0.21	,	252	,	'0.21'	,	'252.00'	--	Fire 88™
UNION ALL SELECT 	4124	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Fruity Blast™
UNION ALL SELECT 	4227	,	0.3	,	300	,	'0.30'	,	'300.00'	--	Fu Fu Fu™
UNION ALL SELECT 	4153	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Glorious Rome
UNION ALL SELECT 	4160	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Gold Rush™
UNION ALL SELECT 	4104	,	0.09	,	180	,	'0.09'	,	'180.00'	--	Gold Train™
UNION ALL SELECT 	4180	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Golden Pig™
UNION ALL SELECT 	4156	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Great Reef
UNION ALL SELECT 	4169	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Great Rhino™
UNION ALL SELECT 	4137	,	1.5	,	300	,	'1.50'	,	'300.00'	--	Hercules Son of Zeus
UNION ALL SELECT 	4152	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Hockey League
UNION ALL SELECT 	4144	,	0.27	,	54	,	'0.27'	,	'54.00'	--	Hockey League Wild Match
UNION ALL SELECT 	4193	,	0.27	,	270	,	'0.27'	,	'270.00'	--	Hot Chilli™
UNION ALL SELECT 	4116	,	0.75	,	22.5	,	'0.75'	,	'22.50'	--	Hot Safari
UNION ALL SELECT 	4134	,	0.09	,	90	,	'0.09'	,	'90.00'	--	Irish Charms™
UNION ALL SELECT 	4194	,	0.6	,	24	,	'0.60'	,	'24.00'	--	John Hunter and the Aztec Treasure™
UNION ALL SELECT 	4198	,	0.75	,	22.5	,	'0.75'	,	'22.50'	--	John Hunter and the Tomb of the Scarab Queen™
UNION ALL SELECT 	4163	,	0.15	,	225	,	'0.15'	,	'225.00'	--	Joker's Jewels™
UNION ALL SELECT 	4113	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Journey to the West
UNION ALL SELECT 	4132	,	1.5	,	15	,	'1.50'	,	'15.00'	--	Jurassic Giants™
UNION ALL SELECT 	4146	,	0.45	,	90	,	'0.45'	,	'90.00'	--	KTV
UNION ALL SELECT 	4112	,	1.2	,	60	,	'1.20'	,	'60.00'	--	Lady Godiva
UNION ALL SELECT 	4145	,	0.39	,	195	,	'0.39'	,	'195.00'	--	Lady of the Moon
UNION ALL SELECT 	4175	,	0.6	,	45	,	'0.60'	,	'45.00'	--	Leprechaun Carol™
UNION ALL SELECT 	4171	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Leprechaun Song™
UNION ALL SELECT 	4141	,	1.5	,	300	,	'1.50'	,	'300.00'	--	Lucky Dragons
UNION ALL SELECT 	4122	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Lucky New Year
UNION ALL SELECT 	4168	,	0.3	,	150	,	'0.30'	,	'150.00'	--	Madame Destiny™
UNION ALL SELECT 	4173	,	0.27	,	135	,	'0.27'	,	'135.00'	--	Master Chen's Fortune™
UNION ALL SELECT 	4158	,	1.5	,	300	,	'1.50'	,	'300.00'	--	Mighty Kong
UNION ALL SELECT 	4129	,	0.15	,	60	,	'0.15'	,	'60.00'	--	Money Roll™
UNION ALL SELECT 	4108	,	0.27	,	135	,	'0.27'	,	'135.00'	--	Monkey Madness™
UNION ALL SELECT 	4195	,	0.75	,	30	,	'0.75'	,	'30.00'	--	Monkey Warrior™
UNION ALL SELECT 	4176	,	0.75	,	22.5	,	'0.75'	,	'22.50'	--	Mustang Gold™
UNION ALL SELECT 	4128	,	0.75	,	37.5	,	'0.75'	,	'37.50'	--	Panda's Fortune™
UNION ALL SELECT 	4133	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Panther Queen™
UNION ALL SELECT 	4120	,	1.5	,	150	,	'1.50'	,	'150.00'	--	Pixie Wings™
UNION ALL SELECT 	4135	,	1.5	,	45	,	'1.50'	,	'45.00'	--	Queen of Atlantis™
UNION ALL SELECT 	4136	,	0.75	,	150	,	'0.75'	,	'150.00'	--	Queen of Gold™
UNION ALL SELECT 	4143	,	0.75	,	225	,	'0.75'	,	'225.00'	--	Romeo and Juliet
UNION ALL SELECT 	4178	,	1.5	,	150	,	'1.50'	,	'150.00'	--	Safari King™
UNION ALL SELECT 	4162	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Santa
UNION ALL SELECT 	4127	,	0.6	,	60	,	'0.60'	,	'60.00'	--	Spooky Fortune™
UNION ALL SELECT 	4147	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Sugar Rush
UNION ALL SELECT 	4148	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Sugar Rush Summer Time
UNION ALL SELECT 	4149	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Sugar Rush Valentine's Day
UNION ALL SELECT 	4150	,	0.6	,	300	,	'0.60'	,	'300.00'	--	Sugar Rush Winter
UNION ALL SELECT 	4159	,	0.27	,	135	,	'0.27'	,	'135.00'	--	The Catfather
UNION ALL SELECT 	4139	,	0.27	,	54	,	'0.27'	,	'54.00'	--	The Catfather Part II
UNION ALL SELECT 	4165	,	0.75	,	150	,	'0.75'	,	'150.00'	--	The Champions™
UNION ALL SELECT 	4184	,	0.6	,	30	,	'0.60'	,	'30.00'	--	The Dog House™
UNION ALL SELECT 	4191	,	0.6	,	36	,	'0.60'	,	'36.00'	--	The Great Chicken Escape™
UNION ALL SELECT 	4179	,	0.54	,	27	,	'0.54'	,	'27.00'	--	Treasure Horse™
UNION ALL SELECT 	4190	,	0.03	,	75	,	'0.03'	,	'75.00'	--	Tree of Riches™
UNION ALL SELECT 	4177	,	0.15	,	300	,	'0.15'	,	'300.00'	--	Triple Dragons™
UNION ALL SELECT 	4196	,	0.15	,	150	,	'0.15'	,	'150.00'	--	Triple Jokers™
UNION ALL SELECT 	4102	,	0.75	,	300	,	'0.75'	,	'300.00'	--	Triple Tigers™
UNION ALL SELECT 	4192	,	0.3	,	150	,	'0.30'	,	'150.00'	--	Vampires vs Wolves™
UNION ALL SELECT 	4174	,	0.6	,	60	,	'0.60'	,	'60.00'	--	Vegas Magic™
UNION ALL SELECT 	4130	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Vegas Nights™
UNION ALL SELECT 	4181	,	0.75	,	45	,	'0.75'	,	'45.00'	--	Wild Gladiators™
UNION ALL SELECT 	4131	,	0.75	,	150	,	'0.75'	,	'150.00'	--	Wild Spells™
UNION ALL SELECT 	4114	,	0.75	,	75	,	'0.75'	,	'75.00'	--	Wolf Gold™

DECLARE @StakeLevelID INT

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID = 4101 
	AND exchangeid = 67

UPDATE s
SET s.MinStake = t.MinStake,
	s.MaxStake = t.MaxStake,
	s.MinLabel = t.MinLabel,
	s.MaxLabel = t.MaxLabel
FROM StakeLevelGroupDetail s WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting t ON s.GameTypeID = t.GameTypeID
WHERE s.StakeLevelID = @StakeLevelID	





