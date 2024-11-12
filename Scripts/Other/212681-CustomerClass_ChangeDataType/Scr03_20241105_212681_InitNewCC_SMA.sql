/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241105
	Task: Apply new range CC for SMA  [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

-- Init new CC
INSERT INTO CategoryConfig 
	  ([CategoryID], [CategoryName], [OfferDeposit], [CustomerClass], [CategoryNameCS], [HiddenSite])
	  SELECT 32707,		'Robot User',				0,		30000,		N'机械玩家',					0--,		'121100'
UNION SELECT 32700,		'Group Betting',			0,		30000,		N'群组投注',					0--,		'120100'
UNION SELECT 32702,		'Arbitrage',				0,		30000,		N'打水套利',					0--,		'120300'
UNION SELECT 32704,		'Irrigation Bet',			0,		30000,		N'灌水投注',					0--,		'120500'
UNION SELECT 32703,		'Fixed Game',				0,		30000,		N'内定赛事',					0--,		'120400'
UNION SELECT 32705,		'Formula Bet',				0,		30000,		N'系统计算投注',				0--,		'120600'
UNION SELECT 32701,		'Hedging',					0,		30000,		N'出货群组',					0--,		'120200'
UNION SELECT 32706,		'Info Bet',					0,		30000,		N'资讯单',					0--,		'120800'
UNION SELECT 32715,		'Robot User (Losing)',		0,		31000,		N'机械玩家 (输钱)',			0--,		'126100'
UNION SELECT 32708,		'Group Betting (Losing)',	0,		31000,		N'群组投注 (输钱)',			0--,		'125100'
UNION SELECT 32710,		'Arbitrage (Losing)',		0,		31000,		N'打水套利 (输钱)',			0--,		'125300'
UNION SELECT 32712,		'Irrigation Bet (Losing)',	0,		31000,		N'灌水投注 (输钱)',			0--,		'125500'
UNION SELECT 32711,		'Fixed Game (Losing)',		0,		31000,		N'内定赛事 (输钱)',			0--,		'125400'
UNION SELECT 32713,		'Formula Bet (Losing)',		0,		31000,		N'机械/系统计算投注 (输钱)',	0--,		'125600'
UNION SELECT 32709,		'Hedging (Losing)',			0,		31000,		N'出货群组 (输钱)',			0--,		'125200'
UNION SELECT 32714,		'Info Bet (Losing)',		0,		31000,		N'资讯单投注 (输钱)',			0--,		'125800'
GO