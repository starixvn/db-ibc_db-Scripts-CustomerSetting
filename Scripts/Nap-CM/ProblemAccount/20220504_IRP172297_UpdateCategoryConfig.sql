/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220504@Johnson
	Task: Update category config [redmine:#172297]
	DB: DBCUST/CustDB
*/

WITH T AS (
	SELECT 52 as CategoryID, N'Group Betting' as CategoryName, N'群组投注' as CategoryNameCS
	UNION SELECT 53, 'Hedging', N'出货群组'
	UNION SELECT 54, 'Arbitrage', N'打水套利'
	UNION SELECT 55, 'Fixed Game', N'内定赛事'
	UNION SELECT 56, 'AB Bet', N'AB投注'
	UNION SELECT 57, 'Robot Betting', N'机器人投注'
	UNION SELECT 58, 'Irrigation Bet', N'灌水投注'
	UNION SELECT 59, 'Formula Bet', N'系统计算投注'
	UNION SELECT 60	, 'Bonus Hunter', N'赏金猎人'
	UNION SELECT 61	, 'Robot User',	N'机械用户'
	UNION SELECT 92	, 'Group Betting (low)', N'群组投注 (观察中)'
	UNION SELECT 93	, 'Hedging (low)',	N'出货群组 (观察中)'
	UNION SELECT 94	, 'Arbitrage (low)',	N'打水套利 (观察中)'
	UNION SELECT 95	, 'Fixed Game (low)',	N'内定赛事 (观察中)'
	UNION SELECT 98	, 'Irrigation Bet (low)',	N'灌水投注 (观察中)'
	UNION SELECT 99	, 'Formula Bet (low)',	N'机械/系统计算投注 (观察中）'
	UNION SELECT 100, 'Bonus Hunter (low)',	N'赏金猎人 (观察中)'
	UNION SELECT 102, 'Info Bet (low)',	N'资讯单投注 (观察中)'
	UNION SELECT 162, 'Info Bet',	N'资讯单'
	UNION SELECT 163, 'Bad Robot User',	N'非正常机械玩家'
	UNION SELECT 164, 'Good Robot User', N'正常机械玩家'
)
UPDATE c
SET c.CategoryName = t.CategoryName,
	c.CategoryNameCS = t.CategoryNameCS
FROM CategoryConfig c WITH(ROWLOCK)
	INNER JOIN T ON c.CategoryID = t.CategoryID