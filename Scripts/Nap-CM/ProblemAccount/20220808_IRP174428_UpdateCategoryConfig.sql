/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220808@Elodie
	Task: Update category config [redmine:#174428]
	DB: DBCUST/CustDB
*/

WITH T AS (
	SELECT 92 as CategoryID, N'Group Betting (Losing)' as CategoryName, N'群组投注 (输钱)' as CategoryNameCS
	UNION SELECT 94, 'Arbitrage (Losing)', N'打水套利 (输钱)'
	UNION SELECT 98, 'Irrigation Bet (Losing)', N'灌水投注 (输钱)'
	UNION SELECT 95, 'Fixed Game (Losing)', N'内定赛事 (输钱)'
	UNION SELECT 99, 'Formula Bet (Losing)', N'机械/系统计算投注 (输钱)'
	UNION SELECT 93, 'Hedging (Losing)', N'出货群组 (输钱)'
	--UNION SELECT 58, 'AB Bet (Losing)', N'AB投注 (输钱)'

	UNION SELECT 100, 'Bonus Hunter (Losing)', N'赏金猎人 (输钱)'
	UNION SELECT 102, 'Info Bet (Losing)', N'资讯单投注 (输钱)'
	UNION SELECT 163, 'Robot User',	N'机械玩家'
	UNION SELECT 164, 'Robot User (Losing)', N'机械玩家 (输钱)'
	--UNION SELECT 93	, 'BA User', N'BA 用戶'
	--UNION SELECT 94	, 'VIP (Licensee)',	N'VIP会员（问题会员)'
	--UNION SELECT 95	, 'VIP (Licensee)',	N'VIP会员（问题会员)'
	
)
UPDATE c
SET c.CategoryName = t.CategoryName,
	c.CategoryNameCS = t.CategoryNameCS
FROM CategoryConfig c WITH(ROWLOCK)
	INNER JOIN T ON c.CategoryID = t.CategoryID

SELECT * FROM CategoryConfig 