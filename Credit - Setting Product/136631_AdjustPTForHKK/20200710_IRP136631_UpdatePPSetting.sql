/*
	Created: 20200710@Johnson
	Task: update global PP setting for HKK 
	DB: DBCUST/CUSTDB
*/

CREATE TABLE #tmpSetting (GameTypeID INT, MinStake MONEY, MaxStake MONEY, MinLabel MONEY, MaxLabel MONEY)

INSERT INTO #tmpSetting(GameTypeID,MinStake,MaxStake,MinLabel,MaxLabel)
SELECT 	4138	,	1.5	,	450	,	'1.5'	,	'450'	--	3 Genie Wishes
UNION ALL SELECT 	4117	,	0.75	,	225	,	'0.75'	,	'225'	--	3 Kingdoms - Battle of Red Cliffs
UNION ALL SELECT 	4197	,	0.54	,	27	,	'0.54'	,	'27'	--	5 Lions Gold™
UNION ALL SELECT 	4166	,	1.5	,	90	,	'1.5'	,	'90'	--	5 Lions™
UNION ALL SELECT 	4107	,	0.21	,	63	,	'0.21'	,	'63'	--	7 Monkeys
UNION ALL SELECT 	4106	,	0.21	,	4.2	,	'0.21'	,	'4.2'	--	7 Piggies™
UNION ALL SELECT 	4111	,	0.6	,	12	,	'0.6'	,	'12'	--	8 Dragons™
UNION ALL SELECT 	4101	,	0.03	,	300	,	'0.03'	,	'300'	--	888 Dragons™
UNION ALL SELECT 	4105	,	0.15	,	60	,	'0.15'	,	'60'	--	888 Gold™
UNION ALL SELECT 	4157	,	1.5	,	300	,	'1.5'	,	'300'	--	Aladdin's Treasure
UNION ALL SELECT 	4161	,	0.3	,	45	,	'0.3'	,	'45'	--	Ancient Egypt
UNION ALL SELECT 	4167	,	0.75	,	225	,	'0.75'	,	'225'	--	Asgard™
UNION ALL SELECT 	4140	,	1.2	,	120	,	'1.2'	,	'120'	--	Beowulf
UNION ALL SELECT 	4224	,	0.75	,	150	,	'0.75'	,	'150'	--	Bronco Spirit™
UNION ALL SELECT 	4123	,	0.6	,	60	,	'0.6'	,	'60'	--	Busy Bees™
UNION ALL SELECT 	4185	,	0.75	,	15	,	'0.75'	,	'15'	--	Caishen’s Cash™
UNION ALL SELECT 	4119	,	1.14	,	114	,	'1.14'	,	'114'	--	Caishen’s Gold™
UNION ALL SELECT 	4118	,	0.75	,	75	,	'0.75'	,	'75'	--	Chilli Heat
UNION ALL SELECT 	4125	,	0.45	,	90	,	'0.45'	,	'90'	--	Crazy 7s™
UNION ALL SELECT 	4126	,	0.39	,	195	,	'0.39'	,	'195'	--	Devil's 13™
UNION ALL SELECT 	4109	,	0.45	,	90	,	'0.45'	,	'90'	--	Diamond Strike™
UNION ALL SELECT 	4103	,	0.09	,	180	,	'0.09'	,	'180'	--	Diamonds are Forever 3 Lines
UNION ALL SELECT 	4115	,	0.75	,	225	,	'0.75'	,	'225'	--	Dragon Kingdom
UNION ALL SELECT 	4155	,	0.75	,	75	,	'0.75'	,	'75'	--	Dwarven Gold
UNION ALL SELECT 	4142	,	0.75	,	225	,	'0.75'	,	'225'	--	Dwarven Gold Deluxe
UNION ALL SELECT 	4183	,	0.6	,	300	,	'0.6'	,	'300'	--	Egyptian Fortunes™
UNION ALL SELECT 	4182	,	0.3	,	6	,	'0.3'	,	'6'	--	Extra Juicy™
UNION ALL SELECT 	4110	,	0.45	,	45	,	'0.45'	,	'45'	--	Fairytale Fortune™
UNION ALL SELECT 	4164	,	0.21	,	252	,	'0.21'	,	'252'	--	Fire 88™
UNION ALL SELECT 	4124	,	0.75	,	225	,	'0.75'	,	'225'	--	Fruity Blast™
UNION ALL SELECT 	4227	,	0.3	,	300	,	'0.3'	,	'300'	--	Fu Fu Fu™
UNION ALL SELECT 	4153	,	0.6	,	300	,	'0.6'	,	'300'	--	Glorious Rome
UNION ALL SELECT 	4160	,	0.75	,	225	,	'0.75'	,	'225'	--	Gold Rush™
UNION ALL SELECT 	4104	,	0.09	,	180	,	'0.09'	,	'180'	--	Gold Train™
UNION ALL SELECT 	4180	,	0.75	,	75	,	'0.75'	,	'75'	--	Golden Pig™
UNION ALL SELECT 	4156	,	0.75	,	75	,	'0.75'	,	'75'	--	Great Reef
UNION ALL SELECT 	4169	,	0.6	,	300	,	'0.6'	,	'300'	--	Great Rhino™
UNION ALL SELECT 	4137	,	1.5	,	300	,	'1.5'	,	'300'	--	Hercules Son of Zeus
UNION ALL SELECT 	4152	,	0.6	,	300	,	'0.6'	,	'300'	--	Hockey League
UNION ALL SELECT 	4144	,	0.27	,	54	,	'0.27'	,	'54'	--	Hockey League Wild Match
UNION ALL SELECT 	4193	,	0.27	,	270	,	'0.27'	,	'270'	--	Hot Chilli™
UNION ALL SELECT 	4116	,	0.75	,	22.5	,	'0.75'	,	'22.5'	--	Hot Safari
UNION ALL SELECT 	4134	,	0.09	,	90	,	'0.09'	,	'90'	--	Irish Charms™
UNION ALL SELECT 	4194	,	0.6	,	24	,	'0.6'	,	'24'	--	John Hunter and the Aztec Treasure™
UNION ALL SELECT 	4198	,	0.75	,	22.5	,	'0.75'	,	'22.5'	--	John Hunter and the Tomb of the Scarab Queen™
UNION ALL SELECT 	4163	,	0.15	,	225	,	'0.15'	,	'225'	--	Joker's Jewels™
UNION ALL SELECT 	4113	,	0.75	,	225	,	'0.75'	,	'225'	--	Journey to the West
UNION ALL SELECT 	4132	,	1.5	,	15	,	'1.5'	,	'15'	--	Jurassic Giants™
UNION ALL SELECT 	4146	,	0.45	,	90	,	'0.45'	,	'90'	--	KTV
UNION ALL SELECT 	4112	,	1.2	,	60	,	'1.2'	,	'60'	--	Lady Godiva
UNION ALL SELECT 	4145	,	0.39	,	195	,	'0.39'	,	'195'	--	Lady of the Moon
UNION ALL SELECT 	4175	,	0.6	,	45	,	'0.6'	,	'45'	--	Leprechaun Carol™
UNION ALL SELECT 	4171	,	0.6	,	300	,	'0.6'	,	'300'	--	Leprechaun Song™
UNION ALL SELECT 	4141	,	1.5	,	300	,	'1.5'	,	'300'	--	Lucky Dragons
UNION ALL SELECT 	4122	,	0.75	,	75	,	'0.75'	,	'75'	--	Lucky New Year
UNION ALL SELECT 	4168	,	0.3	,	150	,	'0.3'	,	'150'	--	Madame Destiny™
UNION ALL SELECT 	4173	,	0.27	,	135	,	'0.27'	,	'135'	--	Master Chen's Fortune™
UNION ALL SELECT 	4158	,	1.5	,	300	,	'1.5'	,	'300'	--	Mighty Kong
UNION ALL SELECT 	4129	,	0.15	,	60	,	'0.15'	,	'60'	--	Money Roll™
UNION ALL SELECT 	4108	,	0.27	,	135	,	'0.27'	,	'135'	--	Monkey Madness™
UNION ALL SELECT 	4195	,	0.75	,	30	,	'0.75'	,	'30'	--	Monkey Warrior™
UNION ALL SELECT 	4176	,	0.75	,	22.5	,	'0.75'	,	'22.5'	--	Mustang Gold™
UNION ALL SELECT 	4128	,	0.75	,	37.5	,	'0.75'	,	'37.5'	--	Panda's Fortune™
UNION ALL SELECT 	4133	,	0.75	,	75	,	'0.75'	,	'75'	--	Panther Queen™
UNION ALL SELECT 	4120	,	1.5	,	150	,	'1.5'	,	'150'	--	Pixie Wings™
UNION ALL SELECT 	4135	,	1.5	,	45	,	'1.5'	,	'45'	--	Queen of Atlantis™
UNION ALL SELECT 	4136	,	0.75	,	150	,	'0.75'	,	'150'	--	Queen of Gold™
UNION ALL SELECT 	4143	,	0.75	,	225	,	'0.75'	,	'225'	--	Romeo and Juliet
UNION ALL SELECT 	4178	,	1.5	,	150	,	'1.5'	,	'150'	--	Safari King™
UNION ALL SELECT 	4162	,	0.6	,	300	,	'0.6'	,	'300'	--	Santa
UNION ALL SELECT 	4127	,	0.6	,	60	,	'0.6'	,	'60'	--	Spooky Fortune™
UNION ALL SELECT 	4147	,	0.6	,	300	,	'0.6'	,	'300'	--	Sugar Rush
UNION ALL SELECT 	4148	,	0.6	,	300	,	'0.6'	,	'300'	--	Sugar Rush Summer Time
UNION ALL SELECT 	4149	,	0.6	,	300	,	'0.6'	,	'300'	--	Sugar Rush Valentine's Day
UNION ALL SELECT 	4150	,	0.6	,	300	,	'0.6'	,	'300'	--	Sugar Rush Winter
UNION ALL SELECT 	4159	,	0.27	,	135	,	'0.27'	,	'135'	--	The Catfather
UNION ALL SELECT 	4139	,	0.27	,	54	,	'0.27'	,	'54'	--	The Catfather Part II
UNION ALL SELECT 	4165	,	0.75	,	150	,	'0.75'	,	'150'	--	The Champions™
UNION ALL SELECT 	4184	,	0.6	,	30	,	'0.6'	,	'30'	--	The Dog House™
UNION ALL SELECT 	4191	,	0.6	,	36	,	'0.6'	,	'36'	--	The Great Chicken Escape™
UNION ALL SELECT 	4179	,	0.54	,	27	,	'0.54'	,	'27'	--	Treasure Horse™
UNION ALL SELECT 	4190	,	0.03	,	75	,	'0.03'	,	'75'	--	Tree of Riches™
UNION ALL SELECT 	4177	,	0.15	,	300	,	'0.15'	,	'300'	--	Triple Dragons™
UNION ALL SELECT 	4196	,	0.15	,	150	,	'0.15'	,	'150'	--	Triple Jokers™
UNION ALL SELECT 	4102	,	0.75	,	300	,	'0.75'	,	'300'	--	Triple Tigers™
UNION ALL SELECT 	4192	,	0.3	,	150	,	'0.3'	,	'150'	--	Vampires vs Wolves™
UNION ALL SELECT 	4174	,	0.6	,	60	,	'0.6'	,	'60'	--	Vegas Magic™
UNION ALL SELECT 	4130	,	0.75	,	75	,	'0.75'	,	'75'	--	Vegas Nights™
UNION ALL SELECT 	4181	,	0.75	,	45	,	'0.75'	,	'45'	--	Wild Gladiators™
UNION ALL SELECT 	4131	,	0.75	,	150	,	'0.75'	,	'150'	--	Wild Spells™
UNION ALL SELECT 	4114	,	0.75	,	75	,	'0.75'	,	'75'	--	Wolf Gold™

DECLARE @StakeLevelID INT

SELECT @StakeLevelID = StakeLevelID
FROM StakeLevel WITH(NOLOCK)
WHERE GameTypeID = 4101 
	AND exchangeid = 67

UPDATE s
SET s.MinStake = t.MinStake,
	s.MaxStake = t.MaxStake,
	s.MinLabel = t.MinStake,
	s.MaxLabel = t.MaxStake
FROM StakeLevelGroupDetail s WITH(UPDLOCK,ROWLOCK)
	INNER JOIN #tmpSetting t ON s.GameTypeID = t.GameTypeID
WHERE s.StakeLevelID = @StakeLevelID	





